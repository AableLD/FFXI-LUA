--TP set toggle input: //gs c toggle TP set----1 Standard, 2 Solo, 3 Marches, 4 AccuracyLite, 5 AccuracyMax, 6 DT, 7 DTAccuracy--
--Idle set toggle input: //gs c toggle Idle set----1 Standard, 2 DT--
enmity_spells = S {"Provoke", "Animated Flourish"}

function job_setup()
	state.CP = M(false, "Capacity Points Mode")
	-- include('craft.lua')
	-- init_craft_sets()

end

function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset 121')
end

end

function check_buff(buff_name, eventArgs)
	windower.send_command('/echo "Check Buff"')
	if state.Buff[buff_name] then
		equip(sets.CP)
        disable('back')
	end
end

function get_sets()
	mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	-- state.TreasureMode:set('None')

end

function customize_idle_set(idleSet)
	if buffactive["doom"] or buffactive["curse"] then
		idleSet = set_combine(idleSet, sets.Utility.Doomed)
	end
	if state.IdleMode.value:lower() == "regain" then
		idleSet = set_combine(idleSet, sets.regain)
	end
    return idleSet
end

function customize_melee_set(meleeSet)
	if player.equipment.main == "Chango" then
		TP_ind = TwoHand_ind
	elseif player.equipment.sub == "Blurred Shield +1" then
		TP_ind = OH_ind
	else
		meleeSet = sets.TP.OneHanded
	end
	meleeSet = sets.TP[sets.TP.index[TP_ind]]
	if state.HybridMode.value == "MEVA" then
		meleeSet = sets.TP[sets.TP.index[TP_ind]].MEVA
	elseif state.HybridMode.value == "Mixed" then
		meleeSet = sets.TP[sets.TP.index[TP_ind]].Mixed
	elseif state.HybridMode.value == "PDT" then
		meleeSet = sets.TP[sets.TP.index[TP_ind]].PDT
	elseif state.HybridMode.value == "Test" then
		meleeSet = sets.TP[sets.TP.index[TP_ind]].Test
	end
	if buffactive["doom"] or buffactive["curse"] then
		meleeSet = set_combine(meleeSet, sets.Utility.Doomed)
	end
	return meleeSet
end

function user_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    send_command('bind !f9 gs c cycle TreasureMode')	
	state.IdleMode:options('Normal','DT','Regen','Regain')
	state.HybridMode:options('Normal', 'Mixed', 'MEVA', 'PDT')
    send_command('bind f9 gs c cycle HybridMode')
	select_default_macro_book(4,1)
	set_lockstyle()

end

function user_unload()
		send_command("unbind ^f9")
		send_command("unbind ^f10")
		send_command("unbind ^f11")

		send_command("unbind !f9")
		send_command("unbind !f10")
		send_command("unbind !f11")

		send_command("unbind f9")
		send_command("unbind f10")
		send_command("unbind f11")
end
function init_gear_sets()
	
	Exp_Back = "Mecistopins mantle"

	sets.CP = {
		back = Exp_Back,
	}
	
	--Idle Sets--

	Idle_ind = 1
	Gear_Debug = 0
	Bravura = 0
	Chango = 0
	Sleeping_Mode = 0
	CurrentTP = 0
	TPBonus = 0

	DA_Back = {name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	WSD_Back = {name = "Cichol's Mantle",augments = {"STR+20", "Accuracy+20 Attack+20", "STR+2", "Weapon skill damage +10%"}}
	Crit_Back = {name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	STR_Back = {name = "Cichol's Mantle",augments = {"STR+20", "Accuracy+20 Attack+20", "STR+2", "Weapon skill damage +10%"}}

	TH_Head = {"Valorous Mask"}

-- Idle_Ring2 = "Shneddick Ring"
	Regen_Neck = "Sanctity Necklace"
    --------------------------------------
    -- AF/Relic/Empy Setup
    --------------------------------------
    -- Start Artifact
	Pummeler_Head = "Pummeler's Mask"
	Pummeler_Body = "Pummeler's Lorica +2"
	Pummeler_Legs = "Pummeler's Cuisses +4"
	Pummeler_Feet = "Pummeler's Calligae +4"
	-- The head could be useful for slightly longer aggressor, but we opt not to.
	-- End Artifact (Other pieces on slip)
	-- Start Relic
	Agoge_Head = "Agoge Mask +3"
	Agoge_Body = "Agoge Lorica +1"
	Agoge_Hands = "Agoge Mufflers"
	Agoge_Feet = "Agoge Calligae +1"
	-- End Relic (Other pieces on slip)

	-- Start Empy
	Boii_Head = "Boii Mask +3"
	Boii_Body = "Boii Lorica +3"
	Boii_Hands = "Boii Mufflers +3"
	Boii_Legs = "Boii Cuisses +3"
	Boii_Feet = "Boii Calligae +2"
	Boii_Earring = "Boii Earring +1"
	-- End Empy

	-- Other items we may upgrade directly
	JSE_Neck = "Warrior's Bead Necklace +1"
	
	-- Start sets

	sets.idle = {
	    ammo="Crepuscular Pebble",
    	head="Null Masque",
    	body="Sacro Breastplate",
    	hands="Sakpata's Gauntlets",
    	legs="Sakpata's Cuisses",
    	feet="Nyame Sollerets",
    	neck="Rep. Plat. Medal",
    	waist="Null Belt",
    	left_ear="Alabaster Earring",
    	right_ear="Infused Earring",
    	left_ring="Murky Ring",
    	right_ring="Shneddick Ring",
    	back="Null Shawl",
			}

    sets.TreasureHunter = {
        head = "Valorous Mask",
        ammo = "Perfect Lucky Egg",
        waist="Chaac Belt",
    }

	sets.regain =  {
		head="Null Masque", 
		neck = "Republican Platinum Medal",
	}

	sets.chango = {
		main = "Chango",
		sub = "Utu Grip",
	}

	sets.naegling = {
		main = "Naegling",
		sub = "Blurred Shield +1"
	}

	sets.loxmace = {
		main = "Loxotic Mace +1",
		sub = "Blurred Shield +1"
	}

	sets.shiningone = {
		main = "Shining One",
		sub = "Utu Grip",
	}

	sets.idle.DT = set_combine(sets.idle, {
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	})

	sets.idle.Regen = set_combine(sets.idle, {
		neck = Regen_Neck,
	})

	sets.idle.Regain = sets.regain

	--TP Sets--
	sets.TP = {}

	sets.TP.index = {"OH", "Chango"}
	--1=One Handed, 2=Chango Set
	Melee_Default = 1
	TP_ind = 1
	OH_ind = 1
	TwoHand_ind = 2


	sets.TP.OH = {   
		-- MEVA: 0, MDB: 0, PDT: 56, MDT: 41
		-- STP: 00, DATK: 105
		-- Acc: 1243, Atk: 1497
    	    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Pumm. Calligae +4",
    neck={ name="War. Beads +1", augments={'Path: A',}},
    waist="Sailfi Belt +1",
    left_ear="Schere Earring",
    right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
    left_ring="Murky Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Dbl.Atk."+10','Damage taken-5%',}},

}
	

	sets.TP.OH.Mixed = set_combine(sets.TP.OH,
	{ 
		-- MEVA: 589, MDB: 33, PDT: 49, MDT: 34
		-- STP: 13, DATK: 101 
		-- Acc: 1264, Atk: 1507
		body = "Sakpata's breastplate",
		feet = "Sakpata's Leggings",
	})

	sets.TP.OH.PDT = set_combine(sets.TP.OH, {
		feet = "Sakpata's Leggings"
	})
	
	sets.TP.OH.MEVA = set_combine(sets.TP.OH,{ 
		-- MEVA: 674, MDB: 39, PDT: 50, MDT: 40
		-- STP: 13, DATK: 98
		-- Acc: 1232, Atk: 1531
		body = "Sakpata's Breastplate",
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet = "Sakpata's Leggings",
	})

	sets.TP.OH.Test = sets.TP.OH

	sets.TP.Chango = 

		    {
		-- MEVA: 569, MDB: 31, PDT: 58, MDT: 43
		-- STP: 22, DATK: 100
		-- Acc: 1375, Atk: 1899
		ammo="Coiste Bodhar",
    		head= "Boii Mask +3",
    		body="Boii Lorica +3",
    		hands="Sakpata's Gauntlets",
    		legs="Pumm. Cuisses +4",
    		feet="Pumm. Calligae +4",
    		neck={ name="War. Beads +1", augments={'Path: A',}},
    		waist="Sailfi Belt +1",
    		left_ear="Schere Earring",
    		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+	12','Crit.hit rate+4',}},
    		left_ring="Murky Ring",
    		right_ring="Niqmaddu Ring",
 	   	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Dbl.Atk."+10','Damage taken-5%',}}
}

	sets.TP.Chango.Mixed = 
	set_combine(sets.TP.Chango, {
		left_ear="Cessance Earring",
		right_ring="Regal Ring", -- Mal uses Petrov Ring
	})

	sets.TP.Chango.MEVA = -- 18 STP, 100% DA, 2% TA, 3% QA, 674 MEVA, 39 MDB, 50% PDT, MDT: 40
	set_combine(sets.TP.Chango,{
		head = "Sakpata's Helm",
		body = "Sakpata's Breastplate",
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet = "Sakpata's Leggings",
	})

	sets.TP.Chango.Test =
		set_combine(sets.TP.Chango, {
			head = "Sakpata's Helm",
	})

	sets.TP.H2H = {
		ammo = "Yetshila",
		head = "Hjarrandi Helm",
		neck = JSE_Neck,
		ear2 = "Brutal earring",
		ear1 = "Telos earring",
		body = "Sakpata's breastplate",
		hands = "Sakpata's Gauntlets",
		ring1 = "Niqmaddu ring",
		ring2 = "Flamma ring",
		back = DA_Back,
		waist = "Ioskeha belt +1",
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet = Pummeler_Feet
	}

	sets.TP.AccuracyLite = {
		ammo = "Coiste Bodhar",
		head = Boii_Head,
		neck = JSE_Neck,
		ear2 = "Schere Earring",
		ear1 = "Telos earring",
		body = "Sakpata's breastplate",
		hands = "Sakpata's Gauntlets",
		ring1 = "Regal Ring",
		ring2 = "Chirich Ring +1",
		back = DA_Back,
		waist = "Ioskeha belt +1",
		legs = Pummeler_Legs,
		feet = Pummeler_Feet
	}

	sets.TP.AccuracyFull = {
		ammo = "Coiste Bodhar",
		head = Boii_Head,
		neck = "Subtlety spectacles",
		ear2 = "Dignitary's earring",
		ear1 = "Telos earring",
		body = "Sakpata's breastplate",
		hands = "Sakpata's Gauntlets",
		ring1 = "Regal Ring",
		ring2 = "Chirich Ring +1",
		back = DA_Back,
		waist = "Kentarch belt +1",
		legs = Pummeler_Legs,
		feet = Pummeler_Feet
	}
	--Weaponskill Sets--
	sets.WS = {}

	sets.precast.WS = {
		ammo = "Knobkierrie",
		head = Agoge_Head,
		neck = JSE_Neck,
		ear2 = "Thrud Earring",
		ear1 = "Moonshade earring",
		body = "Nyame Mail",
		hands = Boii_Hands,
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = STR_Back,
		waist = "Sailfi Belt +1",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS,{
		legs = Boii_Legs,
	})

	sets.precast.WS["Judgment"] = set_combine(sets.precast.WS,{
	})

	sets.precast.WS["Stardiver"] = set_combine(sets.precast.WS,{
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		Ear2 = "Boii Earring",
		feet = "Boii feet",
	})

	sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {
		neck = JSE_Neck,
		legs = Boii_Legs,
		Body= "Hjarrandi Breastplate",
		waist="Sailfi Belt +1",
	})

	sets.precast.WS["Requiescat"] = set_combine(sets.precast.WS,{
		ammo="Crepuscular Pebble",
		head="Sakpata's Helm",
		body="Sakpata's breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		ear2="Schere Earring",
	})

	sets.precast.WS["Upheaval"] = set_combine(sets.precast.WS, {
		ring2 = "Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill 		damage +10%',}},

	})

	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
		ring2 = "Niqmaddu Ring",

	})

	sets.precast.WS["Armor Break"] = set_combine(sets.precast.WS, {
		head=Boii_Head,
		body=Boii_Body,
		legs=Boii_Legs,
		feet=Pummeler_Feet,
		waist="Eschan Stone",
		neck="Sanctity Necklace",
		ear1="Crep. Earring",
		ear2="Dignitary's Earring",
		ammo="Pemphredo Tathlum",
	})

	sets.precast.WS["Full Break"] = sets.precast.WS["Armor Break"]

	--Job Ability Sets--
	sets.precast.JA["Berserk"] = {back = "Cichol's Mantle", feet = Agoge_Feet, body=Pummeler_Body}

	sets.precast.JA["Aggressor"] = {body = Agoge_Body, head = "Pummeler's Mask"}

	sets.precast.JA["Warcry"] = {head = Agoge_Head}

	sets.precast.JA["Mighty Strikes"] = {hands = Agoge_Hands}

	sets.precast.JA["Retaliation"] = {feet = Boii_Feet}

	sets.precast.JA["Blood Rage"] = {body = Boii_Body}

	sets.precast.JA["Tomahawk"] = {
		ammo = "Throwing Tomahawk",
		feet = Agoge_Feet,
		waist = "Chaac Belt",
		Legs ="Volte Hose",
		head = "Valorous Mask",}

	sets.Utility = {}
	sets.Utility.Sleeping = {neck = "Opo-Opo Necklace"}

	sets.Utility.Doomed = {waist = "Gishdubar Sash", ring1 = "Purity Ring"}

	sets.enmity = {
		ammo = "Sapience Orb",
		ear2 = "Friomisi Earring",
		back = "Weard Mantle",
		waist = "Trance belt",
		ring2 = "Supershear Ring",
		neck = "Unmoving Collar +1",
		hands = "Souveran Handschuhs +1",
		feet = "Souveran Schuhs +1",
		body=Pummeler_Body,
		ring1 = "Flamma Ring",
		legs = "Souveran Diechlings +1",
		head = "Souveran Schaller +1"
	}

	--Precast Sets--
	sets.precast.FC = {
		ammo = "Impatiens",
		head = "Sakpata's helm",
		neck = "Baetyl Pendant",
		ear1 = "Loquac. Earring",
		ear2 = "Etiolation Earring",
		body = "Odyssean chestplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		ring1 = "Weatherspoon ring",
		ring2 = "murky ring",
		back = "Xucau mantle",
		waist = "Plat. Mog. Belt",
		legs = "Limbo Trousers",
		feet = "Odyssean greaves"
	}

	sets.midcast_dt = set_combine(sets.idle, {
		feet = "Sakpata's Leggings",
	})

	sets.aftercast = {}

end
function job_precast(spell)
	if spell.en == "Holy Water" then
		equip(sets.Utility.Doomed)
	end
end

function job_midcast(spell, act)
	
	if spell.action_type == "Magic" then
		equip(sets.midcast_dt)
		send_command("@input /echo Midcast DT Set")
	end
end

function job_aftercast(spell)
	if player.status == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		-- send_command("@input /echo TP Set")
		if buffactive["doom"] or buffactive["curse"] then
			equip(sets.Utility.Doomed)
		end
		if buffactive["terror"] or buffactive["stun"] or buffactive["sleep"] then
			equip(sets.idle)
		end
	else
		if Gear_Debug == 0 then
			equip(sets.idle.Standard)
			if Sleeping_Mode == 1 then
				equip({neck = "Opo-opo Necklace"})
			else
				equip(sets.idle.Standard)
				send_command("@input /echo Idle Set")
			end
		else
		end
	end
	if spell.interrupted == true then
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo WS failed using Set")
	end
end
function status_change(new, old)
	if new == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if buff == "doom" or buff == "curse" then
			equip(sets.Utility.Doomed)
		end
		if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Ukonvasara" then
			--TP_ind = 12
			equip(sets.TP.UkonAm)
			send_command("@input /echo Ukon AM Set")
		end						
	else
		equip(sets.Idle.Standard)
		if buff == "doom" or buff == "curse" then
			equip(sets.Utility.Doomed)
		end
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
	local last_ind = TP_ind
	if player.equipment.sub == "Utu Grip" then
		TP_ind = TwoHand_ind
	elseif player.equipment.sub == "Blurred Shield +1" then
		TP_ind = OH_ind
	else
		TP_ind = 1
	end
	if player.status == "Engaged" then
		equip(customize_melee_set())
	end
	if check_cmd_param(cmdParams,"chango") then
		equip(sets.chango)
		send_command('input /lockstyleset 21')
		set_macro_page(4, 1)
	elseif check_cmd_param(cmdParams,"shining") then
		equip(sets.shiningone)
		send_command('input /lockstyleset 22')
		set_macro_page(4, 1)
	elseif check_cmd_param(cmdParams,"naegling") then
		equip(sets.naegling)
		send_command('input /lockstyleset 6')
		set_macro_page(4, 1)
	elseif check_cmd_param(cmdParams,"lox") then
		equip(sets.loxmace)
		-- send_command('input /lockstyleset 1')
		send_command('input /lockstyleset 30')
		set_macro_page(4, 1)
	end
end

function self_command(command)
	if command == "equip TP set" then
		if 	player.equipment.main == "Chango" or player.equipment.main == "Montante +1" or
				player.equipment.main == "Raetic Algol +1" or player.equipment.main == "Ukonvasara"
		 then
			TP_ind = 3
			equip(sets.TP[sets.TP.index[TP_ind]])
			send_command("@input /echo Chango Set")
		elseif player.equipment.main == "Zulfiqar" then
			TP_ind = 9
			equip(sets.TP[sets.TP.index[TP_ind]])
			send_command("@input /echo Zulfiqar Set")
		elseif player.equipment.main == "Exalted Spear" or player.equipment.main == "Exalted Spear +1" then
			TP_ind = 3
			equip(sets.TP[sets.TP.index[TP_ind]])
			send_command("@input /echo Spear Set")
		else
			TP_ind = 1
			equip(sets.TP[sets.TP.index[TP_ind]])
			send_command("@input /echo TP Set")
		end
	elseif command == "equip Idle set" then
		equip(sets.Idle.Standard)
		send_command("@input /echo Idle Set")
	elseif command == "equip OH set" then
		TP_ind = 2
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo OH Set")
	elseif command == "equip OHAcc set" then
		TP_ind = 3
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo OHAcc Set")
	elseif command == "equip H2H set" then
		TP_ind = 8
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo H2H Set")
	elseif command == "equip Zulfiqar set" then
		TP_ind = 9
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo Zulfiqar Set")
	elseif command == "equip DW set" then
		TP_ind = 10
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo DW Set")
	elseif command == "equip DT set" then
		if player.equipment.main == "Bravura" and buffactive["Aftermath"] then
			TP_ind = 7
			equip(sets.TP[sets.TP.index[TP_ind]])
			send_command("@input /echo Bravura DT Set")
		else
			TP_ind = 6
			equip(sets.TP[sets.TP.index[TP_ind]])
			send_command("@input /echo DT Set")
		end
	elseif command == "equip DTAM set" then
		TP_ind = 7
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo DTAM Set")
	elseif command == "equip Acc_Lite set" then
		TP_ind = 4
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo Acc_lite Set")
	elseif command == "equip Acc_Full set" then
		TP_ind = 5
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo Acc_Full Set")
	elseif command == "equip Hybrid set" then
		TP_ind = 11
		equip(sets.TP.Hybrid)
		send_command("@input /echo Hybrid Set")
	
	elseif command == "change debug mode" then
		if Gear_Debug == 1 then
			Gear_Debug = 0
			send_command("@input /echo Debug Mode Set to 0")
		else
			Gear_Debug = 1
			send_command("@input /echo Debug Mode Set to 1")
		end
	end
end

function buff_change(buff, gain)
	if (buff == "terror" or buff == "stun" or (buff == "sleep" or buff == "lullaby")) then
		if gain then
			if player.status == "Engaged" then
				equip(sets.TP.DT)
			elseif player.status == "Idle" then
				equip(sets.TP.DT)
			end
		else
			if player.status == "Engaged" then
				equip(sets.TP[sets.TP.index[TP_ind]])
				if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Ukonvasara" then
					--TP_ind = 12
					equip(sets.TP.UkonAm)
					send_command("@input /echo Ukon AM Set")
				end				
			elseif player.status == "Idle" then
				equip(sets.Idle[sets.Idle.index[Idle_ind]])
			end
		end
	end
	if buff == "doom" or buff == "curse" then
		if gain then
			equip(sets.Utility.Doomed)
		else
			if player.status == "Engaged" then
				equip(sets.TP[sets.TP.index[TP_ind]])
			elseif player.status == "Idle" then
				equip(sets.Idle[sets.Idle.index[Idle_ind]])
			end
		end
	end
end

windower.register_event(
	"zone change",
	function()
		equip(sets.idle)
	end
)


function select_default_macro_book()
    set_macro_page(4, 1)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 6')
end