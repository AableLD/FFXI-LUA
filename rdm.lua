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

  sets.Obi = { waist='Hachirin-no-Obi' }

 sets.idle = {
    main="Daybreak",
    sub="Archduke's Shield",
    ammo="Homiliary",
    head="Viti. Chapeau +4",
    body="Lethargy Sayon +3",
    hands="Nyame Gauntlets",
    legs="Sworn Brais",
    feet="Sworn Sabatons",
    neck="Warder's Charm +1",
    waist="Carrier's Sash",
    left_ear="Alabaster Earring",
    right_ear="Infused Earring",
    left_ring="Murky Ring",
    right_ring="Shneddick Ring",
    back="Null Shawl",
}

    sets.precast.FC = {
    ammo="Sapience Orb",
    {head="Atro. Chapeau +4", priority=74},
    {body="Viti. Tabard +4", priority=84},
    {hands="Nyame Gauntlets", priority=91},
    {legs="Sworn Brais", priority=164},
    {feet="Sworn Sabatons", priority=119},
    {neck="Null Loop", priority=50},
    waist="Witful Belt",
    {left_ear="Alabaster Earring", priority=100},
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Veneficium Ring",
    right_ring="Lebeche Ring",
    back="Perimede Cape",
}
    
    sets.precast.FC["Impact"] = set_combine(sets.precast.FC, {   main={ name="Vitiation Sword", augments={'Path: C',}, priority=120},
    sub="Archduke's Shield",
    ammo="Sapience Orb",
    body="Crepuscular Cloak",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}, priority=25},
    legs={ name="Sworn Brais", priority=164},
    {feet="Atro. Boots +4", priority=92},
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear={ name="Alabaster Earring", priority=100},
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Veneficium Ring",
    right_ring="Lebeche Ring",
    back="Perimede Cape",})

sets.midcast.Utsusemi = {
        main="Mafic Cudgel",
    sub="Sacro Bulwark",
    ammo="Staunch Tathlum",
    head="Atro. Chapeau +4",
    body="Viti. Tabard +4",
    hands="Leth. Ganth. +3",
    legs={ name="Sworn Brais", priority=164},
    feet="Nyame Sollerets",
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Alabaster Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Murky Ring",
    right_ring="Defending Ring",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},}

 sets.midcast["Utsusemi: Ni"] = sets.midcast.Utsusemi
sets.midcast["Utsusemi: Ichi"] = sets.midcast.Utsusemi
sets.midcast["Raise"] = sets.midcast.Utsusemi
sets.midcast["Raise II"] = sets.midcast.Utsusemi
sets.midcast["Reraise II"] = sets.midcast.Utsusemi
sets.midcast["Reraise II"] = sets.midcast.Utsusemi

    sets.midcast.Stoneskin = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Sapience Orb",
        head="Atro. Chapeau +4",
        body="Viti. Tabard +4",
        hands="Stone Mufflers",
        legs="Shedir Seraweels",
        feet="Leth. Houseaux +3",
        neck="Nodens Gorget",
        waist="Siegel Sash",
        left_ear="Earthcry Earring",
        right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
        left_ring="Kishar Ring",
        right_ring="Defending Ring",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},

}
sets.midcast["Stoneskin"] = sets.midcast.Stoneskin

sets.midcast.Aquaveil = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Sapience Orb",
        head= "Amalric Coif +1",
        body="Viti. Tabard +4",
        hands="Atro. Gloves +4",
        legs="Shedir Seraweels",
        feet="Leth. Houseaux +3",
        neck="Dls. Torque +2",
        waist="Emphatikos Rope",
        left_ear="Malignance Earring",
        right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
        left_ring="Kishar Ring",
        right_ring="Defending Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +10','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},
    }

sets.midcast["Aquaveil"] = sets.midcast.Aquaveil


sets.engaged = {
ammo="Sroda Tathlum",
 main="Vitiation Sword",
        sub="Ammurapi Shield",   
head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Sworn Brais",
    feet="Sworn Sabatons",
    neck="Null Loop",
    waist="Orpheus's Sash",
    left_ear="Alabaster Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Murky Ring",
    right_ring="Ilabrat Ring",
    back="Null Shawl",
}

sets.precast.WS["Requiescat"] = {
ammo="Coiste Bodhar",
    head="Viti. Chapeau +4",
    body="Nyame Mail",
    hands="Malignance Gloves",
    legs="Nyame Flanchard",
    feet="Leth. Houseaux +3",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Regal Earring",
    right_ring="Rufescent Ring",
    left_ring="Cornelia's Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}


sets.precast.WS["Death Blossom"] = {
ammo="Coiste Bodhar",
    head="Viti. Chapeau +4",
    body="Nyame Mail",
    hands="Malignance Gloves",
    legs="Nyame Flanchard",
    feet="Leth. Houseaux +3",
    neck="Rep. Plat. Medal",
    waist="Sailfi Belt +1",
    left_ear="Sherida Earring",
    right_ear="Hoxne Earring",
    left_ring="Rufescent Ring",
    right_ring="Cornelia's Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}

sets.precast.WS["Chant du Cygne"] = {
ammo="Coiste Bodhar",
    head="Viti. Chapeau +4",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Viti. Tights +4",
    feet="Thereoid Greaves",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Hoxne Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Cornelia's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}

sets.precast.WS["Evisceration"] = {
ammo="Coiste Bodhar",
    head="Viti. Chapeau +4",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Viti. Tights +4",
    feet="Thereoid Greaves",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Cornelia's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}

sets.precast.WS["Savage Blade"] = {
    ammo="Coiste Bodhar",
    head="Viti. Chapeau +4",
    body="Nyame Mail",
    hands="Atro. Gloves +4",
    legs="Nyame Flanchard",
    feet="Leth. Houseaux +3",
    neck="Rep. Plat. Medal",
    waist="Sailfi Belt +1",
    left_ear="Hoxne Earring",
    right_ear="Moonshade Earring",
    left_ring="Cornelia's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}

sets.precast.WS["Black Halo"] = {
    ammo="Coiste Bodhar",
    head="Viti. Chapeau +4",
    body="Nyame Mail",
    hands="Atro. Gloves +4",
    legs="Nyame Flanchard",
    feet="Leth. Houseaux +3",
    neck="Rep. Plat. Medal",
    waist="Sailfi Belt +1",
    left_ear="Sherida Earring",
    right_ear="Moonshade Earring",
    left_ring="Cornelia's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}

sets.precast.WS["Seraph Blade"] = {
    ammo="Ghastly Tathlum +1",
    head="Leth. Chappel +3",
    body="Nyame Mail",
    hands="Leth. Ganth. +3",
    legs="Nyame Flanchard",
    feet="Leth. Houseaux +3",
    neck="Fotia Gorget",
    waist="Orpheus's Sash",
    left_ear="Moonshade Earring",
    right_ear="Malignance Earring",
    right_ring="Freke Ring",
    left_ring="Cornelia's Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill         	damage +10%','Damage taken-5%',}},
}

sets.precast.WS["Red Lotus Blade"] = {
    ammo="Ghastly Tathlum +1",
    head="Leth. Chappel +3",
    body="Nyame Mail",
    hands="Jhakri Cuffs +2",
    legs="Nyame Flanchard",
    feet="Leth. Houseaux +3",
    neck="Fotia Gorget",
    waist="Orpheus's Sash",
    left_ear="Moonshade Earring",
    right_ear="Malignance Earring",
    right_ring="Freke Ring",
    left_ring="Cornelia's Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill         	damage +10%','Damage taken-5%',}},
}

sets.precast.WS["Sanguine Blade"] = {
    ammo="Ghastly Tathlum +1",
    head="Pixie Hairpin +1",
    body="Nyame Mail",
    hands="Jhakri Cuffs +2",
    legs="Leth. Fuseau +3",
    feet="Leth. Houseaux +3",
    neck="Baetyl Pendant",
        waist="Orpheus's Sash",
 left_ear="Regal Earring",
        right_ear="Malignance Earring",
    right_ring="Archon Ring",
    left_ring="Cornelia's Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},}


sets.precast.WS["Knights of Round"]
 = {
    ammo="Coiste Bodhar",
    head="Viti. Chapeau +4",
    body="Nyame Mail",
    hands="Atro. Gloves +4",
    legs="Nyame Flanchard",
    feet="Leth. Houseaux +3",
    neck="Rep. Plat. Medal",
    waist="Sailfi Belt +1",
    left_ear="Hoxne Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Cornelia's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}


    sets.midcast.Gravity = {
        main="Daybreak",
        sub="Archduke's Shield",
        ammo="Regal Gem",
        head="Viti. Chapeau +4",
        body="Lethargy Sayon +3",
        hands="Leth. Ganth. +3",
        legs="Atrophy Tights +4",
        feet="Vitiation Boots +4",
        neck="Dls. Torque +2",
        waist="Obstin. Sash",
        left_ear="Malignance Earring",
        right_ear="Snotra Earring",
	left_ring="Kishar Ring",
        right_ring="Metamor. Ring +1",
        back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
    }

sets.buff.Saboteur = {hands="Leth. Ganth. +3"}

    sets.midcast["Gravity II"] = sets.midcast.Gravity
    sets.midcast["Gravity"] = sets.midcast.Gravity


sets.midcast.EnfeeblingMagicINT = {
    main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Regal Gem",
    head="Viti. Chapeau +4",
    body="Lethargy Sayon +3",
    hands="Leth. Ganth. +3",
    legs={ name="Chironic Hose", augments={'Accuracy+20','INT+10','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    feet="Viti. Boots +4",
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Obstin. Sash",
    left_ear="Regal Earring",
    right_ear="Snotra Earring",
    left_ring="Kishar Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},    
}

    sets.midcast["Bind"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Sleep"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Sleep II"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Sleepga"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Sleepga II"] = sets.midcast.EnfeeblingMagicINT    
    sets.midcast["Poison II"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Poison"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Break"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Blind II"] = sets.midcast.EnfeeblingMagicINT
    sets.midcast["Blind"] = sets.midcast.EnfeeblingMagicINT



    sets.midcast.EnfeeblingMagic = {
    main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Regal Gem",
    head="Viti. Chapeau +4",
    body="Lethargy Sayon +3",
    hands="Leth. Ganth. +3",
    legs={ name="Chironic Hose", augments={'"Fast Cast"+5','MND+10','Mag. Acc.+13',}},
    feet="Viti. Boots +4",
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Obstin. Sash",
    left_ear="Regal Earring",
    right_ear="Snotra Earring",
    left_ring="Kishar Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},    
}



    sets.midcast["Slow"] = sets.midcast.EnfeeblingMagic
    sets.midcast["Slow II"] = sets.midcast.EnfeeblingMagic
    sets.midcast["Paralyze"] = sets.midcast.EnfeeblingMagic
    sets.midcast["Paralyze II"] = sets.midcast.EnfeeblingMagic
    sets.midcast["Silence"] = sets.midcast.EnfeeblingMagic  
    sets.midcast["Addle"] = sets.midcast.EnfeeblingMagic
    sets.midcast["Addle II"] = sets.midcast.EnfeeblingMagic



sets.midcast.EnfeeblingMagicSkill = {
    main="Contemplator +1",
    sub="Enki Strap",
    ammo="Regal Gem",
    head="Viti. Chapeau +4",
    body="Lethargy Sayon +3",
    hands="Leth. Ganth. +3",
    legs={ name="Chironic Hose", augments={'"Fast Cast"+5','MND+10','Mag. Acc.+13',}},
    feet="Viti. Boots +4",
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Obstin. Sash",
    left_ear="Regal Earring",
    right_ear="Snotra Earring",
    left_ring="Kishar Ring",
    right_ring="Metamor. Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}

    sets.midcast["Distract"] = sets.midcast.EnfeeblingMagicSkill    
    sets.midcast["Frazzle"] = sets.midcast.EnfeeblingMagicSkill
    sets.midcast["Distract II"] = sets.midcast.EnfeeblingMagicSkill
    sets.midcast["Frazzle II"] = sets.midcast.EnfeeblingMagicSkill
    sets.midcast["Distract III"] = sets.midcast.EnfeeblingMagicSkill    
    sets.midcast["Frazzle III"] = sets.midcast.EnfeeblingMagicSkill


    sets.midcast.EnfeeblingMagicDispel = {
        main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Regal Gem",
    head="Viti. Chapeau +4",
    body="Atrophy Tabard +4",
    hands="Leth. Ganth. +3",
    legs="Atrophy Tights +4",
    feet="Viti. Boots +4",
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Null Belt",
    left_ear="Regal Earring",
    right_ear="Snotra Earring",
    left_ring="Kishar Ring",
    right_ring="Metamor. Ring +1",
    back="Null Shawl",    
}

sets.midcast.Dispel = sets.midcast.EnfeeblingMagicDispel
sets.midcast["Dispelga"] = sets.midcast.EnfeeblingMagicDispel

    sets.midcast.AbsorbTP = {
    ammo="Regal Gem",
    head="Atro. Chapeau +4",
    body="Viti. Tabard +4",
    hands="Atro. Gloves +4",
    legs="Atro. Tights +4",
    feet="Atro. Boots +4",
    neck="Null Loop",
    waist="Null Belt",
    left_ear="Malignance Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Metamor. Ring +1",
    right_ring="Lebeche Ring",
    back="Null Shawl",
}


sets.midcast.drain = {
    main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Regal Gem",
    head="Atro. Chapeau +4",
    body="Viti. Tabard +4",
    hands="Atro. Gloves +4",
    legs="Atrophy Tights +4",
    feet="Atro. Boots +4",
    neck="Erra Pendant",
    waist="Fucho-no-Obi",
    left_ear="Regal Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Kishar Ring",
    right_ring="Evanescence Ring",
    back="Null Shawl",
}

sets.midcast["aspir"] = sets.midcast.drain

    sets.midcast.EnhancingMagicOthers = {
        main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','"Mag.Atk.Bns."+8','DMG:+2',}},
        sub="Ammurapi Shield",
        ammo="Sapience Orb",
        head="Leth. Chappel +3",
        body="Lethargy Sayon +3",
        hands="Atro. Gloves +4",
        legs="Lethargy fuseau +3",
        feet="Leth. Houseaux +3",
        neck={name="Dls. Torque +2", augments={'Path: A',}},
        waist="Embla Sash",
        left_ear={ name="Alabaster Earring", priority=100},
        right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
        left_ring="Murky Ring",
        right_ring="Defending Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +10','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},
    }

    sets.midcast["Haste II"] = sets.midcast.EnhancingMagicOthers
    sets.midcast.Haste = sets.midcast.EnhancingMagicOthers
    sets.midcast["Phalanx II"] = sets.midcast.EnhancingMagicOthers
    sets.midcast["Phalanx"] = sets.midcast.EnhancingMagic
	sets.midcast["Flurry II"] = sets.midcast.EnhancingMagicOthers
    sets.midcast["Protect V"] = sets.midcast.EnhancingMagicOthers
    sets.midcast["Shell V"] = sets.midcast.EnhancingMagicOthers
    sets.midcast["Auspice"] = sets.midcast.EnhancingMagicOthers


    sets.midcast.Regen = {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        ammo="Sapience Orb",
        head="Leth. Chappel +3",
        body="Lethargy Sayon +3",
        hands="Atro. Gloves +4",
        legs="Lethargy fuseau +3",
        feet="Leth. Houseaux +3",
        neck={name="Dls. Torque +2", augments={'Path: A',}},
        waist="Embla Sash",
        left_ear={ name="Alabaster Earring", priority=100},
        right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
        left_ring="Murky Ring",
        right_ring="Defending Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +10','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},
    }

    sets.midcast["Regen"] = sets.midcast.Regen
    sets.midcast["Regen II"] = sets.midcast.Regen


sets.midcast.EnhancingMagicSkill = {
    ammo="Sapience Orb",
    head="Befouled Crown",
    body="Viti. Tabard +4",
    hands="Viti. Gloves +4",
    legs="Atro. Tights +4",
    feet="Leth. Houseaux +3",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Alabaster Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Kishar Ring",
    right_ring="Freke Ring",
    back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +10','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},
}

sets.midcast["Temper II"] = sets.midcast.EnhancingMagicSkill



sets.midcast.EnhancingMagic = {
        main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','"Mag.Atk.Bns."+8','DMG:+2',}},
        sub="Ammurapi Shield",
        ammo="Sapience Orb",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body="Vitiation tabard +4",
        hands="Viti. Gloves +4",
        legs="Telchine Braconi",
        feet="Leth. Houseaux +3",
        neck={name="Dls. Torque +2", augments={'Path: A',}},
        waist="Embla Sash",
        left_ear={ name="Alabaster Earring", priority=100},
        right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
        left_ring="Murky Ring",
        right_ring="Defending Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +10','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},
    }

sets.midcast["Blink"] = sets.midcast.EnhancingMagic
sets.midcast["Blaze Spikes"] = sets.midcast.EnhancingMagic
sets.midcast["Ice Spikes"] = sets.midcast.EnhancingMagic
sets.midcast["Shock Spikes"] = sets.midcast.EnhancingMagic
sets.midcast["Enthunder"] = sets.midcast.EnhancingMagic
sets.midcast["Enstone"] = sets.midcast.EnhancingMagic
sets.midcast["Enaero"] = sets.midcast.EnhancingMagic
sets.midcast["Enblizzard"] = sets.midcast.EnhancingMagic
sets.midcast["Enfire"] = sets.midcast.EnhancingMagic
sets.midcast["Enwater"] = sets.midcast.EnhancingMagic
sets.midcast["Enwater II"] = sets.midcast.EnhancingMagic
sets.midcast["Enthunder II"] = sets.midcast.EnhancingMagic
sets.midcast["Enstone II"] = sets.midcast.EnhancingMagic
sets.midcast["Enaero II"] = sets.midcast.EnhancingMagic
sets.midcast["Enblizzard II"] = sets.midcast.EnhancingMagic
sets.midcast["Enfire II"] = sets.midcast.EnhancingMagic
sets.midcast["Baramnesia"] = sets.midcast.EnhancingMagic
sets.midcast["Barvirus"] = sets.midcast.EnhancingMagic
sets.midcast["Barparalyze"] = sets.midcast.EnhancingMagic
sets.midcast["Barsilence"] = sets.midcast.EnhancingMagic
sets.midcast["Barpetrify"] = sets.midcast.EnhancingMagic
sets.midcast["Barpoison"] = sets.midcast.EnhancingMagic
sets.midcast["Barblind"] = sets.midcast.EnhancingMagic
sets.midcast["Barsleep"] = sets.midcast.EnhancingMagic
sets.midcast["Baramnesra"] = sets.midcast.EnhancingMagic
sets.midcast["Barvira"] = sets.midcast.EnhancingMagic
sets.midcast["Barparalyzra"] = sets.midcast.EnhancingMagic
sets.midcast["Barsilencera"] = sets.midcast.EnhancingMagic
sets.midcast["Barpetra"] = sets.midcast.EnhancingMagic
sets.midcast["Barpoisonra"] = sets.midcast.EnhancingMagic
sets.midcast["Barblindra"] = sets.midcast.EnhancingMagic
sets.midcast["Barsleepra"] = sets.midcast.EnhancingMagic
sets.midcast["Barfira"] = sets.midcast.EnhancingMagic
sets.midcast["Barblizzara"] = sets.midcast.EnhancingMagic
sets.midcast["Baraera"] = sets.midcast.EnhancingMagic
sets.midcast["Barstonra"] = sets.midcast.EnhancingMagic
sets.midcast["Barthundra"] = sets.midcast.EnhancingMagic
sets.midcast["Barwatera"] = sets.midcast.EnhancingMagic
sets.midcast["Barfire"] = sets.midcast.EnhancingMagic
sets.midcast["Barblizzard"] = sets.midcast.EnhancingMagic
sets.midcast["Baraero"] = sets.midcast.EnhancingMagic
sets.midcast["Barstone"] = sets.midcast.EnhancingMagic
sets.midcast["Barthunder"] = sets.midcast.EnhancingMagic
sets.midcast["Barwater"] = sets.midcast.EnhancingMagic


sets.midcast.Gain = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Sapience Orb",
        head="Atro. Chapeau +4",
        body="Vitiation tabard +4",
        hands="Viti. Gloves +4",
        legs="Atrophy tights +4",
        feet="Leth. Houseaux +3",
        neck={name="Dls. Torque +2", augments={'Path: A',}},
        waist="Embla Sash",
        left_ear="Malignance Earring",
        right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
        left_ring="Murky Ring",
        right_ring="Defending Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +10','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},w
    }

sets.midcast["Gain-INT"] = sets.midcast.Gain
sets.midcast["Gain-MND"] = sets.midcast.Gain
sets.midcast["Gain-STR"] = sets.midcast.Gain
sets.midcast["Gain-VIT"] = sets.midcast.Gain
sets.midcast["Gain-AGI"] = sets.midcast.Gain
sets.midcast["Gain-DEX"] = sets.midcast.Gain


    sets.midcast.Refresh = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Sapience Orb",
        head="Amalric Coif +1",
        body="Atrophy Tabard +4",
        hands="Atro. Gloves +4",
        legs="Leth. Fuseau +3",
        feet="Leth. Houseaux +3",
        neck={name="Dls. Torque +2", augments={'Path: A',}},
        waist="Embla Sash",
        left_ear="Malignance Earring",
        right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
        left_ring="Murky Ring",
        right_ring="Defending Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +10','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},
    }

sets.midcast.Refresh = sets.midcast.Refresh
    sets.midcast["Refresh III"] = sets.midcast.Refresh


    sets.midcast.Cure = {
        main="Daybreak",
    sub="Sacro Bulwark",
    ammo="Staunch Tathlum",
    {head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},  priority=36},
    {body="Bunzi's Robe",  priority=72},
    {hands="Leth. Ganth. +3",  priority=155},
    {legs="Atro. Tights +4",  priority=84},
    {feet="Sworn Sabatons", priority=119},
    {neck="Nodens Gorget",  priority=25},
    {waist="Plat. Mog. Belt", priority=200},
    {left_ear="Alabaster Earring", priority=100},
    right_ear="Mendi. Earring",
    left_ring="Murky Ring",
    right_ring="Naji's Loop",
    back="Solemnity Cape",}

    sets.midcast["Cure II"] = sets.midcast.Cure
    sets.midcast["Cure III"] = sets.midcast.Cure
    sets.midcast["Cure IV"] = sets.midcast.Cure
    sets.midcast["Cure V"] = sets.midcast.Cure
    sets.midcast["Curaga"] = sets.midcast.Cure
    sets.midcast["Curaga II"] = sets.midcast.Cure
    sets.midcast["Curaga III"] = sets.midcast.Cure

    sets.midcast.Cursna = {
        head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Viti. Tabard +4",
    hands="Leth. Ganth. +3",
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet="Gende. Galosh. +1",
    neck="Debilis Medallion",
    waist="Tempus Fugit",
    left_ear="Alabaster Earring",
    right_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
    left_ring="Haoma's Ring",
    right_ring="Menelaus's Ring",
    back="Oretan. Cape +1",
    }


    sets.midcast["Cursna"] = sets.midcast.Cursna



  sets.midcast.ElementalMagic = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head="Leth. Chappel +3",
        body="Lethargy Sayon +3",
        hands="Leth. Ganth. +3",
        legs="Leth. Fuseau +3",
        feet="Vitiation Boots +4",
        neck="Sibyl Scarf",
        waist="Acuity Belt +1",
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        right_ring="Freke Ring",
        left_ring="Metamor. Ring +1",
        back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
    }

sets.midcast["Fire"] = sets.midcast.ElementalMagic
sets.midcast["Fire II"] = sets.midcast.ElementalMagic
sets.midcast["Fire III"] = sets.midcast.ElementalMagic
sets.midcast["Fire IV"] = sets.midcast.ElementalMagic
sets.midcast["Fire V"] = sets.midcast.ElementalMagic
sets.midcast["Stone"] = sets.midcast.ElementalMagic
sets.midcast["Stone II"] = sets.midcast.ElementalMagic
sets.midcast["Stone III"] = sets.midcast.ElementalMagic
sets.midcast["Stone IV"] = sets.midcast.ElementalMagic
sets.midcast["Stone V"] = sets.midcast.ElementalMagic
sets.midcast["Aero"] = sets.midcast.ElementalMagic
sets.midcast["Aero II"] = sets.midcast.ElementalMagic
sets.midcast["Aero III"] = sets.midcast.ElementalMagic
sets.midcast["Aero IV"] = sets.midcast.ElementalMagic
sets.midcast["Aero V"] = sets.midcast.ElementalMagic
sets.midcast["Water"] = sets.midcast.ElementalMagic
sets.midcast["Water II"] = sets.midcast.ElementalMagic
sets.midcast["Water III"] = sets.midcast.ElementalMagic
sets.midcast["Water IV"] = sets.midcast.ElementalMagic
sets.midcast["Water V"] = sets.midcast.ElementalMagic
sets.midcast["Thunder"] = sets.midcast.ElementalMagic
sets.midcast["Thunder II"] = sets.midcast.ElementalMagic
sets.midcast["Thunder III"] = sets.midcast.ElementalMagic
sets.midcast["Thunder IV"] = sets.midcast.ElementalMagic
sets.midcast["Thunder V"] = sets.midcast.ElementalMagic
sets.midcast["Blizzard"] = sets.midcast.ElementalMagic
sets.midcast["Blizzard II"] = sets.midcast.ElementalMagic
sets.midcast["Blizzard III"] = sets.midcast.ElementalMagic
sets.midcast["Blizzard IV"] = sets.midcast.ElementalMagic
sets.midcast["Blizzard V"] = sets.midcast.ElementalMagic
sets.midcast["Firaga"] = sets.midcast.ElementalMagic
sets.midcast["Firaga II"] = sets.midcast.ElementalMagic
sets.midcast["Blizzaga"] = sets.midcast.ElementalMagic
sets.midcast["Blizzaga II"] = sets.midcast.ElementalMagic
sets.midcast["Aeroga"] = sets.midcast.ElementalMagic
sets.midcast["Aeroga II"] = sets.midcast.ElementalMagic
sets.midcast["Stonega"] = sets.midcast.ElementalMagic
sets.midcast["Stonega II"] = sets.midcast.ElementalMagic
sets.midcast["Thundaga"] = sets.midcast.ElementalMagic
sets.midcast["Thundaga II"] = sets.midcast.ElementalMagic
sets.midcast["Waterga"] = sets.midcast.ElementalMagic
sets.midcast["Waterga II"] = sets.midcast.ElementalMagic


sets.midcast.Impact= {
    main="Daybreak",
    sub="Archduke's Shield",
    ammo="Regal Gem",
    body="Crepuscular Cloak",
    hands="Atro. Gloves +4",
    legs="Atrophy Tights +4",
    feet="Atro. Boots +4",
    neck="Null Loop",
    waist="Null Belt",
    left_ear="Malignance Earring",
    right_ear="Friomisi Earring",
	right_ring="Freke Ring",
    left_ring="Metamor. Ring +1",
    back="Null Shawl",
}

sets.midcast["Impact"] = sets.midcast.Impact

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
      if (spell.element == world.day_element or spell.element == world.weather_element) then
          equip(sets.Obi)
      end
    end
end


function select_default_macro_book()
    set_macro_page(1, 18)
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 61')
end

function job_precast(spell, action, spellMap, eventArgs)
    check_weaponlock()
end

function check_weaponlock()
    if state.WeaponLock.value then
        disable("main")
        disable("sub")
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
