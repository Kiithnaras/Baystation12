//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/obj/machinery/door
	name = "Door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/Doorint.dmi'
	icon_state = "door1"
	anchored = 1
	opacity = 1
	density = 1
	layer = 2.7

	var/secondsElectrified = 0
	var/visible = 1
	var/p_open = 0
	var/operating = 0
	var/autoclose = 0
	var/glass = 0
	var/normalspeed = 1
	var/heat_proof = 0 // For glass airlocks/opacity firedoors
	var/air_properties_vary_with_direction = 0
	var/aforce = 0

	//Multi-tile doors
	dir = EAST
	var/width = 1

/obj/machinery/door/New()
	. = ..()
	if(density)
		layer = 3.1 //Above most items if closed
		explosion_resistance = initial(explosion_resistance)
		update_heat_protection(get_turf(src))
	else
		layer = 2.7 //Under all objects if opened. 2.7 due to tables being at 2.6
		explosion_resistance = 0


	if(width > 1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size

	update_nearby_tiles(need_rebuild=1)
	return


/obj/machinery/door/Del()
	density = 0
	update_nearby_tiles()
	..()
	return

//process()
	//return

/obj/machinery/door/Bumped(atom/AM)
	if(p_open || operating) return
	if(ismob(AM))
		var/mob/M = AM
		if(world.time - M.last_bumped <= 10) return	//Can bump-open one airlock per second. This is to prevent shock spam.
		M.last_bumped = world.time
		if(!M.restrained() && !M.small)
			bumpopen(M)
		return

	if(istype(AM, /obj/machinery/bot))
		var/obj/machinery/bot/bot = AM
		if(src.check_access(bot.botcard))
			if(density)
				open()
		return

	if(istype(AM, /obj/mecha))
		var/obj/mecha/mecha = AM
		if(density)
			if(mecha.occupant && (src.allowed(mecha.occupant) || src.check_access_list(mecha.operation_req_access)))
				open()
			else
				flick("door_deny", src)
		return
	if(istype(AM, /obj/structure/stool/bed/chair/wheelchair))
		var/obj/structure/stool/bed/chair/wheelchair/wheel = AM
		if(density)
			if(wheel.pulling && (src.allowed(wheel.pulling)))
				open()
			else
				flick("door_deny", src)
		return
	return


/obj/machinery/door/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group) return 0
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return !opacity
	return !density


/obj/machinery/door/proc/bumpopen(mob/user as mob)
	if(operating)	return
	if(user.last_airflow > world.time - vsc.airflow_delay) //Fakkit
		return
	src.add_fingerprint(user)
	if(!src.requiresID())
		user = null

	if(density)
		if(allowed(user))	open()
		else				flick("door_deny", src)
	return

/obj/machinery/door/meteorhit(obj/M as obj)
	src.open()
	return


/obj/machinery/door/attack_ai(mob/user as mob)
	return src.attack_hand(user)


/obj/machinery/door/attack_paw(mob/user as mob)
	return src.attack_hand(user)


/obj/machinery/door/attack_hand(mob/user as mob)
	return src.attackby(user, user)

/obj/machinery/door/attack_tk(mob/user as mob)
	if(requiresID() && !allowed(null))
		return
	..()

/obj/machinery/door/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/device/detective_scanner))
		return
	if(src.operating || isrobot(user))	return //borgs can't attack doors open because it conflicts with their AI-like interaction with them.
	src.add_fingerprint(user)
	if(!Adjacent(user))
		user = null
	if(!src.requiresID())
		user = null
	if(src.density && (istype(I, /obj/item/weapon/card/emag)||istype(I, /obj/item/weapon/melee/energy/blade)))
		flick("door_spark", src)
		sleep(6)
		open()
		operating = -1
		return 1
	if(src.allowed(user))
		if(src.density)
			open()
		else
			close()
		return
//Alien door forcing section
//Goal: Normal aliens can force airlocks and firedoors when powered. When not powered and unlocked, they can open doors easily as if they were powered.
//Large Queens (empresses) can open regular doors faster and even bypass some of the measures, such as locked and welded doors.



	if(src.density && istype(user, /mob/living/carbon/alien/humanoid) && !aforce)
		if(istype(src, /obj/machinery/door/airlock)) //Airlock-specific conditions
			var /obj/machinery/door/airlock/AF = src
			if(operating)
				user << "\green You cannot force an airlock that is in motion!" //Well duh!
				return
			if(AF.welded && !(AF.locked)) //Behavior for welded airlocks. Duplicate for Firedoors. We don't care if they're powered or not - same behavior with or without power.
				if(istype(user, /mob/living/carbon/alien/humanoid/queen/large))
					aforce = 1
					user.visible_message("[user] jabs its big claws into the door weld and yanks!", "\green You jab your big claws into the door weld and yank!")
					if(do_after(user,20))
						if(prob(20))
							user.visible_message("[user] rips the door weld apart and forces the doors open!","\green You rip the door weld apart and force the doors open!")
							AF.welded = 0
							aforce = 0
							open(1)
							return
						else
							user.visible_message("[user] struggles against the welded door in vain!","\green You struggle against the door in vain!")
							aforce = 0
							return
					else
						aforce = 0
						return
				else
					user << "\green There is no way to force open a welded door!"
					return
			if(AF.locked) //Behavior for bolted airlocks - They can't be opened period. Gotta melt them suckers! We also don't need to bother checking for power here.
				aforce = 1
				user.visible_message("[user] digs its claws in and starts to force the door!","\green You dig your claws in and start to force the door!")
				if(do_after(user,20))
					user.visible_message("[user] struggles ineffectively against the door!","\green You struggle ineffectively against the door!")
					aforce = 0
					return
				else
					aforce = 0
					return
			if((!(AF.arePowerSystemsOn()) || (stat & NOPOWER)) && !(AF.welded) && !(AF.locked)) //Finally! Behavior for airlocks without power that are neither welded nor bolted! Duplicate for Firelocks.
				user.visible_message("[user] digs its claws in and easily opens the powerless door!","\green You dig your claws in and easily open the powerless door!")
				if(do_after(user,5))
					open(1)
					return
			if(AF.arePowerSystemsOn() && !(stat & NOPOWER)) //Normal Airlock operation forcing
				aforce = 1
				user.visible_message("[user] digs their claws in and starts to force the door!" ,"\green You dig your claws in and start to force the door!")
				if(istype(user, /mob/living/carbon/alien/humanoid/queen/large))
					if(do_after(user, 20))
						if(prob(35))
							user.visible_message("[user] mightily forces open the door!","\green You mightily force open the door!")
							open(1)
							aforce = 0
							return
						else
							user.visible_message("[user]'s mighty claws slip off of the door!","\green Your mighty claws slip out of the door!")
							aforce = 0
							return
					else
						aforce = 0
						return
				else
					if(do_after(user, 30))
						if(prob(25))
							user.visible_message("[user] slowly forces the door open!","\green You slowly force the door open!")
							open(1)
							aforce = 0
							return
						else
							user.visible_message("[user] struggles uselessly against the airlock motors!", "\green You struggle uselessly against the airlock motors!")
							aforce = 0
							return
					else
						aforce = 0
						return
//End Alien door forcing section


	if(src.density)
		flick("door_deny", src)
	return


/obj/machinery/door/blob_act()
	if(prob(40))
		del(src)
	return


/obj/machinery/door/emp_act(severity)
	if(prob(20/severity) && (istype(src,/obj/machinery/door/airlock) || istype(src,/obj/machinery/door/window)) )
		open()
	if(prob(40/severity))
		if(secondsElectrified == 0)
			secondsElectrified = -1
			spawn(300)
				secondsElectrified = 0
	..()


/obj/machinery/door/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
		if(2.0)
			if(prob(25))
				del(src)
		if(3.0)
			if(prob(80))
				var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
				s.set_up(2, 1, src)
				s.start()
	return


/obj/machinery/door/update_icon()
	if(density)
		icon_state = "door1"
	else
		icon_state = "door0"
	return


/obj/machinery/door/proc/do_animate(animation)
	switch(animation)
		if("opening")
			if(p_open)
				flick("o_doorc0", src)
			else
				flick("doorc0", src)
		if("closing")
			if(p_open)
				flick("o_doorc1", src)
			else
				flick("doorc1", src)
		if("deny")
			flick("door_deny", src)
	return


/obj/machinery/door/proc/open()
	if(!density)		return 1
	if(operating > 0)	return
	if(!ticker)			return 0
	if(!operating)		operating = 1

	do_animate("opening")
	icon_state = "door0"
	src.SetOpacity(0)
	sleep(10)
	src.layer = 2.7
	src.density = 0
	explosion_resistance = 0
	update_icon()
	SetOpacity(0)
	update_nearby_tiles()

	if(operating)	operating = 0

	if(autoclose  && normalspeed)
		spawn(150)
			autoclose()
	if(autoclose && !normalspeed)
		spawn(5)
			autoclose()

	return 1


/obj/machinery/door/proc/close()
	if(density)	return 1
	if(operating > 0)	return
	operating = 1

	do_animate("closing")
	src.density = 1
	explosion_resistance = initial(explosion_resistance)
	src.layer = 3.1
	sleep(10)
	update_icon()
	if(visible && !glass)
		SetOpacity(1)	//caaaaarn!
	operating = 0
	update_nearby_tiles()

	//I shall not add a check every x ticks if a door has closed over some fire.
	var/obj/fire/fire = locate() in loc
	if(fire)
		del fire
	return

/obj/machinery/door/proc/requiresID()
	return 1

/obj/machinery/door/proc/update_nearby_tiles(need_rebuild)
	if(!air_master)
		return 0

	for(var/turf/simulated/turf in locs)
		update_heat_protection(turf)
		air_master.mark_for_update(turf)

	return 1

/obj/machinery/door/proc/update_heat_protection(var/turf/simulated/source)
	if(istype(source))
		if(src.density && (src.opacity || src.heat_proof))
			source.thermal_conductivity = DOOR_HEAT_TRANSFER_COEFFICIENT
		else
			source.thermal_conductivity = initial(source.thermal_conductivity)

/obj/machinery/door/proc/autoclose()
	var/obj/machinery/door/airlock/A = src
	if(!A.density && !A.operating && !A.locked && !A.welded && A.autoclose)
		close()
	return

/obj/machinery/door/Move(new_loc, new_dir)
	update_nearby_tiles()
	. = ..()
	if(width > 1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size

	update_nearby_tiles()

/obj/machinery/door/morgue
	icon = 'icons/obj/doors/doormorgue.dmi'