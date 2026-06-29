function get_sets()
	mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()
	select_default_macro_book()
	set_lockstyle()
    state.HybridMode:options('Normal', 'HighAcc', 'SubtleBlow')
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    send_command('bind !f9 gs c cycle TreasureMode')
    send_command('bind f9 gs c cycle HybridMode')
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind !`')
    send_command('unbind ^-')
end

function init_gear_sets()

        Ankou={}
        Ankou.WSDSTR=   { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%','"Regen"+3',}}
        -- Ankou.WSDSTR=   { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
        Ankou.WSDVIT=   { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
        Ankou.DA=       { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
        Ankou.ACC=      { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
        Ankou.FC=       { name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
        Ankou.STP=      { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}

    sets.engaged={
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Null Loop",
    waist="Sailfi Belt +1",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back="Null Shawl",
}
    
    sets.engaged.HighAcc = set_combine(sets.engaged, {
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        hands="Heath. Gauntlets +2",
        feet="Heath. Sollerets +2",
        left_ear={ name="Schere Earring", augments={'Path: A',}},
        right_ear="Crep. Earring",
        left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
    })

    sets.engaged.SubtleBlow = set_combine(sets.engaged, {
        head="Hjarrandi Helm",
        ear1="Dignitary's Earring",
        ring2="Chirich Ring +1",
        feet="Sakpata's Leggings",
        ammo="Seething Bomblet +1"
    })

    
	sets.regain = set_combine(sets.idle, {
        head="Valorous Mask", 
        neck = "Republican Platinum Medal",
        ring1 = "Karieyh Ring",
    })
    
    sets.TP = sets.engaged

    sets.precast.WS = {
        ammo="Knobkierrie",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Rep. Plat. Medal",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        right_ring="Niqmaddu Ring",
        left_ring="Cornelia's Ring",
        back=Ankou.WSDSTR
    }
    sets.precast.WS['Quietus'] = set_combine(sets.precast.WS,{

    })
    
    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS,{
        ammo="Coiste Bodhar",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back="Null Shawl",})


sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {
        right_ear="Hoxne Earring",
    })


sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
        waist="Fotia Belt",
    })

    sets.TreasureHunter = {
        head = "Valorous Mask",
        ammo = "Perfect Lucky Egg",
        waist="Chaac Belt",
    }

    sets.idle = {
    ammo="Crepuscular Pebble",
    head="Null Masque",
    body="Sacro Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Nyame Sollerets",
    neck="Rep. Plat. Medal",
    waist="Carrier's Sash",
    left_ear="Alabaster Earring",
    right_ear="Infused Earring",
    left_ring="Murky Ring",
    right_ring="Shneddick Ring",
    back="Null Shawl",
    }
    sets.CP = {
		back = "Mecistopins Mantle",
	}
    sets.precast.FC = {
        ammo="Sapience Orb",
    head="Sakpata's Helm",
    body="Sacro Breastplate",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Enif Cosciales",
    feet={ name="Odyssean Greaves", augments={'"Fast Cast"+5','Pet: Accuracy+13 Pet: Rng. Acc.+13','Chance of successful block +5',}},
    neck="Voltsurge Torque",
    waist="Null Belt",
    left_ear="Alabaster Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back="Reiki Cloak",
    }

    sets.precast.FC["Dark Magic"] = set_combine(sets.precast.FC, {
        head={ name="Fallen's Burgeonet +2", augments={'Enhances "Dark Seal" effect',}},
    })

    sets.precast.JA = sets.idle

    sets.midcast = {}
    
    sets.midcast.magic_base = {
        ammo="Ghastly Tathlum +1",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Malignance Earring",
        left_ring="Kishar Ring",
        right_ring="Metamorph Ring +1",
        back= "Null Shawl"
    }
    sets.midcast.dark_magic = set_combine(sets.midcast.magic_base,{
        right_ring = "Evanescence Ring",
    })

    sets.midcast.Absorb = set_combine(sets.midcast.dark_magic,
    {
        neck = "Erra Pendant",
    })

    sets.midcast["Dread Spikes"] = {
        head = "Hjarrandi Helm",
        neck = "Sanctity Necklace", -- upgrade this
        body = "Sakpata's Breastplate",
        hands = "Sakpata's Gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        waist = "Eschan Stone",
        ammo = "Egoist's tathlum",
        left_ear="Etiolation Earring",
        right_ear = "Tuisto Earring",
        left_ring="Regal Ring",

    }

    sets.midcast["Drain"] = set_combine(sets.midcast.dark_magic,{
        left_ring = "Archon Ring",
        ear2 = "Hirudinea Earring",  
        neck = "Erra Pendant",
        back = "Null Shawl",
    })
    
    sets.midcast["Aspir"] = sets.midcast["Drain"]

    sets.calad = {
		main = "Montante +1",
		sub = "Utu Grip",
	}

    sets.apoc = {
		main = "Apocalypse",
		sub = "Utu Grip",
	}

end

function equip_idle_set()
    equip(sets.idle)
end

function job_midcast(spell)
    if spell.skill == 'Elemental Magic' then
        equip_idle_set()
        equip(sets.midcast.magic_base)
    end
end

function select_default_macro_book()
    set_macro_page(1, 5)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 93')
end

windower.register_event(
	"zone change",
	function()
		equip(sets.idle)
	end
)

function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == "Dark Magic" then
        equip(sets.precast.FC.dark_magic)
    else
        equip(sets.precast.FC)
    end
end
function check_cmd_param(cmdParams, weaponName)
	retval = false
	if cmdParams[1]:lower() == weaponName then
		retval = true
	end
	return retval
end
function job_self_command(cmdParams, eventArgs)
	if check_cmd_param(cmdParams,"calad") then
		equip(sets.calad)
		send_command('input /lockstyleset 13')
        set_macro_page(1, 4)
    elseif check_cmd_param(cmdParams,"apoc") then
        equip(sets.apoc)
        send_command('input /lockstyleset 34')
        set_macro_page(2, 4)

    end
end