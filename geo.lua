-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Toggles Weapon Lock
--              [ F11 ]             Cycle Casting Modes: Exact spells, resolve spells
--              [ ALT+F11 ]         Cycle Burst Mode
--              [ CTRL+F11 ]         Cycle Elemental to MP Body on Nukes
--              [ F12 ]             Update Current Gear / Report Current Status
--
--  Abilities:  [ CTRL+` ]          Full Circle
--
--  Weapons:    [ F10 ]          Toggles Weapon Lock
--

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include files.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Need to see if we want to keep these.
    indi_timer = ''
    indi_duration = 180
    -- Eventually, we'll likely use this to lock our relic headgear on to keep the +600 HP bonus on.
    newLuopan = 0

    -- Start things we know we want

    -- The degrade array is used to degrade spells that are not available at present time (e.g. on cooldown).
    -- This takes effect when the casting mode is set to resolve.
    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
        }
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == "sortie" then
        set_macro_page(1, 8)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Melee')
    state.DefenseMode:options('None')
    state.CastingMode:options('Resolve', 'Exact')
    select_default_macro_book()
    set_lockstyle()
    state.WeaponLock = M(false, 'WeaponLocked')
    state.MagicBurst = M(false, 'MagicBurst')
    state.ManaBody = M(false, 'ManaBody')
	send_command('bind f10 gs c cycle WeaponLock')
    send_command('bind @f10 gs c cycle ManaBody')
    send_command('bind !f10 gs c cycle MagicBurst')
    send_command('bind ^` input /ja "Full Circle" <me>')
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind f10')
    send_command('unbind !f10')
    send_command('unbind ^f10')
end

function file_unload()
    send_command('unbind !=')
end

-- function check_weaponlock()
--     if state.WeaponLock.value then
--         disable("main")
--         disable("sub")
--         disable("range")
--         disable("ammo")
--     else
--         enable("main")
--         enable("sub")
--         enable("range")
--         enable("ammo")
--     end
-- end

-- Define sets and vars used by this job file.
function init_gear_sets()


    --------------------------------------
    -- AF/Relic/Empy Setup
    --------------------------------------
    -- Start Artifact
    Geomancy_Head = "geomancy Galero"    
    Geomancy_Body = "Geomancy Tunic +2"
    Geomancy_Hands = "Geomancy Mitaines +2"
    Geomancy_Legs = "Geomancy Pants +2"
    Geomancy_Feet = "Geomancy Sandals +2"
    -- End Artifact (Other pieces on slip)
    -- Start Relic
    Bagua_Head = "Bagua Galero"
    Bagua_Body = "Bagua Tunic"
    Bagua_Hands = "Bagua Mitaines"
    Bagua_Legs = "Bagua Pants +1"
    Bagua_Feet = "Bagua Sandals +1"
    -- End Relic (Other pieces on slip)
    -- Start Empy
    Azimuth_Head = "Azimuth Hood +2"
    Azimuth_Body = "Azimuth Coat +2"
    Azimuth_Hands = "Azimuth Gloves +2"
    Azimuth_Legs = "Azimuth Tights +2"
    Azimuth_Feet = "Azimuth Gaiters +2"
    Azimuth_Earring = "Azimuth Earring +1"
    -- End Empy

    -- JSE Capes
    Pet_Cape = { name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
    Nuke_Cape = { name="Nantosuelta's Cape", augments={'Mag. Acc+17 /Mag. Dmg.+17','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
    Geomancy_Cape = "Lifestream Cape" -- if i get more than 1 then use the augments.

    --------------------------------------
    -- DT General sets
    --------------------------------------
    sets.DT = {
    range="Dunna",
    head="Azimuth Hood +2",
    body="Azimuth Coat +2",
    hands="Azimuth Gloves +2",
    legs="Azimuth Tights +2",
    feet="Azimuth Gaiters +2",
    neck="Bathy Choker +1",
    waist="Null Belt",
    left_ear="Alabaster Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Damage taken-3%',}},
    left_ring="Murky Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",
    }

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body=Bagua_Body}
    sets.precast.JA['Life Cycle'] = {body=Geomancy_Body, back=Pet_Cape}
    sets.precast.JA['Full Circle'] = {head=Azimuth_Head, hands=Bagua_Hands}
    sets.precast.JA['Radial Arcana'] = {feet=Bagua_Feet}
    sets.precast.JA['Concentric Pulse'] = {head=Bagua_Head}

    -- Fast cast sets for spells
    -- /RDM is 15, cap is 80 so we need 65 more.
    -- Currently, this set also comes with 32% DT gear, which we can enhance in the future.
    -- We opt not to at this precise moment since its precast only.
    sets.precast.FC = {
         main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Chanter's Shield",
    range="Dunna",
    head="Amalric Coif +1",
    body={ name="Merlinic Jubbah", augments={'Pet: Phys. dmg. taken -2%','Phys. dmg. taken -2%','"Fast Cast"+6',}},
    hands="Azimuth Gloves +2",
    legs="Geomancy_Legs",
    feet="Merlinic Crackows",
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Etiolation Earring",
    left_ring="Murky Ring",
    right_ring="Kishar Ring",
    back="Geomancy_Cape",
    }
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",
        ammo="Crepuscular Pebble",
        neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Ishvara Earring",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Petrov Ring",
        ring2="Ephramad's Ring",
        back="Null Shawl",
        waist="Fotia Belt",
        feet="Nyame Sollerets"
    }

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC


 -- Our geomancy set wants to focus on the following:
 -- 1. Wearing idris
 -- 2. Capped DT (dont wanna die)
    sets.midcast.Geomancy = {
        main="Idris",
        sub="Genmei Shield",
        range="Dunna", 
        head=Azimuth_Head, 
        neck="Bagua Charm +1",
        ear1="Malignance Earring",
        ring1="Fortified Ring", -- Used for DT
        ring2="Murky Ring", -- Used for DT
        hands=Geomancy_Hands, 
        body="Vedic Coat", -- Used for conserve MP
        legs="Nyame Flanchard", -- Used for DT
        feet=Azimuth_Feet,
        waist="Null Belt", -- We use this for the regen/M.Eva instead of wasting inventory on a small amount of conserve MP.
        back=Geomancy_Cape, 
    }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        legs=Bagua_Legs,
        feet=Azimuth_Feet,
        back=Geomancy_Cape, 
    })

    sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
        main="Daybreak",
        neck="Nodens Gorget",
        ear1="Mendicant's Earring",
        ring1="Naji's Loop",
        hands="Telchine Gloves",
        feet="Vanya Clogs",
    	back="Solemnity Cape"
    })
    
    sets.midcast.Curaga = sets.midcast.Cure

    --sets.midcast.Protectra = {ring1="Sheltered Ring"}

    --sets.midcast.Shellra = {ring1="Sheltered Ring"}

    sets.midcast['Elemental Magic']  = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head=Azimuth_Head,
        neck="Sibyl Scarf",
        -- neck="Null Loop",
        ear1="Malignance Earring",
        ear2=Azimuth_Earring,
        body=Azimuth_Body,
        hands=Azimuth_Hands, 
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        back=Nuke_Cape,
        waist="Acuity Belt +1", 
        legs=Azimuth_Legs,
        feet=Azimuth_Feet
    }

    sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], {
        -- hands="Agwu's Gages",
        ring1="Mujin Band",
    })

    -- We have removed the concepts of low tier nukes..but are too lazy to remove the associated code.
    sets.midcast.Macc = { 
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=Azimuth_Head,
        neck="Null Loop",
        ear1="Malignance Earring",
        ear2=Azimuth_Earring,
        body=Azimuth_Body,
        hands=Azimuth_Hands,
        ring1="Crepuscular Ring",
        ring2="Metamorph Ring +1",
        back=Nuke_Cape,
        legs=Azimuth_Legs,
        waist="Null Belt", 
        feet=Azimuth_Feet
    }


    sets.midcast.Absorb = set_combine(sets.midcast.Macc, {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        range="Dunna",
        head=Bagua_Head,
        hands="Agwu's Gages",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Kishar Ring",
        ring2="Evanescence Ring",
        body=Geomancy_Body,
        legs=Azimuth_Legs,
    })

    sets.midcast["Absorb-TP"] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        range="Dunna",
        head="Amalric Coif +1",
        neck="Erra Pendant",
        hands="Agwu's Gages",
        body="Zendik Robe",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        waist="Witful Belt",
        feet="Agwu's Pigaches",
        ring1="Kishar Ring",
        ring2="Metamorph Ring +1",
        legs = Geomancy_Legs,
        back="Null Shawl",
    }
    
    sets.midcast.Aspir = set_combine(sets.midcast.Macc, { 
        head="Pixie Hairpin +1",
        neck="Erra Pendant",
        ear1="Hirudinea Earring",
        ear2=Azimuth_Earring,
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        body=Geomancy_Body,
        legs=Azimuth_Legs,
        waist="Fucho-no-obi",
        feet="Merlinic Crackows"
    })
    sets.midcast.Drain = sets.midcast.Aspir
    sets.midcast.Stun = sets.midcast.Macc
    
    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc, {
        main="Bunzi's Rod",
        neck="Erra Pendant",
        waist="Null Belt",
        back=Nuke_Cape,
        hands=Azimuth_Hands,
        ring1="Kishar Ring",
        ring2="Metamorph Ring +1",
        feet=Bagua_Feet
    })

    sets.midcast['Enfeebling Magic'].DT = set_combine(sets.midcast['Enfeebling Magic'], sets.DT)
    
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.Macc, {
        main="Bunzi's Rod",
        waist="Null Belt",
        back=Nuke_Cape,
        ring1="Kishar Ring",
        ring2="Metamorph Ring +1",
        feet=Bagua_Feet
    })

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, sets.DT, {
        sub="Ammurapi Shield",
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast["Enhancing Magic"], {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast.Refresh = set_combine(sets.midcast["Enhancing Magic"], {
        head="Amalric Coif +1",
    })

    sets.midcast.Aquaveil = sets.midcast.Refresh

    sets.precast.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak",
    })

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {
        main="Daybreak",
    })

    sets.precast.Impact = set_combine(sets.precast.FC, {
        body = "Crepuscular Cloak",
    })

    sets.midcast.Impact = set_combine(sets.midcast.Macc, {
        body = "Crepuscular Cloak",
    })

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main="Bolelabunga",
    })
    --------------------------------------
    -- Idle sets
    --------------------------------------

    -- Idle sets
    sets.idle = {
        main="Bolelabunga", 
	sub="Genmei Shield",
	back=Pet_Cape,
        range="Dunna",
    head="Azimuth Hood +2",
    body="Azimuth Coat +2",
    hands="Azimuth Gloves +2",
    legs="Azimuth Tights +2",
    feet="Azimuth Gaiters +2",
    neck="Bathy Choker +1",
    waist="Null Belt",
    left_ear="Alabaster Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Damage taken-3%',}},
    left_ring="Murky Ring",
    right_ring="Shneddick Ring",
    }

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Azimuth Hood +2",
    body="Azimuth Coat +2",
    hands="Geo. Mitaines +2",
    legs="Nyame Flanchard",
    feet="Bagua Sandals +1",
    neck="Null Loop",
    waist="Isa Belt",
    left_ear="Alabaster Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Damage taken-3%',}},
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back=Pet_Cape,
    })

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        main="Maxentius",
        neck="Null Loop",
        ear1="Alabaster Earring",
        ear2="Crepuscular Earring",
        head="Null Masque",
        body="Nyame Mail",
        hands=Azimuth_Hands,
        legs=Azimuth_Legs,
        feet=Azimuth_Feet,
        ring1="Chirich Ring +1",
        ring2="Chirich Ring +1",
        back="Null Shawl",
        waist="Null Belt",
    }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    sets.buff.Doom = {
        neck = "Nicander's Necklace",
		waist = "Gishdubar Sash",
		ring1 = "Purity Ring",
    }

    sets.mana_body = {
        body="Seidr Cotehardie",
    }

    sets.Obi = { waist='Hachirin-no-Obi' }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    if (spell.english ~= 'Impact' and spellMap ~= 'GeoNuke') and
       (spell.name:startswith('Aspir') or state.CastingMode.value == 'Resolve') 
    then
	    refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if spell.english == "Dispelga" then
        equip(sets.precast.Dispelga)
        eventArgs.handled = true
    end
    if spell.english == "Impact" then
        equip(sets.precast.Impact)
        eventArgs.handled = true
    end
    -- check_weaponlock()
end

function job_post_precast(spell, action, spellMap, eventArgs)
	-- Right now we don't have any post-precast hooks.
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
-- function job_status_change(newStatus, oldStatus, eventArgs)
--     check_weaponlock()
-- end



-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed!')
             disable('ring1','neck','waist')
        else
            enable('ring1','neck','waist')
            handle_equipping_gear(player.status)
        end
    end
end

function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.type == 'Trust' then
            return 'Trust'

        end
    end
end

function customize_idle_set(idleSet)
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    -- Right now we don't have any customize_melee_set hooks.
    return meleeSet
end
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    classes.CustomIdleGroups:clear()
    -- check_weaponlock()
    -- classes.CustomIdleGroups:clear()
    -- if player.indi then
    --     classes.CustomIdleGroups:append('Indi')
    -- end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local burst_mode = state.MagicBurst.value and 'On' or 'Off'
    local weapon_lock = state.WeaponLock.value and 'On' or 'Off'
    local mana_body = state.ManaBody.value and 'On' or 'Off'
    windower.add_to_chat(122, 'Casting Mode: ' .. state.CastingMode.value ..
        ' | Burst Mode: ' .. burst_mode ..
        ' | Weapon Lock: ' .. weapon_lock ..
        ' | Mana Body: ' .. mana_body ..
        ' | New Luopan: ' .. tostring(newLuopan))
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 6)
end
--Refine Nuke Spells

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell.recast_id ~= nil and spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end

function set_lockstyle()
    send_command('wait 1; input /lockstyleset 56')
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if state.ManaBody.value then
            equip(sets.mana_body)
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Enfeebling Magic' and newLuopan == 1 then
        -- TODO: Maybe use this for the +600 luopon HP bonus on relic head to not go away.
        -- prevent Cohort Cloak from unequipping head when relic head is locked
        -- equip(sets.midcast.LockedEnfeebles)
    elseif spell.skill == 'Geomancy' then
        if buffactive.Entrust and spell.english:startswith('Indi-') then
            equip(set_combine(sets.midcast.Geomancy.Indi, {
                main="Solstice",
            }))
            eventArgs.handled = true
        end
    end
end

windower.register_event(
	"zone change",
	function()
		equip(sets.idle)
	end
)