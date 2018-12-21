/obj/item/weapon/gun/energy/gun
	name = "energy gun"
	desc = "Another bestseller of Lawson Arms and the FTU, the LAEP90 Perun is a versatile energy based sidearm, capable of switching between low, medium and high power projectile settings. In other words: stun, shock or kill."
	icon_state = "energystun100"
	item_state = null	//so the human update icon uses the icon_state instead.
	max_shots = 10
	fire_delay = 10 // To balance for the fact that it is a pistol and can be used one-handed without penalty

	projectile_type = /obj/item/projectile/beam/stun
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	modifystate = "energystun"

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="energystun"),
		list(mode_name="shock", projectile_type=/obj/item/projectile/beam/stun/shock, modifystate="energyshock"),
		list(mode_name="kill", projectile_type=/obj/item/projectile/beam, modifystate="energykill"),
		)

/obj/item/weapon/gun/energy/gun/small
	name = "small energy gun"
	desc = "A smaller model of the versatile LAEP90 Perun, the LAEP90-C packs considerable utility in a smaller package. Best used in situations where full-sized sidearms are inappropriate."
	icon_state = "smallgunstun"
	max_shots = 5
	w_class = ITEM_SIZE_SMALL
	force = 2 //it's the size of a car key, what did you expect?
	modifystate = "smallgunstun"

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="smallgunstun"),
		list(mode_name="shock", projectile_type=/obj/item/projectile/beam/stun/shock, modifystate="smallgunshock"),
		list(mode_name="kill", projectile_type=/obj/item/projectile/beam/smalllaser, modifystate="smallgunkill"),
		)

/obj/item/weapon/gun/energy/gun/captain
	name = "Bolt 2411"
	desc = "A true classic. Powerful and deadly, this chromed compact energy pistol is as much a fine-tuned personal defense weapon as it is a collector's item. Comes with a polished walnut stock."
	cell_type = "/obj/item/weapon/cell/apc"
	icon_state = "capenergystun100"
	fire_sound = 'sound/weapons/Taser.ogg'

	charge_cost = 5 //How much energy is needed to fire.
	projectile_type = /obj/item/projectile/beam/stun/heavy
	origin_tech =  list(TECH_COMBAT = 4, TECH_MAGNET = 3)
	modifystate = "capenergystun"
	w_class = ITEM_SIZE_SMALL

	firemodes = list(
		list(name="stun", charge_cost=50, projectile_type=/obj/item/projectile/beam/stun, modifystate="capenergystun"),
		list(name="super stun", charge_cost=200, projectile_type=/obj/item/projectile/beam/stun/heavy, modifystate="capenergystun"),
		list(name="lethal", charge_cost=100, projectile_type=/obj/item/projectile/beam/smalllaser, modifystate="capenergykill"),
		list(name="very lethal", charge_cost=500, projectile_type=/obj/item/projectile/beam/heavylaser , modifystate="capenergykill"),
		)

/obj/item/weapon/gun/energy/gun/mounted
	name = "mounted energy gun"
	self_recharge = 1
	use_external_power = 1
	has_safety = FALSE

/obj/item/weapon/gun/energy/gun/nuclear
	name = "advanced energy gun"
	desc = "An energy gun with an experimental miniaturized reactor."
	icon_state = "nucgun"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 5, TECH_POWER = 3)
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_LARGE
	force = 8 //looks heavier than a pistol
	self_recharge = 1
	modifystate = null
	one_hand_penalty = 1 //bulkier than an e-gun, but not quite the size of a carbine

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun),
		list(mode_name="shock", projectile_type=/obj/item/projectile/beam/stun/shock),
		list(mode_name="kill", projectile_type=/obj/item/projectile/beam),
		)

	var/fail_counter = 0

//override for failcheck behaviour
/obj/item/weapon/gun/energy/gun/nuclear/Process()
	if(fail_counter > 0)
		SSradiation.radiate(src, fail_counter--)

	return ..()

/obj/item/weapon/gun/energy/gun/nuclear/emp_act(severity)
	..()
	switch(severity)
		if(1)
			fail_counter = max(fail_counter, 30)
			visible_message("\The [src]'s reactor overloads!")
		if(2)
			fail_counter = max(fail_counter, 10)
			if(ismob(loc))
				to_chat(loc, "<span class='warning'>\The [src] feels pleasantly warm.</span>")

/obj/item/weapon/gun/energy/gun/nuclear/proc/get_charge_overlay()
	var/ratio = power_supply.percent()
	ratio = round(ratio, 25)
	return "nucgun-[ratio]"

/obj/item/weapon/gun/energy/gun/nuclear/proc/get_reactor_overlay()
	if(fail_counter)
		return "nucgun-medium"
	if (power_supply.percent() <= 50)
		return "nucgun-light"
	return "nucgun-clean"

/obj/item/weapon/gun/energy/gun/nuclear/proc/get_mode_overlay()
	var/datum/firemode/current_mode = firemodes[sel_mode]
	switch(current_mode.name)
		if("stun") return "nucgun-stun"
		if("kill") return "nucgun-kill"

/obj/item/weapon/gun/energy/gun/nuclear/on_update_icon()
	var/list/new_overlays = list()

	new_overlays += get_charge_overlay()
	new_overlays += get_reactor_overlay()
	new_overlays += get_mode_overlay()

	overlays = new_overlays
