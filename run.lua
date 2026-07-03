 function get_sets()
	


send_command('bind !f9 gs c toggle TP set')
send_command('bind ^f9 gs c toggle DW set')




send_command('bind !f10 gs c toggle Weaponskill sets')
send_command('bind ^f10 gs c toggle Idle set')




send_command('bind f9 input /ja "Gambit" <t>')
send_command('bind f10 input /ja "Lunge" <t>')
send_command('bind f11 input /ja "Swipe" <t>')
send_command('bind f12 input /ma "Flash" <t>')



send_command('bind !f12 input /ws "Dimidiation" <t>')

function file_unload()
	

	send_command('unbind ^f9')
	send_command('unbind ^f10')
	
	send_command('unbind !f9')
	send_command('unbind !f10')
	send_command('unbind !f12')

	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind f12')

	

end


	-- JA Sets for Precast Function --	
	sets.JA = {}
	
	sets.JA['Elemental Sforzo'] = {body="Futhark Coat +2",hands="Kurys gloves",legs="Erilaz leg guards +3",feet="Erilaz greaves +2"}
	sets.JA['Vallation'] = {body="Runeist's Coat +2",hands="Kurys gloves",legs="Futhark Trousers +2",feet="Erilaz greaves +1",back="Ogma\'s Cape"}
	sets.JA['Valiance'] = {body="Runeist's Coat +4",hands="Kurys gloves",legs="Futhark Trousers +2",feet="Erilaz greaves +1",back="Ogma\'s Cape"}
	sets.JA['Pflug'] = {feet="Runeist Bottes +1",hands="Kurys gloves"}
	sets.JA['Swordplay'] = {hands="Futhark Mitons +3",legs="Erilaz leg guards +3",feet="Erilaz greaves +2"}
	sets.JA['Gambit'] = {hands="Runeist's Mitons +2",feet="Erilaz greaves +2"}
	sets.JA['Liement'] = {body="Futhark Coat +1",hands="Kurys gloves",legs="Erilaz leg guards +3",feet="Erilaz greaves +2"}
	sets.JA['Battuta'] = {head="Fu. Bandeau +4",hands="Kurys gloves",legs="Erilaz leg guards +3"}
	sets.JA['Embolden'] = {back="Evasionist's Cape"}
	sets.JA['Vivacious Pulse'] = {head="Erilaz Galea +1",hands="Kurys gloves",legs="Runeist Trousers +1",ring2="Globidonta Ring",feet="Erilaz greaves +2"}
	sets.JA['Rayke'] = {feet="Futhark Boots +1",hands="Kurys gloves"}
	
	sets.JA['Lunge'] = {ammo="Pemphredo Tathlum",
    head="Herculean Helm",
    body="Carmine Scale Mail +1",
    hands="Carmine Finger Gauntlets +1",
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +2%','"Mag.Atk.Bns."+11',}},
    feet="Adhemar Gamashes +1",
    neck="Sanctity Necklace",
    waist="Eschan Belt",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Acumen Ring",
    right_ring="Fenrir Ring +1",
    back="Argocham. Mantle"}
	
	
	
	-- TP/Engaged sets --
    sets.TP = {}
	sets.TP.index = {'Reg', 'MAcc', 'HAcc', 'PDT', 'PDTA','DW','DWA','DWP','DWPA','JP','Multi','Mag'}
	TP_index = 1
	
	sets.TP.Reg = {
    sub="Utu Grip",
ammo="Yamarang",
    head="Fu. Bandeau +4",
    body="Runeist Coat",
    hands="Erilaz Gauntlets +1",
    legs="Eri. Leg Guards +3",
    feet="Erilaz Greaves +2",
    neck="Null Loop",
    waist="Sailfi Belt +1",
    left_ear="Cessance Earring",
    right_ear="Sherida Earring",
    left_ring="Moonlight Ring",
    right_ring="Murky Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},}
    
	sets.TP.MAcc = set_combine(sets.TP.Reg,{hands="Meghanada Gloves +2",legs="Meghanada Chausses +2",back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}})
	
	sets.TP.HAcc = {
    ammo="Yamarang",
    head="Fu. Bandeau +4",
    body="Runeist Coat",
    hands="Erilaz Gauntlets +1",
    legs="Eri. Leg Guards +3",
    feet="Erilaz Greaves +2",
    neck="Null Loop",
    waist="Sailfi Belt +1",
    left_ear="Cessance Earring",
    right_ear="Sherida Earring",
    left_ring="Moonlight Ring",
    right_ring="Murky Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}
	
	sets.TP.PDT = {
    ammo="Yamarang",
    head="Fu. Bandeau +4",
    body="Runeist Coat",
    hands="Erilaz Gauntlets +1",
    legs="Eri. Leg Guards +3",
    feet="Erilaz Greaves +2",
    neck="Null Loop",
    waist="Sailfi Belt +1",
    left_ear="Cessance Earring",
    right_ear="Sherida Earring",
    left_ring="Moonlight Ring",
    right_ring="Murky Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}	
	sets.TP.PDTA ={
     ammo="Yamarang",
    head="Fu. Bandeau +4",
    body="Runeist Coat",
    hands="Erilaz Gauntlets +1",
    legs="Eri. Leg Guards +3",
    feet="Erilaz Greaves +2",
    neck="Null Loop",
    waist="Sailfi Belt +1",
    left_ear="Cessance Earring",
    right_ear="Sherida Earring",
    left_ring="Moonlight Ring",
    right_ring="Murky Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}
	
	
	
	sets.TP.DW = set_combine(sets.TP.Reg,{ear1="Suppanomimi",ear2="Sherida Earring"})
	
	sets.TP.DWA = set_combine(sets.TP.Acc,{ear1="Suppanomimi",ear2="Sherida Earring"})
	
	sets.TP.DWP = set_combine(sets.TP.PDT,{ear1="Suppanomimi",ear2="Sherida Earring"})
	
	sets.TP.DWPA = set_combine(sets.TP.PDTA,{ear1="Suppanomimi",ear2="Sherida Earring"})
	
	sets.TP.JP = set_combine(sets.TP[sets.TP.index[TP_index]], {back="Mecistopins Mantle"})
	
	sets.TP.Multi = set_combine(sets.TP.Reg,{body="Thaumas Coat"})
	
	sets.TP.Mag = set_combine(sets.TP.PDT,{body="Runeist's Coat +2",back="Engulfer Cape +1",hands="Erilaz Gauntlets +1"})
	

	 
	
	
	
	-- Idle Sets --
	sets.Idle = {}
	sets.Idle.index = {'Move','Regen','Refresh','PDT','CP'}
	Idle_index = 1
	
	
	sets.Idle.Regen = {head="Null Masque",
		neck="Sanctity Necklace",
		ear2="Infused Earring",
		waist="Null Belt",
		}
	
	sets.Idle.Refresh = sets.Idle.PDT
	
	sets.Idle.PDT = {
		ammo="Staunch Tathlum",
    		head="Null Masque",
    		body="Runeist Coat +4",
    		hands="Nyame Gauntlets",
    		legs="Eri. Leg Guards +3",
    		feet="Erilaz Greaves +2",
    		neck="Rep. Plat. Medal",
    		waist="Carrier's Sash",
    		left_ear="Alabaster Earring",
    		right_ear={ name="Erilaz Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Damage taken-4%',}},
    		left_ring="Shneddick Ring",
    		right_ring="Shadow Ring",
		    back="Mecistopins Mantle",
		}
	
	sets.Idle.CP = set_combine(sets.Idle.PDT,{back="Mecistopins Mantle"})
	
	sets.Idle.Move = set_combine(sets.Idle.PDT,{left_ring="Shneddick Ring"})
	
	--WS Resolution Set -- 

	sets.WS = {}
	sets.Resolution = {}
	sets.Resolution.index = {'Normal','Accuracy'}
	Resolution_index = 1
	
	sets.Resolution.Normal = {ammo="Coiste Bodhar",
 		   head="Nyame Helm",
    		body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Sailfi Belt +1",
    left_ear="Moonshade Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}
	
	sets.Resolution.Accuracy = {ammo="Coiste Bodhar",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Sailfi Belt +1",
    left_ear="Moonshade Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}
	
	sets.Resolution.R = set_combine(sets.Resolution.Normal,{neck="Ygnas's Resolve +1"})

	sets.Dimidiation = {}
	sets.Dimidiation.index = {'Normal','Accuracy'}
	Dimidiation_index = 1
	
	sets.Dimidiation.Normal = {ammo="Knobkierrie",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Rep. Plat. Medal",
    waist="Sailfi Belt +1",
    left_ear="Moonshade Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}
	
	sets.Dimidiation.Accuracy = {ammo="Knobkierrie",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Rep. Plat. Medal",
    waist="Sailfi Belt +1",
    left_ear="Moonshade Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}
	
	sets.Dimidiation.R = set_combine(sets.Dimidiation.Normal,{neck="Ygnas's Resolve +1"})
	
	
	-- WS Requiescat Set --  
			
	sets.Requiescat = {}
	sets.Requiescat.index = {'Normal','Accuracy'}
	Requiescat_index = 1

	sets.Requiescat.Normal = {ammo="Knobkierrie",
			head="Whirlpool Mask",
			neck="Fotia Gorget",
			ear1="Moonshade Earring",
			ear2="Sherida Earring",
			body="Adhemar Jacket +1",
			hands="Futhark Mitons +1",
			ring1="Aquasoul Ring",
			ring2="Niqmaddu Ring",
			back="Atheling Mantle",
			waist="Fotia Belt",
			legs="Manibozho Brais",
			feet={ name="Qaaxo Leggings", augments={'Attack+15','"Mag.Atk.Bns."+15','STR+12',}}}
	
	sets.Requiescat.Accuracy = {ammo="Honed Tathlum",
			head="Whirlpool Mask",
			neck="Fotia Gorget",
			ear1="Moonshade Earring",
			ear2="Sherida Earring",
			body="Adhemar Jacket +1",
			hands="Buremte Gloves",
			ring1="Aquasoul Ring",
			ring2="Niqmaddu Ring",
			back="Atheling Mantle",
			waist="Fotia Belt",
			legs="Ighwa Trousers",
			feet={ name="Qaaxo Leggings", augments={'Attack+15','"Mag.Atk.Bns."+15','STR+12',}}}
				
	-- WS Ruinator Set --

	sets.Ruinator = {}
	sets.Ruinator.index = {'Normal','Accuracy'}
	Ruinator_index = 1
	
	sets.Ruinator.Normal = {ammo="Knobkierrie",
			head="Whirlpool Mask",
			neck="Fotia Gorget",
			ear1="Moonshade Earring",
			ear2="Sherida Earring",
			body="Adhemar Jacket +1",
			hands="Futhark Mitons +1",
			ring1="Rajas Ring",
			ring2="Niqmaddu Ring",
			back="Atheling Mantle",
			waist="Fotia Belt",
			legs="Manibozho Brais",
			feet={ name="Qaaxo Leggings", augments={'Attack+15','"Mag.Atk.Bns."+15','STR+12',}}}
			
	sets.Ruinator.Accuracy = {ammo="Honed Tathlum",
			head="Whirlpool Mask",
			neck="Fotia Gorget",
			ear1="Moonshade Earring",
			ear2="Sherida Earring",
			body="Adhemar Jacket +1",
			hands="Buremte Gloves",
			ring1="Rajas Ring",
			ring2="Epona's Ring",
			back="Atheling Mantle",
			waist="Fotia Belt",
			legs="Ighwa Trousers",
			feet={ name="Qaaxo Leggings", augments={'Attack+15','"Mag.Atk.Bns."+15','STR+12',}}}
			
	-- Precast Spell sets --
	sets.precast = {}
	sets.precast.FC = {}

	sets.precast.FC = {ammo="Sapience Orb",
    head="Rune. Bandeau +2",
    body="Erilaz Surcoat +2",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Eri. Leg Guards +3",
    feet="Erilaz Greaves +2",
    neck="Voltsurge Torque",
    waist="Cornelia's Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}

	sets.precast.FC.Enhancing = set_combine(sets.precast.FC,{hands="Runeist Mitons +2",neck="Incanter's Torque",waist="Siegel Sash",legs="Futhark Trousers +1"})
				
	sets.precast.FC.Divine = set_combine(sets.precast.FC,{legs="Runeist Trousers +1"})
	
	sets.precast.FC.Refresh = set_combine(sets.precast.FC.Enhancing,{head="Erilaz Galea +1"})
	
	--Phalanx Utility--
	sets.Utility = {}
	
	sets.Utility.Phalanx = set_combine(sets.precast.FC.Enhancing,{
	head="Futhark Bandeau +4",})
	
	sets.Utility.Temper = set_combine(sets.precast.FC.Enhancing,{legs="Runeist Trousers +1"})

	sets.Utility.Stoneskin = {ammo="Sapience Orb",
    head="Rune. Bandeau +2",
    body="Erilaz Surcoat +2",
    hands="Stone Mufflers",
    legs="Eri. Leg Guards +3",
    feet="Erilaz Greaves +2",
    neck="Stone Gorget",
    waist="Siegel Sash",
    left_ear="Earthcry Earring",
    right_ear="Etiolation Earring",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}
	sets.Utility.Blue = {
	ammo="Sapience Orb",
    head="Rune. Bandeau +2",
    body="Erilaz Surcoat +2",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Eri. Leg Guards +3",
    feet="Erilaz Greaves +2",
    neck="Voltsurge Torque",
    waist="Cornelia's Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+2',}},
}

	sets.Utility.WC = {head={ name="Fu. Bandeau +4", augments={'Enhances "Battuta" effect',}},
    body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
    hands={ name="Futhark Mitons +1", augments={'Enhances "Sleight of Sword" effect',}},
    legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
    feet={ name="Futhark Boots +1", augments={'Enhances "Rayke" effect',}},
    neck="Tjukurrpa Medal",
    waist="Luminary Sash",
    left_ear="Lifestorm Earring",
    right_ear="Upsurge Earring",
    left_ring="Defending Ring",
    right_ring="Murky Ring",
    back="Iximulew Cape",
}
	--Copy and pasted set from Snprphnx_SCH example--      
        --Obis--
         sets.Obi = {}
         sets.Obi.Fire = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
         sets.Obi.Earth = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
         sets.Obi.Water = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
         sets.Obi.Wind = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
         sets.Obi.Ice = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
         sets.Obi.Thunder = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
         sets.Obi.Light = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
         sets.Obi.Dark = {waist='Hachirin-no-Obi',ring2='Zodiac Ring'}
  
  -----Tengu
	--sets.tengu = {ammo="Tengu-No-Hane"}  

end

--Precast Actions--

function precast(spell,act)
--intentionally not calling the ~= operator
	if spell.type == 'JobAbility' then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	end

	if spell.skill == 'Blue Magic' then
		equip(sets.precast.FC)
	end

	if spell.type == 'Dark' then
		equip(sets.precast.FC)
	end

	if spell.type == 'WeaponSkill' then
		equip(sets.Dimidiation.Normal)
	end

-- Ward and Effusion are being specifically indicated for the purpose of ensuring Rayke/Gambit sets actually work.

	if spell.type == 'Ward' then
		equip(sets.JA[spell.english])
	end
	
	if spell.type == 'Effusion' then
		equip(sets.JA[spell.english])
	end
	
	if spell.action_type == 'Enhancing' then
		equip(sets.precast.FC.Enhancing)
	end
	
	if spell.action_type == 'Divine' then	
		equip(sets.precast.FC.Divine)
	end
	
	if spell.action_type == 'Magic' then
		equip(sets.precast.FC)
	end
	
	if spell.action_type == 'Ninjutsu' then
		equip(sets.precast.FC)
	end
	
	if spell.english == "Refresh" then
		equip(sets.precast.FC.Refresh)
	end
	
	if spell.english == 'Lunge' or spell.english == 'Swipe' then
		equip(sets.JA['Lunge'])
		if spell.element == world.weather_element or spell_element == world.day_element then
                        equip(sets.JA['Lunge'],sets.Obi[spell.element])
		end
	end

--Basic calls for WS and defined sets. You can get more advanced if you want sets based on TP levels. EX:
-- 	if player.tp >= 2300 and (spell.english == "Resolution") then
		--	equip(sets.Resolution.Max)
--	end
	--Where sets.Resolution.Max would be a WS set that makes use of Aeonic TP Bonus 
	-- allowing for maxing out the set like when in possesion of 3k TP 	
	--Can also do similar conditions with respect to HP and MP levels for other actions with player.hp or hpp, mp or mpp etc. 
	
	if spell.english == "Resolution" then
		equip(sets.Resolution[sets.Resolution.index[Resolution_index]])
	end
	
	if spell.english == "Requiescat" then
		equip(sets.Requiescat[sets.Requiescat.index[Requiescat_index]])
	end
	
	if spell.english == "Ruinator" then
		equip(sets.Ruinator[sets.Ruinator.index[Ruinator_index]])
	end
	
	if spell.english == "Dimidiation" then
		equip(sets.Dimidiation[sets.Dimidiation.index[Dimidiation_index]])
	end	
	
	if spell.english == "Herculean Slash" then
		equip(sets.JA['Lunge'])
	end
	
	if buffactive['Reive Mark'] and spell.type == 'WeaponSkill' then
		equip(sets.Resolution.R)
	end
	
	if buffactive['Reive Mark'] and spell.english == 'Dimidiation' then
		equip(sets.Dimidiation.R)
	end
	
	if buffactive['Reive Mark'] and spell.english == 'Resolution' then
		equip(sets.Resolution.R)
	end
	
	if buffactive['Tenebrae'] and spell.english == 'Lunge' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end
	
	if buffactive['Tenebrae'] and spell.english == 'Swipe' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end
	
	if buffactive['Lux'] and spell.english == 'Lunge' then
		equip(sets.JA.Lunge,{ring2="Weatherspoon Ring +1"})
	end
	
	if buffactive['Lux'] and spell.english == 'Swipe' then
		equip(sets.JA.Lunge,{ring2="Weatherspoon Ring +1"})
	end
	
end

--Midcast functions for spells--

function midcast(spell,act)

	if spell.type == 'WeaponSkill' then
		equip(sets.Dimidiation.Normal)
	end

	if spell.skill == 'Blue Magic' then
		equip(sets.Utility.Blue)
	end

	if spell.english == 'Phalanx' then
		equip(sets.Utility.Phalanx)
	end
	
	if spell.type == 'Dark' then
		equip(sets.Utility.Blue)
	end

	if spell.english == 'Wild Carrot' then
		equip(sets.Utility.WC)
	end
	
	if spell.english == 'Flash' then
		equip(sets.precast.FC.Divine)
	end

	if spell.english == 'Regen IV' then
		equip(sets.precast.FC.Enhancing)
	end
	
	if spell.english == "Refresh" then
		equip(sets.precast.FC.Refresh)
	end
	
	if spell.english == "Temper" then
		equip(sets.Utility.Temper)
	end
	
	if spell.english == "Stoneskin" then
		equip(sets.Utility.Stoneskin)
	end
	
	if spell.type == 'JobAbility' then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	end
	
	if spell.type == 'Ward' then
		equip(sets.JA[spell.english])
	end
	
	if spell.type == 'Effusion' then
		equip(sets.JA[spell.english])
	end


	if spell.english == 'Lunge' or spell.english == 'Swipe' then
		equip(sets.JA['Lunge'])
		if spell.element == world.weather_element or spell_element == world.day_element then
                        equip(sets.JA['Lunge'],sets.Obi[spell.element])
		end
	end
	
	if spell.english == "Resolution" then
		equip(sets.Resolution[sets.Resolution.index[Resolution_index]])
	end
	
	if spell.english == "Requiescat" then
		equip(sets.Requiescat[sets.Requiescat.index[Requiescat_index]])
	end
	
	if spell.english == "Ruinator" then
		equip(sets.Ruinator[sets.Ruinator.index[Ruinator_index]])
	end
	
	if spell.english == "Dimidiation" then
		equip(sets.Dimidiation[sets.Dimidiation.index[Dimidiation_index]])
	end	
	
	if spell.english == "Herculean Slash" then
		equip(sets.JA['Lunge'])
	end
	
	if buffactive['Reive Mark'] and spell.type == 'WeaponSkill' then
		equip(sets.Resolution.R)
	end
	
	if buffactive['Reive Mark'] and spell.english == 'Dimidiation' then
		equip(sets.Dimidiation.R)
	end
	
	if buffactive['Reive Mark'] and spell.english == 'Resolution' then
		equip(sets.Resolution.R)
	end
	
	if buffactive['Tenebrae'] and spell.english == 'Lunge' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end
	
	if buffactive['Tenebrae'] and spell.english == 'Swipe' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end
	
	--if spell.name == 'Resolution' or spell.name == "Dimidiation" then
       --     tengu_handler()
     --   end
	
--Tengu no longer needed in the current sets, but keeping to demonstrate how to call a function to equip desired sets or slots.
	
end

--function tengu_handler()
  --  if world.time >= 360 and world.time <= 1080 then -- 6~18
  --      equip(sets.tengu)
 --   end
--end
--Aftercast function, returns user to TP set after actions/spells--

function aftercast(spell,act)
	
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_index]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_index]])
	end
	
	if player.status == 'Engaged' and buffactive['Battuta'] then
		equip{feet="Futhark Boots +1",hands="Turms Mittens +1"}
	end	

	if player.status == 'Engaged' and buffactive['Reive Mark'] then
                equip{neck="Ygnas's Resolve +1"}
       end
end

function buff_change(new,old)
	if buffactive['Battuta'] then
		equip{feet="Futhark Boots +1",hands="Turms Mittens +1"}
	end

	if buffactive['Embolden'] then
		equip{back="Evasionist's Cape"}
	end
	
	if player.status == 'Engaged' and buffactive['Reive Mark'] then
                equip{neck="Ygnas's Resolve +1"}
        end
	
end

--Status Change function, switches user to TP set upon engaging--

function status_change(new,old)

	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_index]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_index]])
	end

	if buffactive['Battuta'] and new == 'Engaged' then
		equip{feet="Futhark Boots +3",hands="Turms Mittens +1"}
	end
	
	--if (buffactive['aftermath: lv.3'] and os.clock() - AM_start >= 160) then
	--	send_command('@ input /echo >>> Aftermath ends in 20 secs')
	--end
	
	if player.status == 'Engaged' and buffactive['Reive Mark'] then
                equip{neck="Ygnas's Resolve +1"}
        end
end




--Toggle Command functions--
--Gearswap direct command = //gs c toggle 'x' set
--Macro line = /console gs c toggle x set
--ex: console gs c toggle TP set
-- Index is set to 1 or 'Reg', press button once to switch to 'Acc', and so on.

function self_command(command)
	if command == 'toggle TP set' then	
		if TP_index < 5 then
		TP_index = TP_index +1
		else TP_index = 1 end
		send_command('@ input /echo >>> TP set changed to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])
    
	elseif command == 'toggle DW set' then
		if TP_index < 9 and TP_index > 5 then
		TP_index = TP_index +1
		else TP_index = 6 end
		send_command('@ input /echo >>> DW set changed to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])
	
	elseif command == 'toggle dTP set' then
		if TP_index < 6 and TP_index > 1 then
		TP_index = TP_index -1
		else TP_index = 5 end
		send_command('@ input /echo >>> DW set changed to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])
	
	
	elseif command == 'toggle Weaponskill sets' then
		Resolution_index = Resolution_index +1
		if Resolution_index > #sets.Resolution.index then Resolution_index = 1 end
		Requiescat_index = Requiescat_index +1
		if Requiescat_index > #sets.Requiescat.index then Requiescat_index = 1 end
		Ruinator_index = Ruinator_index +1
		if Ruinator_index > #sets.Ruinator.index then Ruinator_index = 1 end
		Dimidiation_index = Dimidiation_index +1
		if Dimidiation_index > #sets.Dimidiation.index then Dimidiation_index = 1 end
		send_command('@ input /echo >>> All Weaponskill sets changed to '..sets.Dimidiation.index[Dimidiation_index]..' ')
		
	elseif command == 'toggle JP set' then
		if TP_index < 10 and TP_index > 0 then
		TP_index = 10 end
		send_command('@ input /echo >>> TP set changed to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])
	
	elseif command == 'toggle Multi set' then
		if TP_index < 11 and TP_index > 0 then
		TP_index = 11 end
		send_command('@ input /echo >>> TP set change to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])
	
	elseif command == 'toggle Magic set' then
		if TP_index < 12 and TP_index > 0 then
		TP_index = 12 end
		send_command('@ input /echo >>> Defense set changed to '..sets.TP.index[TP_index]..' ')
		equip(sets.TP[sets.TP.index[TP_index]])
	
	elseif command == 'toggle Idle set' then
		Idle_index = Idle_index +1
		if Idle_index > #sets.Idle.index then Idle_index = 1 end
		send_command('@ input /echo >>> Idle set changed to '..sets.Idle.index[Idle_index]..' ')
		equip(sets.Idle[sets.Idle.index[Idle_index]])

	end
	
end