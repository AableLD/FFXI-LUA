-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--[[
    gs c toggle luzaf -- Toggles use of Luzaf Ring on and off
    gs c toggle compensator -- Toggles use of Compensator for rolls on and off. helpful when you don't want to lose TP
    
    Right now this LUA is setup for the following modes:
    - FightingMode: 
      - Shooting
      - SingleWield
      - DualWield
    - GunMode:
      - DeathPenalty
      - Fomalhaut
      - Armageddon
      - Anarchy

    This lua assumes you have 2 macros or keybinds to cycle GunMode and FightingMode. You may not like this, but
    i find it very convenient to easily switch between weapons / modes while playing COR

    NOTE: GunMode is automatically set to whichever weapon is equipped when this lua is loaded. You can also hit F12 to update it. 

    NOTE: Cycling through Fighting Mode resets Shooting mode, and cycling through Shooting Mode resets Fighting Mode. These two modes 
    do not combine. Only one can be used at a time.  They were broken into two because I got tired of cycling through so many groups.
    NOTE: if you don't like cycles, you can do macro's for specific modes. i.e. - /console gs c set FightingMode Melee  
   
    Fighting Modes
    sets.engaged.DualWield applies when Melee or DualSword fighting modes are selected 
    sets.engaged.Sword is a single handed melee mode

    Shooting Modes
    sets.engaged  is used for all these sets.  

    Note: if you want to prevent losing TP when doing rolls, you can toggle compensator mode to off.

    Aftermath 
    - The 'AME' set is used when empyrean aftermath is up. This is currently disabled as I do not have armegeddon.

    Haste modes 
    - This LUA tracks haste buffs and adjusts the gear sets accordingly. You should adjust dual weild gear based on how much haste to maximize TP
    gain to WS. It breaks it down into 15% haste, 30% haste, and max haste.
--]]
---------------------------- SET ORDER OF PRECEDENCE ----------------------------------
-- sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups or CustomClass]
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, "Capacity Points Mode")
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    state.Compensator = M(false, "Compensator")
    state.warned = M(false)
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    state.FlurryMode = M{['description']='Flurry Mode', 'Normal', 'Hi'}
    state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Low'}
    
    state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false

    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    
    state.AutoRA = M{['description']='Auto RA', 'Disabled', 'ShootToTPOff', 'ShootToTPOn', 'ShootForever', 'WS', 'WSOnly' }
    state.GunSelector = M{['description']='Gun Selector', 'DeathPenalty', 'Fomalhaut', 'Armageddon', 'Anarchy'}
    state.FightingMode = M{['description']='Fighting Mode', 'Shooting', 'SingleWield', 'DualWield'}

    cor_sub_weapons = S{"Nusku Shield"}
    -- auto_gun_ws = "Leaden Salute"
    -- auto_gun_ws = "Hot Shot"
    -- auto_gun_ws = "Numbing Shot"
    auto_gun_ws = "Last Stand"
    auto_ws_delay = 0.5 -- seconds to wait between WS attempts during auto RA
    state.WsPaused = M(false, 'WS Paused')
    define_roll_values()
    determine_haste_group()
    get_combat_form()
    initialize_weapons()
    get_custom_ranged_groups()

end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    
    
    --[[
        Options: Override default values
    --]]

    -- OffenseMode sets the accuracy level for melee attacks.
    state.OffenseMode:options('Normal', 'Acc')
    -- RangedMode sets the accuracy level for ranged attacks.
    state.RangedMode:options('Normal', 'Acc')
    -- WeaponskillMode sets the accuracy level for weaponskills.
    state.WeaponskillMode:options('Normal', 'Acc')
    -- CastingMode sets the magic accuracy level for magic casts.
    state.CastingMode:options('Normal', 'Resistant')


    --[[
        Ammo Settings
    --]]
    gear.RAbullet = "Chrono Bullet"
    gear.Accbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"
    options.ammo_warning_limit = 50

    --[[
        Additional local binds
    --]]
    
    --[[ 
        Custom Binds
                F9: Cycle OffenseMode (Melee Accuracy Selector)
        Ctrl +  F9: Cycle RangedMode (Ranged Accuracy Selector)
        Alt  +  F9: Cycle FightingMode (Shooting vs Melee Mode Selector)
        Ctrl +  `: Double-up (useful!)
        Alt  +  `: Bolter's Roll (useful!)
        Win  +  c: Toggle Capacity Mode (keeps your capacity mantle equipped)
        Ctrl +  =: Cycle TreasureMode (Treasure Hunter Mode Selector)
        Win  +  =: Cycle FlurryMode (Flurry Mode Selector)
        Ctrl +  -: Cycle AutoRA (Auto RA Mode Selector)
        Ctrl +  d: Set AutoRA to ShootToTPOn (auto RA will only fire if TP is <= 1000)
        Alt  +  d: Set AutoRA to Disabled (auto RA will not fire)
    --]]
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind @f9 gs c cycle RangedMode')
    send_command('bind !f9 gs c cycle FightingMode')
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
	send_command('bind @c gs c toggle CapacityMode')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind @= gs c cycle FlurryMode')
    send_command('bind ^- gs c cycle AutoRA')
    send_command('bind ^d gs c set AutoRA ShootToTPOn')
    send_command('bind !d gs c set AutoRA Disabled')
    select_default_macro_book()
    set_lockstyle()
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^d')
    send_command('unbind !d')
end

-- Handle specific gear swap commands for COR.
function job_self_command(cmdParams, eventArgs)
    --[[

        Define our weapon and gun maps here. This requires you to manually change both weapons and guns
        indepedently.
        
        Usage examples:
        gs c NaegTaur
        gs c NaegNusk
        gs c Fomalhaut
        Note: The commands are not case sensitive.

        Note: Equipping a weapon set does not change your FightingMode. Be sure to select what you want!

    --]]

    local weapon_map = {}
    -- Format: {gear set, description string, type string}
    weapon_map.naegtaur   = {sets.NaegTaur,   "Main: Naegling, Sub: Tauret",           "sword-dagger"}
    weapon_map.naegglet   = {sets.NaegGlet,   "Main: Naegling, Sub: Gleti's Knife",    "sword-dagger"}
    weapon_map.naegdemers = {sets.NaegDemers, "Main: Naegling, Sub: Demersal Degen +1","sword-sword"}
    weapon_map.naegnusk   = {sets.NaegNusk,   "Main: Naegling, Sub: Nusku Shield",     "sword-shield"}
    weapon_map.kustnusk   = {sets.KustNusk,   "Main: Kustawi +1, Sub: Nusku Shield",   "dagger-shield"}
    local gun_map = {}
    gun_map.fomalhaut = {sets.Fomalhaut, "Fomalhaut"}
    gun_map.anarchy = {sets.Anarchy, "Anarchy"}
    -- gun_map.armageddon = {sets.Armageddon, "Armageddon"}
    -- gun_map.deathpenalty = {sets.DeathPenalty, "Death Penalty"}

    if cmdParams[1] ~= nil then
        local normalized_cmd = cmdParams[1]:lower()
        if weapon_map[normalized_cmd] then
            send_command("@input /echo Equipping " .. weapon_map[normalized_cmd][2])
            equip(weapon_map[normalized_cmd][1])
            if weapon_map[normalized_cmd][3] == "sword-dagger" then
                windower.send_command('input /lockstyleset 124')
            elseif weapon_map[normalized_cmd][3] == "sword-shield" then
                windower.send_command('input /lockstyleset 124')
            elseif weapon_map[normalized_cmd][3] == "dagger-shield" then
                windower.send_command('input /lockstyleset 124')
            elseif weapon_map[normalized_cmd][3] == "sword-sword" then
                windower.send_command('input /lockstyleset 124')
            end
        elseif gun_map[normalized_cmd] then
            send_command("@input /echo Equipping " .. gun_map[normalized_cmd][2])
            state.GunSelector:set(gun_map[normalized_cmd][2])
            equip(gun_map[normalized_cmd][1])
        end
    end
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- AF/Relic/Empy Setup
    --------------------------------------
    -- Start Artifact
    Laksamana_Head = "Laksamana's Tricorne +2" -- Maybe worth upgrading for QD MEVA and M.Acc
    Laksamana_Body = "Laksamana's Frac +2" 
    -- End Artifact (Other pieces on slip)
    -- Start Relic
    Lanun_Head = "Lanun Tricorne +4"
    Lanun_Body = "Lanun Frac +4"
    Lanun_Hands = "Lanun Gants +1" 
    Lanun_Legs = "Lanun Trews +1"
    Lanun_Feet = "Lanun Bottes +3"
    -- End Relic (Other pieces on slip)
    -- Start Empy
    Chasseur_Head = "Chasseur's Tricorne +2" 
    Chasseur_Body = "Chasseur's Frac +3" 
    Chasseur_Hands = "Chasseur's Gants +3" 
    Chasseur_Legs = "Chasseur's Culottes +3" 
    Chasseur_Feet = "Chasseur's Bottes +3" 
    Chasseur_Earring = "Chasseur's Earring +1"
    -- End Empy

    --------------------------------------
    -- Other items we may upgrade directly
    --------------------------------------
    cor_jse_neck = "Commodore Charm +1"
    weather_obi = "Anrin Obi" -- TODO: Get the all weather obi
    capacity_mantle = "Mecistopins mantle"

    --------------------------------------
    -- JSE Capes
    -- We have Camulus mantles (Ambu cape) for a variety of uses.
    --------------------------------------
    Camulus = {}

    Camulus.MAB  =  { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}}

    Camulus.WSD =   { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}}
    
    Camulus.DualWieldWSD = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+	6','Weapon skill damage +10%',}}

    Camulus.Snap =  { name="Camulus's Mantle", augments={'"Snapshot"+10',}}

    Camulus.DW  =  { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}}

    --------------------------------------
    -- Herculean Gear (TH, MAB, etc)
    -- Note: This used to be BIS for various COR things, but we slowly replace with ODY and Sortie gear.
    -- As we replace this, we'll delete the entries.
    --------------------------------------
    HercHead = {}   -- Used for: [fast cast, curing waltz]
    HercBody = {}   -- No longer in use
    HercHands = {}  -- Used for: [magic WS, TH, curing waltz]
    HercLegs = {}   -- Used for: [magic WS, TH]
    HercFeet = {}   -- No longer in use

    HercHead.FC = { name="Herculean Helm", augments={'"Conserve MP"+7','"Fast Cast"+3','"Treasure Hunter"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}

    HercHead.Waltz = {name="Herculean Helm", augments={'"Conserve MP"+7','"Fast Cast"+3','"Treasure Hunter"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}

    HercHead.TH = {name="Herculean Helm", augments={'"Conserve MP"+7','"Fast Cast"+3','"Treasure Hunter"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}

    HercHands.Waltz = { name="Herculean Gloves", augments={'Accuracy+10','"Waltz" potency +9%','Attack+14',}}

    HercLegs.TH = { name="Herculean Trousers", augments={'Attack+28','"Mag.Atk.Bns."+2','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Weapon Sets
    sets.NaegTaur = {
        main = "Naegling",
        sub = "Tauret",
    }
    sets.NaegGlet = {
        main = "Naegling",
        sub = "Gleti's Knife",
    }
    sets.NaegDemers = {
        main = "Naegling",
        sub = "Demersal Degen +1",
    }
    sets.NaegNusk = {
        main = "Naegling",
        sub = "Nusku Shield",
    }
    sets.TauretGlet = {
        main = "Tauret",
        sub = "Gleti's Knife",
    }
    sets.KustNusk = {
        main = "Kustawi +1",
        sub = "Nusku Shield",
    }
    -- Gun Sets
    sets.DeathPenalty = {
        range="Death Penalty"
    }
    sets.Armageddon = {
        range="Armageddon"
    }
    sets.Fomalhaut = {
        range="Fomalhaut"
    }
    sets.Anarchy = {
        range="Anarchy +2"
    }
    -- Other sets
    sets.Obi = { waist=weather_obi }

    -- Precast sets to enhance JAs
    -- Triple shot: The Chasseur body needs to be on during shots while triple shot is active, but does not need
    -- to be equipped when we use the job ability.
    sets.precast.JA['Wild Card'] = {feet=Lanun_Feet}
    sets.precast.JA['Random Deal'] = {body=Lanun_Body}
    sets.precast.JA['Snake Eye'] = {legs=Lanun_Legs}
    sets.precast.JA['Fold'] = {hands=Lanun_Hands} 
    sets.CapacityMantle = {back=capacity_mantle}

    sets.TP = {}
    
    -- TODO: Delete this and make smarter DT sets now that we live in a post-sortie world.
    sets.Nyame = {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    }
    
    sets.TreasureHunter = {
        head=HercHead.TH,
        legs=HercLegs.TH,
        waist="Chaac Belt",
    }

    -- Base precast for all corsair rolls. 
    -- We use the idle set as base for -DT and regen/regain, then add in any roll+ and roll duration+ gear.
    -- If we had a Rostam, this is where it would go (eat the rich).
    sets.precast.CorsairRoll = set_combine(sets.idle,{ 
        head=Lanun_Head,
        hands=Chasseur_Hands,
        neck="Regal Necklace",
	legs="Desultor Tassets",
        back=Camulus.MAB,
	ring1="Luzaf's Ring",
    })

    -- Add specific roll gear here. This gear enhances the specific roll being used.
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs=Chasseur_Legs})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet=Chasseur_Feet})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head=Chasseur_Head})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body=Chasseur_Body})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands=Chasseur_Hands})
    
    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.Compensator = {range="Compensator"}
    sets.precast.FoldDoubleBust = {hands=Lanun_Hands}
    sets.precast.CorsairShot = { head=Laksamana_Head }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head=HercHead.Waltz,
        hands=HercHands.Waltz,
    }
    
    sets.regain = {
        neck="Rep. Plat. Medal",
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        head=HercHead.FC,
        neck="Baetyl Pendant",
        ear1="Loquacious Earring",
        ear2="Etiolation Earring",
        body="Dread Jupon",
        hands="Leyline Gloves",
        ring1="Naji's Loop",
        ring2="Kishar Ring",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
    
    --[[
    Snapshot/Rapidshot set (Precast Ranged Attacks)
    Current totals:
    - Snapshot: 45 (gear)
    - Snapshot: 55 (gear + jp)
    - Note: Snapshot cap is 70, so flurry 1 or 2 cap us.
    - Rapid shot: 28
    --]]
    sets.precast.RA = {
        ammo=gear.RAbullet,
        head="Chass. Tricorne +2",
        body="Chasseur's Frac +3",
        hands="Chasseur's Gants +3",
        legs="Chas. Culottes +3",
        feet="Chass. Bottes +3",
        neck={ name="Comm. Charm +1", augments={'Path: A',}},
        waist="Impulse Belt",
        left_ear="Telos Earring",
        right_ear="Crep. Earring",
        left_ring="Dingir Ring",
        right_ring="Crepuscular Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +            10','Weapon skill damage +10%','Damage taken-5%',}},

    }

    sets.precast.RA.F1 = set_combine(sets.precast.RA, {
        -- Replace snapshot gear with rapid shot gear here.
        -- Flurry is 15 snapshot total.
    })

    sets.precast.RA.F2 = set_combine(sets.precast.RA.F1, {
        -- Replace snapshot gear with rapid shot gear here.
        -- Flurry II is 30 snapshot total.
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo=gear.WSbullet,
        head="Nyame Helm",
        neck="Fotia Gorget",
        body="Nyame Mail",
        hands=Chasseur_Hands,
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
	ring1="Cornelia's Ring",
        ring2="Regal Ring",
        back=Camulus.WSD,
        legs="Lanun Bottes +4",
        waist="Fotia Belt",
        feet=Lanun_Feet
    }
    
    --[[
        Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    --]]
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1",
        back=Camulus.WSD,
    })

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, { 
        ring1 ="Epona's Ring",
        ring2="Regal Ring",
        back=Camulus.DA,
        legs="Meghanada Chausses +2",
    })

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
        body=Chasseur_Body,
        waist="Fotia Belt",
    })

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.WSbullet,
        head=Chasseur_Head,
        feet="Malignance Boots",
    })

    sets.precast.WS['Wildfire'] = {
    ammo="Living Bullet",
    head="Nyame Helm",
    body="Lanun Frac +4",
    hands="Chasseur's Gants +3",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +4",
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Moonshade Earring",
    left_ring="Dingir Ring",
    right_ring="Cornelia's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}},}

    sets.precast.WS['Leaden Salute'] = 
{ammo="Living Bullet",
    head="Pixie Hairpin +1",
    body="Lanun Frac +4",
    hands="Chasseur's Gants +3",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +4",
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear="Moonshade Earring",
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}},
}

    sets.precast.WS['Hot Shot'] = {
ammo="Living Bullet",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Chasseur's Gants +3",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +4",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Friomisi Earring",
    right_ear="Moonshade Earring",
    left_ring="Dingir Ring",
    right_ring="Cornelia's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}},
}
    sets.precast.WS['Aeolian Edge'] = {
    ammo="Living Bullet",
    head="Nyame Helm",
    body="Lanun Frac +4",
    hands="Chasseur's Gants +3",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +4",
    neck="Baetyl Pendant",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Moonshade Earring",
    left_ring="Dingir Ring",
    right_ring="Cornelia's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}},
}
    --[[
    Midcast Sets
    --]]
    sets.midcast.FastRecast = {
        head="Malignance Chapeau",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        back=Camulus.DW,
        ring1="Naji's Loop",
        ring2="Kishar Ring",
        legs="Malignance Tights",
        feet="Malignance Boots"
    }
        
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        head="Nyame Helm",
        neck=cor_jse_neck,
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body=Lanun_Body,
        hands="Nyame Gauntlets",
        ring1="Dingir Ring",
        back=Camulus.MAB,
        waist="Eschan Stone",
        legs="Nyame Flanchard",
        feet=Chasseur_Feet
    }

    sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot, {
        ammo=gear.QDbullet,
        head="Nyame Helm",
        neck=cor_jse_neck,
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body=Lanun_Body,
        hands="Nyame Gauntlets",
        ring1="Dingir Ring",
        back=Camulus.MAB,
        waist="Eschan Stone",
        legs="Nyame Flanchard",
        feet=Chasseur_Feet
    })

    sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot.Acc, {})
    sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot['Light Shot'], {})

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
        head="Lanun Tricorne +4",
    body="Chasseur's Frac +3",
    hands="Chasseur's Gants +3",
    legs="Chas. Culottes +3",
    feet="Chass. Bottes +3",
    neck="Iskur Gorget",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Crep. Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    sets.midcast.RA.AME = set_combine(sets.midcast.RA, {
        -- I dont have Armegeddon, so i don't need this gearset.
        -- If I did, I'd probably look at like critical hits or something.
    })


    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        --ring1="Hajduk Ring",
        ammo=gear.Accbullet,
        head="Malignance Chapeau",
        hands=Chasseur_Hands,
        neck=cor_jse_neck,
        ear1="Telos Earring",
    })

    sets.midcast.RA.TripleShot = set_combine(sets.midcast.RA, {
        -- This set has room for improvement with Oshosi gear.
        body=Chasseur_Body,
    })

    sets.midcast.RA.TripleShot.Acc = set_combine(sets.midcast.RA.Acc, {
    --     ammo=gear.Accbullet,
    --     head="Malignance Chapeau",
        body=Chasseur_Body,
    --     hands="Lanun Gants +3",
    --     --ring1="Regal Ring",
    --     feet="Malignance Boots"
    })
    

    -- Idle sets
    sets.idle = {
       head="Null Masque",
    body="Chasseur's Frac +3",
    hands="Malignance Gloves",
    legs="Chas. Culottes +3",
    feet="Malignance Boots",
    neck="Bathy Choker +1",
    waist="Null Belt",
    left_ear="Alabaster Earring",
    right_ear="Infused Earring",
    left_ring="Shneddick Ring",
    right_ring="Murky Ring",
    back="Null Shawl",
    }	
        
    sets.Kiting = {left_ring="Shneddick Ring"}

    -- Engaged sets. The default set is what it looks like when we are shooting and not expecting to melee.
    sets.engaged = set_combine(sets.idle, {
        neck="Null Loop",
        back="Null Shawl",
    })

   -- We only care about "No/Low Haste" and "Max Haste" sets for dual wielding
   -- No/Low Haste we use 41 dual wield gear, max haste we use 21 dual wield gear
    sets.engaged.DualWield = {
        head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Null Loop",
    waist="Reiki Yotai",
    right_ear="Suppanomimi",
    left_ear="Telos Earring",
    left_ring="Epona's Ring",
    right_ring="Murky Ring",
    back=Camulus.DW,
    }

    sets.engaged.DualWield.Acc = set_combine(sets.engaged.DualWield, {
        ring1 = "Regal Ring",
        ring2 = "Ilabrat Ring",
        body="Malignance Tabard",
        hands="Chasseur's Gants +3",
        feet="Malignance Boots",
    })

    sets.engaged.DualWield.MaxHaste = set_combine(sets.engaged.DualWield, {
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Petrov Ring",
        feet="Malignance Boots",
        back="Null Shawl",
    })

    sets.engaged.DualWield.Acc.MaxHaste = set_combine(sets.engaged.DualWield.MaxHaste, {
        ear2="Mache Earring +1",
        ring1 = "Regal Ring",
        ring2 = "Ilabrat Ring",
        body="Malignance Tabard",
        hands="Chasseur's Gants +3",
    })

    sets.engaged.SingleWield = {
        head="Null Masque",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Chas. Culottes +2",
        feet="Nyame Sollerets",
        neck="Null Loop",
        waist="Sailfi Belt +1",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Regal Ring",
        right_ring="Epona's Ring",
        back="Null Shawl",
    }

    sets.engaged.SingleWield.Acc = set_combine(sets.engaged.SingleWield, {
        hands="Chasseur's Gants +3",
        feet="Malignance Boots",
        left_ear="Telos Earring",
        right_ear="Mache Earring +1",
        right_ring="Ilabrat Ring",
    })
    
end

function get_cor_gearset()
    local set = {}
    if state.FightingMode.current ~= 'Default' then 
       ---------------------------------------
       set = set_combine(sets[state.FightingMode.current], sets[state.GunSelector.current])
       ---------------------------------------
    end
    return set
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' then
        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
        if player.tp >= 1000 and (state.AutoRA.value == 'WS' or state.AutoRA.value == 'WSOnly') and not buffactive.amnesia then
            if spell.action_type == 'Ranged Attack' then
                cancel_spell()
            end
            use_weaponskill()
        end
    end
end 

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)

        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
    end

    if spell.type:lower() == 'weaponskill' then
        if player.tp < 1000 then
            eventArgs.cancel = true
            return
        end
        if ((spell.target.distance >8 and spell.skill ~= 'Marksmanship') or (spell.target.distance >24)) then
            -- Cancel Action if distance is too great, saving TP
            add_to_chat(122,"Outside WS Range! /Canceling")
            eventArgs.cancel = true
            return
        
        elseif state.DefenseMode.value ~= 'None' then
            -- Don't gearswap for weaponskills when Defense is on.
            eventArgs.handled = true
        end
    end

    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.Compensator.value then
        equip(sets.precast.Compensator)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
    local gearset = get_cor_gearset()
    equip(gearset)
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Leaden Salute' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
            end
        end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' or spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if state.AutoRA.value == 'ShootToTPOn' and player.tp >= 1000 then
        add_to_chat(122, "Disabling AutoRA (TP Threshold Met)! Perform a ranged attack to re-enable.")
        state.AutoRA:set('ShootToTPOff')
    elseif state.AutoRA.value == 'ShootToTPOff' and player.tp < 1000 then
        add_to_chat(122, "Re-enabling AutoRA (Shoot to TP)! Disable AutoRA if you didn't want this.")
        state.AutoRA:set('ShootToTPOn')
        use_ra(spell)
    elseif state.AutoRA.value ~= 'Disabled' and state.AutoRA.value ~= 'WSOnly' then
        use_ra(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    local gearset = get_cor_gearset()
    return set_combine(idleSet, gearset)
end

function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    local gearset = get_cor_gearset()
    return set_combine(meleeSet, gearset)
    -- return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        get_combat_form()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if not gain and player.equipment.ring1 == 'Warp Ring' then
        equip({ring1="Warp Ring"})
    end

    -- DoubleShot CombatForm
    if (buff == 'Triple Shot' and gain or buffactive['Triple Shot']) then
        windower.send_command('wait 90;input /echo **TRIPLE SHOT OFF**;wait 210;input /echo **TRIPLE SHOT READY**')
        state.CombatForm:set('TripleShot')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        if state.CombatForm.current == 'TripleShot' then 
            state.CombatForm:reset()
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    if (( string.find(buff:lower(), 'flurry') and gain ) or buff:startswith('Aftermath')) then
        get_custom_ranged_groups()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        if player.equipment.range == 'Armageddon' then
            classes.CustomRangedGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM3 UP-------------')
            end
            if (buff == "Aftermath: Lv.2" and gain) or buffactive['Aftermath: Lv.2'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM2 UP-------------')
            end
            if (buff == "Aftermath: Lv.1" and gain) or buffactive['Aftermath: Lv.1'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM1 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomRangedGroups:clear()

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_custom_ranged_groups()
end

function get_custom_ranged_groups()
    classes.CustomRangedGroups:clear()
    -- Flurry I = 265, Flurry II = 581
    if buffactive['Flurry'] then
        if state.FlurryMode.value == 'Hi' then
            classes.CustomRangedGroups:append('F2')
        else
            classes.CustomRangedGroups:append('F1')
        end
    end

    if player.equipment.range == 'Armageddon' then
        if buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath Lv.3'] then
            classes.CustomRangedGroups:append('AME')
        end
    else
    -- relic aftermath is just "Aftermath", while empy + mythic are numbered
    -- cor has no relic, so we ignore that one
        if buffactive['Aftermath: Lv.1'] then
            classes.CustomRangedGroups:append('AM1')
        elseif buffactive['Aftermath: Lv.2'] then
            classes.CustomRangedGroups:append('AM2')
        elseif buffactive['Aftermath: Lv.3'] then
            classes.CustomRangedGroups:append('AM2')
        end
    end
end
-- Job-specific toggles.
function job_toggle_state(field)
    if field:lower() == 'luzaf' then
        state.LuzafRing:toggle()
        return "Use of Luzaf Ring", state.LuzafRing.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'RA: '..state.RangedMode.current
    if state.FightingMode.current ~= 'Default' then 
        msg = msg .. ', Fighting: '..state.FightingMode.current
    end
    -- if state.ShootingMode.current ~= 'Default' then 
    --     msg = msg .. ', Shooting: '..state.ShootingMode.current
    -- end
    msg = msg .. ', Gun: '..state.GunSelector.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end

    msg = msg .. ', Roll Sz: ' .. ((state.LuzafRing.value and 'Large') or 'Small')

    msg = msg .. ', AutoRA: '..state.AutoRA.current

    msg = msg .. ', Haste: '..state.HasteMode.current

    msg = msg .. ', Combat Form: '..state.CombatForm.current

    -- Add custom melee group display if set
    if classes.CustomMeleeGroups and #classes.CustomMeleeGroups > 0 then
        msg = msg .. ', MeleeGroup: ' .. table.concat(classes.CustomMeleeGroups, ',')
    end


    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    state.CombatForm:reset()
    if state.Buff['Triple Shot'] then
        state.CombatForm:set('TripleShot')
    end
    if state.FightingMode.current == 'DualWield' then
        state.CombatForm:set('DualWield')
    elseif state.FightingMode.current == 'SingleWield' then 
        state.CombatForm:set('SingleWield')
    end
end

function initialize_weapons()
    if player.equipment.range == 'Death Penalty' then
        state.GunSelector:set('DeathPenalty')
    elseif player.equipment.range == 'Fomalhaut' then
        state.GunSelector:set('Fomalhaut')
    elseif player.equipment.range == 'Anarchy +2' then
        state.GunSelector:set('Anarchy')
    elseif player.equipment.range == 'Armageddon' then
        state.GunSelector:set('Armageddon')
    end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
        ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
        ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
        ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
        add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
        classes.CustomMeleeGroups:append('MaxHaste')
        state.HasteMode:set('Hi')
    elseif ( buffactive.march == 2 ) or -- two marches from ghorn
        ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
        ( buffactive[580] ) or  -- geo haste
        ( buffactive[33] and buffactive[604] ) then  -- haste with MG
        add_to_chat(8, '-------------Haste 30%-------------')
        classes.CustomMeleeGroups:append('Haste_30')
        state.HasteMode:set('Low')
    elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
        add_to_chat(8, '-------------Haste 15%-------------')
        classes.CustomMeleeGroups:append('Haste_15')
    end
end

-- end

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = 'Small'
    if state.LuzafRing then
        rollsize = 'Large'
    end
    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    -- cateogry == 2  -- any ranged attack
    if (category == 2) or 
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then 
            return true
    end
end

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = (
                            player.inventory[bullet_name] or 
                            player.wardrobe[bullet_name] or 
                            player.Wardrobe2[bullet_name] or 
                            player.Wardrobe3[bullet_name] or 
                            player.Wardrobe4[bullet_name] )
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            -- eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and not state.warned
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '**** LOW AMMO WARNING: '..bullet_name..' ****'
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)
        state.warned = true
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned = false
    end
end

function use_weaponskill()
    if state.WsPaused.value then
        -- we pause a bit to allow the WS to complete without spamming the client.
        send_command('@wait '..auto_ws_delay..'; gs c set WsPaused false')
        return
    end
    send_command('input /ws "'..auto_gun_ws..'" <t>')
    state.WsPaused:set(true)
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if (newValue ~= 'Disabled' and newValue ~= 'WSOnly' and newValue ~= 'ShootToTPOff') or (newValue == 'WS' and player.tp < 1000) then
            send_command('@wait 0.5; input /ra <t>')
        end
    elseif stateField == 'Gun Selector' then
        equip({range=state.GunSelector.current})
    end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- GUN 
    if spell.type:lower() == 'weaponskill' then
        delay = '2.25' 
    else
        if buffactive["Courser's Roll"] then
            delay = '1.05' -- While at 55% snapshot + this buff, i couldnt consistently go any lower than this
        elseif buffactive['Flurry II'] then
            delay = '1.05' -- Need to verify
        else
            delay = '1.05' -- Need to verify
        end
    end
    local target = windower.ffxi.get_mob_by_target("t")
    if target ~= nil and target.spawn_type ~= 16 then
        add_to_chat(122, "Target is not a monster! AutoRA will not fire.")
        state.AutoRA:set('Disabled')
    else
        send_command('@wait '..delay..'; input /ra <t>')
    end
end

function select_default_macro_book()
    set_macro_page(1, 10)
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 124')
end

function customize_idle_set(idleSet)
    if state.CapacityMode.current == 'on' then
        equip(sets.CapacityMantle)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

windower.register_event(
	"zone change",
	function()
		equip(sets.idle)
	end
)