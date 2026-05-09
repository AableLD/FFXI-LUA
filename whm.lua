function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()

end

function user_setup()
    select_default_macro_book()
    set_lockstyle()
	state.WeaponLock = M(false, 'WeaponLocked')
	send_command('bind F10 gs c cycle WeaponLock')

end


function init_gear_sets()

 sets.idle = {
    main="Daybreak",
    sub="Archduke's Shield",
    ammo="Homiliary",
    head="Null Masque",
    body="Ebers Bliaut +3",
    hands="Ebers Mitts +2",
    legs="Ebers Pant. +3",
    feet="Ebers Duckbills +2",
    neck="Warder's Charm +1",
    waist="Null Belt",
    left_ear="Alabaster Earring",
    right_ear="Infused Earring",
    left_ring="Shadow Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",
}

    sets.precast.FC = {
    main="Gada",
    sub="Chanter's Shield",
    ammo="Sapience Orb",
    head="Ebers Cap +2",
    body="Inyanga Jubbah +2",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs={ name="Lengo Pants", augments={'INT+3','"Mag.Atk.Bns."+5',}},
    feet="Regal Pumps +1",
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back="Alaunus's Cape",
}
    
   
    sets.midcast.Stoneskin = {
    main="Mafic Cudgel",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum",
    head="Befouled Crown",
    body="Bunzi's Robe",
    hands="Dynasty Mitts",
    legs="Shedir Seraweels",
    feet="Theo. Duckbills +2",
    neck="Nodens Gorget",
    waist="Siegel Sash",
    left_ear="Malignance Earring",
    right_ear="Earthcry Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

sets.midcast["Stoneskin"] = sets.midcast.Stoneskin

sets.midcast.Aquaveil = {
    main="Mafic Cudgel",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum",
    head="Chironic Hat",
    body="Bunzi's Robe",
    hands="Dynasty Mitts",
    legs="Shedir Seraweels",
    feet="Theo. Duckbills +2",
    neck="Voltsurge Torque",
    waist="Emphatikos Rope",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

sets.midcast["Aquaveil"] = sets.midcast.Aquaveil


sets.engaged = {
    main="Maxentius",
    sub="Genmei Shield",
    ammo="Vanir Battery",
    head="Null Masque",
    body="Bunzi's Robe",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Null Loop",
    waist="Acuity Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Null Shawl",
}


sets.precast.WS
 = {
    ammo="Vanir Battery",
    head="Null Masque",
    body="Bunzi's Robe",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Rep. Plat. Medal",
    waist="Grunfeld Rope",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Cornelia's Ring",
    right_ring="Rufescent Ring",
    back="Null Shawl",
}


sets.precast.WS["Black Halo"] ={
    ammo="Crepuscular Pebble",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Rep. Plat. Medal",
    waist="Grunfeld Rope",
    left_ear="Regal Earring",
    right_ear="Moonshade Earring",
    left_ring="Cornelia's Ring",
    right_ring="Metamor. Ring +1",
    back="Null Shawl",
}


sets.precast.WS["Mystic Boon"] ={
    ammo="Crepuscular Pebble",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Rep. Plat. Medal",
    waist="Grunfeld Rope",
    left_ear="Regal Earring",
    right_ear="Moonshade Earring",
    left_ring="Cornelia's Ring",
    right_ring="Metamor. Ring +1",
    back="Null Shawl",
}


sets.precast.WS["Hexa Strike"] ={
    ammo="Crepuscular Pebble",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Moonshade Earring",
    left_ring="Cornelia's Ring",
    right_ring="Metamor. Ring +1",
    back="Null Shawl",
}

sets.precast.WS["Realmrazer"] ={
    ammo="Crepuscular Pebble",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Glorious Earring",
    right_ear="Moonshade Earring",
    left_ring="Cornelia's Ring",
    right_ring="Rufescent Ring",
    back="Null Shawl",
}


    sets.midcast['Enfeebling Magic'] = {
    main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Ghastly Tathlum +1",
    head="Befouled Crown",
    body="Bunzi's Robe",
    hands="Theophany Mitts +2",
    legs={ name="Chironic Hose", augments={'Accuracy+20','INT+10','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    feet="Theo. Duckbills +2",
    neck="Incanter's Torque",
    waist="Obstin. Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Kishar Ring",
    right_ring="Metamor. Ring +1",
    back="Null Shawl",
}
   

    sets.midcast.regen = {
    main="Bolelabunga",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum",
    head="Inyanga Tiara +2",
    body="Piety Bliaut +1",
    hands="Ebers Mitts +2",
    legs="Th. Pantaloons +2",
    feet="Theo. Duckbills +2",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Perimede Cape",
}


sets.midcast.StatusRemoval = {
    main="Yagrush",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum",
    head="Ebers Cap +2",
    body="Ebers Bliaut +3",
    hands="Ebers Mitts +2",
    legs="Piety Pantaln. +2",
    feet="Theo. Duckbills +2",
    neck="Cleric's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}


sets.midcast.BarElement= {
    main="Beneficus",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum",
    head="Ebers Cap +2",
    body="Ebers Bliaut +3",
    hands="Ebers Mitts +2",
    legs="Piety Pantaln. +2",
    feet="Theo. Duckbills +2",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Mendi. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Perimede Cape",
}

sets.midcast.BarStatus= {
    main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum",
    head="Ebers Cap +2",
    body="Ebers Bliaut +3",
    hands="Ebers Mitts +2",
    legs="Piety Pantaln. +2",
    feet="Theo. Duckbills +2",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Mendi. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Perimede Cape",
}


sets.midcast['Enhancing Magic'] = {
    main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum",
    head="Befouled Crown",
    body="Ebers Bliaut +3",
    hands="Dynasty Mitts",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}},
    feet="Theo. Duckbills +2",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Mendi. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}


    sets.midcast.Cure = {
    main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
    sub="Archduke's Shield",
    ammo="Staunch Tathlum",
    head="Ebers Cap +2",
    body="Ebers Bliaut +3",
    hands="Theophany Mitts +2",
    legs="Ebers Pant. +3",
    feet={ name="Medium's Sabots", augments={'MP+30','MND+8','"Cure" potency +2%',}},
    neck="Incanter's Torque",
    waist="Witful Belt",
    left_ear="Glorious Earring",
    right_ear="Mendi. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

    sets.midcast["Cure II"] = sets.midcast.Cure
    sets.midcast["Cure III"] = sets.midcast.Cure
    sets.midcast["Cure IV"] = sets.midcast.Cure
    sets.midcast["Cure V"] = sets.midcast.Cure
    sets.midcast["Cure VI"] = sets.midcast.Cure    


sets.midcast.Curaga = {
    main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
    sub="Archduke's Shield",
    ammo="Staunch Tathlum",
    head="Ebers Cap +2",
    body="Theo. Bliaut +2",
    hands="Theophany Mitts +2",
    legs="Ebers Pant. +3",
    feet={ name="Medium's Sabots", augments={'MP+30','MND+8','"Cure" potency +2%',}},
    neck="Incanter's Torque",
    waist="Witful Belt",
    left_ear="Glorious Earring",
    right_ear="Mendi. Earring",
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

    sets.midcast["Curaga"] = sets.midcast.Curaga
    sets.midcast["Curaga II"] = sets.midcast.Curaga
    sets.midcast["Curaga III"] = sets.midcast.Curaga
    sets.midcast["Curaga IV"] = sets.midcast.Curaga
    sets.midcast["Curaga V"] = sets.midcast.Curaga

    sets.midcast.Cursna = {
    main="Yagrush",
    sub="Archduke's Shield",
    ammo="Staunch Tathlum",
    head="Ebers Cap +2",
    body="Ebers Bliaut +3",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs="Th. Pantaloons +2",
    feet="Gende. Galosh. +1",
    neck="Debilis Medallion",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Ebers Earring",
    left_ring="Menelaus's Ring",
    right_ring="Haoma's Ring",
    back="Alaunus's Cape",
}


    sets.midcast["Cursna"] = sets.midcast.Cursna


sets.midcast["Impact"] = sets.midcast.Impact

end

function select_default_macro_book()
    set_macro_page(1, 14)
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 180')
end

function job_precast(spell, action, spellMap, eventArgs)
    check_weaponlock()
end

function check_weaponlock()
    if state.WeaponLock.value then
        disable("main")
        disable("sub")
        disable("range")
        disable("ammo")
    else
        enable("main")
        enable("sub")
        enable("range")
        enable("ammo")
    end
end

function job_status_change(newStatus, oldStatus, eventArgs)
    check_weaponlock()
end

function job_update(cmdParams, eventArgs)
    check_weaponlock()
end
