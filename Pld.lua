-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
	
	send_command('wait 6;input /lockstyleset 121')
	
	rune_enchantments = S{'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux','Tenebrae'}
	-- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'BURTAM3', 'GS')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD')
	state.IdleMode:options('Normal','TANK','MDB')

	state.Runes = M{['description']='Runes', 'Ignis', 'Unda', 'Sulpor', 'Tellus', 'Flabra', 'Gelus', 'Lux', 'Tenebrae'}

    select_default_macro_book(1, 18)
end

function user_unload()
	send_command('unbind ')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
	
	 sets.midcast.Enmity = {ammo="Sapience Orb",
    head="Loess Barbuta +1",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Chev. Sabatons +3",
    neck="Unmoving Collar +1",
    waist="Plat. Mog. Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Cryptic Earring",
    left_ring="Apeile Ring",
    right_ring="Apeile Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.midcast.Enmity, {legs="Caballarius Breeches"})
    sets.precast.JA['Holy Circle'] = {feet="Gallant Leggings +4"}
    sets.precast.JA['Shield Bash'] = set_combine(sets.midcast.Enmity, {hands="Caballarius Gauntlets +4", left_ear="Knightly Earring", left_ring="Fenian Ring",})
    sets.precast.JA['Sentinel'] = set_combine(sets.midcast.Enmity, {feet="Caballarius Leggings +4"})
    sets.precast.JA['Rampart'] = set_combine(sets.midcast.Enmity, {head="Caballarius Coronet"})
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +3",}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1", body="Caballarius Surcoat +3",}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {hands="Caballarius Gauntlets"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",
    head="Chev. Armet +3",
    body="Reverence surcoat +4",
    hands="Leyline Gloves",
    legs="Enif Cosciales",
    feet="Chev. Sabatons +3",
    neck="Unmoving Collar +1",
    waist="Plat. Mog. Belt",
    left_ear="Alabaster Earring",
    right_ear="Loquac. Earring",
    left_ring="Murky Ring",
    right_ring="Kishar Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}},}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ring="Regal Ring",
		left_ring="Rufescent Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Shukuyu Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}

    sets.precast.WS['Sanguine Blade'] = {ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Archon Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
    
    		sets.precast.WS['Atonement'] = {ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    		feet="Chev. Sabatons +3",
    		neck="Unmoving Collar +1",
    		waist="Creed Baudrier",
    		left_ear="Alabaster Earring",
    		right_ear="Cryptic Earring",
    		left_ring="Apeile Ring",
    		right_ring="Apeile Ring +1",
    		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
	
	sets.precast.WS['Savage Blade'] = {ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ring="Regal Ring",
		left_ring="Cornelia's Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
		
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {})
	
	sets.precast.WS['Chant Du Cygne'] = {ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Nyame Helm",
		body="Hjarrandi Breast.",
		hands="Nyame Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ear="Odnowa Earring +1",
		right_ring="Regal Ring",
		left_ring="Cornelia's Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
		
	sets.precast.WS['Knights of Round'] = {ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring={name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
		
	sets.precast.WS['Imperator'] = {ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Nyame Gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
		
	sets.precast.WS['Impulse Drive'] = {ammo="Coiste Bodhar",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Hjarrandi Breast.",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rufescent Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Torcleaver'] = {ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		right_ring="Regal Ring",
		left_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Resolution'] = {ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ring="Regal Ring",
		left_ring="Shukuyu Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
		
	sets.precast.WS['Cataclysm'] = {ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Archon Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
		
	sets.precast.WS['Aeolian Edge'] = {ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Shiva Ring +1",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+2','Weapon skill damage +10%',}},}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
        
	sets.midcast.FastRecast.SIRD = set_combine(sets.midcast.FastRecast, {ammo="Staunch Tathlum",
    	head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	body="Chev. Cuirass +3",
    	hands="Chev. Gauntlets +3",
    	legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+3','Breath dmg. taken -2%',}},
    	feet="Chev. Sabatons +3",
    	neck="Moonbeam Necklace",
    	waist="Audumbla Sash",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Murky Ring",
    	right_ring="Defending Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},})
		
   

	sets.midcast.Enmity.SIRD = set_combine(sets.midcast.Enmity, {ammo="Staunch Tathlum",
    	head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	body="Chev. Cuirass +3",
    	hands="Chev. Gauntlets +3",
    	legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+3','Breath dmg. taken -2%',}},
    	feet="Chev. Sabatons +3",
    	neck="Moonbeam Necklace",
    	waist="Audumbla Sash",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Murky Ring",
    	right_ring="Defending Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},})

	sets.midcast['Blue Magic'] = {ammo="Staunch Tathlum",
	head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	body="Chev. Cuirass +3",
    	hands="Chev. Gauntlets +3",
    	legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+3','Breath dmg. taken -2%',}},
    	feet="Chev. Sabatons +3",
    	neck="Moonbeam Necklace",
    	waist="Audumbla Sash",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Murky Ring",
    	right_ring="Defending Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
		
	sets.midcast['Crusade'] = set_combine(sets.midcast.Enmity.SIRD, {})
	
	sets.midcast['Blue Magic'].Enmity = set_combine(sets.midcast.Enmity, {})
	
	sets.midcast['Blue Magic'].Enmity.SIRD = set_combine(sets.midcast.Enmity.SIRD, {})

    sets.midcast['Flash'] = {ammo="Staunch Tathlum",
    	head="Chev. Armet +3",
    	body="Chev. Cuirass +3",
    	hands="Chev. Gauntlets +3",
    	legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+3','Breath dmg. taken -2%',}},
    	feet="Chev. Sabatons +3",
    	neck="Moonbeam Necklace",
    	waist="Audumbla Sash",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Murky Ring",
    	right_ring="Defending Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
		
	sets.midcast['Reprisal'] = set_combine(sets.midcast.Flash, {body="Shabti Cuirass +1", hands="Regal Gauntlets"})
    
    sets.midcast.Stun = set_combine(sets.midcast['Flash'], {})
	
	sets.midcast['Foil'] = set_combine(sets.midcast['Flash'], {})
    
    sets.midcast.Cure = {ammo="Staunch Tathlum",
	head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	body="Chev. Cuirass +3",
    	hands="Chev. Gauntlets +3",
    	legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+3','Breath dmg. taken -2%',}},
    	feet="Chev. Sabatons +3",
    	neck="Moonbeam Necklace",
    	waist="Audumbla Sash",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Murky Ring",
    	right_ring="Defending Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},} --10
		
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, {ammo="Staunch Tathlum",
	head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	body="Chev. Cuirass +3",
    	hands="Chev. Gauntlets +3",
    	legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+3','Breath dmg. taken -2%',}},
    	feet="Chev. Sabatons +3",
    	neck="Moonbeam Necklace",
    	waist="Audumbla Sash",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Murky Ring",
    	right_ring="Defending Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},})

    sets.midcast['Enhancing Magic'] = {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},}
		
	sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {neck="Stone Gorget", legs="Haven Hose", waist="Siegel Sash", ear1="Earthcry Earring"})
	
	sets.midcast['Divine Magic'] = {body="Reverence Surcoat +4",
		waist="Asklepian Belt",}
	
	sets.midcast['Holy II'] = {ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Moonbeam Necklace",
		waist="Asklepian Belt",
		left_ear="Friomisi Earring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},}
	
	sets.midcast['Phalanx'] = {ammo="Staunch Tathlum",
   	 head={ name="Odyssean Helm", augments={'Attack+9','Weapon Skill Acc.+11','Phalanx +4','Accuracy+2 Attack+2',}},
	 body={ name="Odyss. Chestplate", augments={'Pet: "Store TP"+6','VIT+5','Phalanx +4',}},
    	 hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	 legs="Sakpata's Cuisses",
    	 feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	 neck="Moonbeam Necklace",
    	 waist="Audumbla Sash",
    	 left_ear="Odnowa Earring +1",
    	 right_ear="Alabaster Earring",
    	 left_ring="Murky Ring",
    	 right_ring="Defending Ring",
    	 back={ name="Weard Mantle", augments={'VIT+1','DEX+3','Enmity+2','Phalanx +4',}},}
		
	sets.midcast['Enlight II'] = {body="Reverence Surcoat +4",
		waist="Asklepian Belt",}
		
    
    sets.midcast.Protect = {left_ring="Sheltered Ring",}
    sets.midcast.Shell = {left_ring="Sheltered Ring",}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {}
    

    -- Idle sets
	sets.idle = {ammo="Crepuscular Pebble",
	    head="Null Masque",
    	body="Sacro Breastplate",
    	hands="Chev. Gauntlets +3",
    	legs="Chev. Cuisses +3",
    	feet="Nyame Sollerets",
    	neck="Warder's Charm +1",
    	waist="Plat. Mog. Belt",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Shadow Ring",
    	right_ring="Shneddick Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}

	sets.idle.TANK = {ammo="Eluder's Sachet",
	head="Chev. Armet +3",
    	body="Sacro Breastplate",
    	hands="Chev. Gauntlets +3",
    	legs="Chev. Cuisses +3",
    	feet="Nyame Sollerets",
    	neck="Warder's Charm +1",
    	waist="Plat. Mog. Belt",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Shadow Ring",
    	right_ring="Shneddick Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
		
	sets.idle.MDB = {ammo="Vanir Battery",
		head="Chev. Armet +3",
	    	body="Sacro Breastplate",
	    	hands="Chev. Gauntlets +3",
	    	legs="Chev. Cuisses +3",
    		feet="Nyame Sollerets",
	    	neck="Warder's Charm +1",
    		waist="Plat. Mog. Belt",
	    	left_ear="Odnowa Earring +1",
	    	right_ear="Alabaster Earring",
    		left_ring="Shadow Ring",
    		right_ring="Shneddick Ring",
	    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}

    sets.idle.Town = {ammo="Homiliary",
	head="Null Masque",
    	body="Sacro Breastplate",
    	hands="Chev. Gauntlets +3",
    	legs="Chev. Cuisses +3",
    	feet="Nyame Sollerets",
    	neck="Warder's Charm +1",
    	waist="Plat. Mog. Belt",
    	left_ear="Odnowa Earring +1",
    	right_ear="Alabaster Earring",
    	left_ring="Shadow Ring",
    	right_ring="Shneddick Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
		
    sets.Kiting = {right_ring="Shneddick Ring"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Staunch Tathlum",
	    head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Chev. Cuisses +3",
	    feet="Sakpata's Leggings",
	    neck="Warder's Charm +1",
	    waist="Sailfi Belt +1",
	    left_ear="Odnowa Earring +1",
	    right_ear="Alabaster Earring",
	    left_ring="Shadow Ring",
	    right_ring="Regal Ring",
	    back="Null Shawl",}
		
	sets.engaged.BURTAM3 = {ammo="Staunch Tathlum",
   	 head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Chev. Cuisses +3",
	    feet="Sakpata's Leggings",
	    neck="Warder's Charm +1",
	    waist="Sailfi Belt +1",
	    left_ear="Odnowa Earring +1",
	    right_ear="Alabaster Earring",
	    left_ring="Shadow Ring",
	    right_ring="Regal Ring",
	    back="Null Shawl",}

    sets.engaged.GS = {ammo="Staunch Tathlum",
	    head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Chev. Cuisses +3",
	    feet="Sakpata's Leggings",
	    neck="Warder's Charm +1",
	    waist="Sailfi Belt +1",
	    left_ear="Odnowa Earring +1",
	    right_ear="Alabaster Earring",
	    left_ring="Shadow Ring",
	    right_ring="Regal Ring",
	    back="Null Shawl",}




    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {}
    sets.buff.Cover = {}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.current == 'HP' and spell.english ~= "Phalanx" then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.english == 'Flash' or spell.english == 'Foil' or spell.english == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.midcast.Enmity)
            elseif spell.skill == 'Enhancing Magic' then
                equip(sets.midcast.EnhancingDuration)
            end
        end
    end
end

function display_current_job_state(eventArgs)
	    -- Display Current Rune Element Selected
	local r_msg = 'None'
	local r_color = 1
	if player.sub_job == 'RUN' then
		r_msg = state.Runes.current
		if state.Runes.current == 'Ignis' then r_color = 167
		elseif state.Runes.current == 'Gelus' then r_color = 210
		elseif state.Runes.current == 'Flabra' then r_color = 204
		elseif state.Runes.current == 'Tellus' then r_color = 050
		elseif state.Runes.current == 'Sulpor' then r_color = 215
		elseif state.Runes.current == 'Unda' then r_color = 207
		elseif state.Runes.current == 'Lux' then r_color = 001
		elseif state.Runes.current == 'Tenebrae' then r_color = 160 end
	end

    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(2, 3)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 3)
    elseif player.sub_job == 'SAM' then
        set_macro_page(2, 3)
    else
        set_macro_page(2, 3)
    end
end