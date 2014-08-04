/var/const/OPEN = 1
/var/const/CLOSED = 2
/obj/machinery/door/firedoor
	name = "\improper Emergency Shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas."
	icon = 'icons/obj/doors/DoorHazard.dmi'
	icon_state = "door_open"
	req_one_access = list(access_atmospherics, access_engine_equip)
	opacity = 0
	density = 0

	var/blocked = 0
	var/nextstate = null
	var/net_id
	var/list/areas_added
	var/list/users_to_open

/obj/machinery/door/firedoor/New()
	. = ..()
	for(var/obj/machinery/door/firedoor/F in loc)
		if(F != src)
			spawn(1)
				del src
			return .
	var/area/A = get_area(src)
	ASSERT(istype(A))

	A.all_doors.Add(src)
	areas_added = list(A)

	for(var/direction in cardinal)
		A = get_area(get_step(src,direction))
		if(istype(A) && !(A in areas_added))
			A.all_doors.Add(src)
			areas_added += A


/obj/machinery/door/firedoor/Del()
	for(var/area/A in areas_added)
		A.all_doors.Remove(src)
	. = ..()


/obj/machinery/door/firedoor/examine()
	set src in view()
	. = ..()
	if( islist(users_to_open) && users_to_open.len)
		var/users_to_open_string = users_to_open[1]
		if(users_to_open.len >= 2)
			for(var/i = 2 to users_to_open.len)
				users_to_open_string += ", [users_to_open[i]]"
		usr << "These people have opened \the [src] during an alert: [users_to_open_string]."


/obj/machinery/door/firedoor/Bumped(atom/AM)
	if(p_open || operating)
		return
	if(!density)
		return ..()
	if(istype(AM, /obj/mecha))
		var/obj/mecha/mecha = AM
		if (mecha.occupant)
			var/mob/M = mecha.occupant
			if(world.time - M.last_bumped <= 10) return //Can bump-open one airlock per second. This is to prevent popup message spam.
			M.last_bumped = world.time
			attack_hand(M)
	return 0


/obj/machinery/door/firedoor/power_change()
	if(powered(ENVIRON))
		stat &= ~NOPOWER
	else
		stat |= NOPOWER
	return


/obj/machinery/door/firedoor/attack_hand(mob/user as mob)
	add_fingerprint(user)
	var/aforce = 0
	if(operating)
		return//Already doing something.

	if(blocked)
		user << "<span class='warning'>\The [src] is welded solid!</span>"
		return

	if(density && istype(user, /mob/living/carbon/alien/humanoid) && !aforce) //Firelock mechanics. Mostly duplicated, but necessarily, due to different variables in Firedoors vs Airlocks
		if(blocked) //Behavior for welded airlocks. Duplicate for Firedoors. We don't care if they're powered or not - same behavior with or without power.
			if(istype(user, /mob/living/carbon/alien/humanoid/queen/large))
				aforce = 1
				user.visible_message("[user] jabs its big claws into the door weld and yanks!", "\green You jab your big claws into the door weld and yank!")
				if(do_after(user,20))
					if(prob(20))
						user.visible_message("[user] rips the door weld apart and forces the doors open!","\green You rip the door weld apart and force the doors open!")
						blocked = 0
						aforce = 0
						open()
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
		if((stat & NOPOWER) && !(blocked)) //Finally! Behavior for airlocks without power that are neither welded nor bolted! Duplicate for Firelocks.
			sleep(5)
			user.visible_message("[user] digs its claws in and easily opens the powerless door!","\green You dig your claws in and easily open the powerless door!")
			open()
			return
		if(!(stat & NOPOWER)) //Standard operation of airlocks. Easier to force firedoors than to open airlocks.
			aforce = 1
			user.visible_message("[user] digs their claws in and starts to force the door!" ,"\green You dig your claws in and start to force the door!")
			if(istype(user, /mob/living/carbon/alien/humanoid/queen/large))
				if(do_after(user, 20))
					if(prob(30))
						user.visible_message("[user] mightily forces open the door!","\green You mightily force open the door!")
						open()
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
					if(prob(20))
						user.visible_message("[user] slowly forces the door open!","\green You slowly force the door open!")
						open()
						aforce = 0
						return
					else
						user.visible_message("[user] struggles uselessly against the airlock motors!", "\green You struggle uselessly against the airlock motors!")
						aforce = 0
						return
				else
					aforce = 0
					return

	if(!allowed(user))
		user << "<span class='warning'>Access denied.</span>"
		return

	var/alarmed = 0

	for(var/area/A in areas_added)		//Checks if there are fire alarms in any areas associated with that firedoor
		if(A.fire || A.air_doors_activated)
			alarmed = 1

	var/answer = alert(user, "Would you like to [density ? "open" : "close"] this [src.name]?[ alarmed && density ? "\nNote that by doing so, you acknowledge any damages from opening this\n[src.name] as being your own fault, and you will be held accountable under the law." : ""]",\
	"\The [src]", "Yes, [density ? "open" : "close"]", "No")
	if(answer == "No")
		return
	if(user.stat || user.stunned || user.weakened || user.paralysis || (!user.canmove && !isAI(user)) || (get_dist(src, user) > 1  && !isAI(user)))
		user << "Sorry, you must remain able bodied and close to \the [src] in order to use it."
		return

	var/needs_to_close = 0
	if(density)
		if(alarmed)
			needs_to_close = 1
		spawn()
			open()
	else
		spawn()
			close()

	if(needs_to_close)
		spawn(50)
			alarmed = 0
			for(var/area/A in areas_added)		//Just in case a fire alarm is turned off while the firedoor is going through an autoclose cycle
				if(A.fire || A.air_doors_activated)
					alarmed = 1
			if(alarmed)
				nextstate = CLOSED
				close()

/obj/machinery/door/firedoor/attackby(obj/item/weapon/C as obj, mob/user as mob)
	add_fingerprint(user)
	if(operating)
		return//Already doing something.
	if(istype(C, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/W = C
		if(W.remove_fuel(0, user))
			blocked = !blocked
			user.visible_message("\red \The [user] [blocked ? "welds" : "unwelds"] \the [src] with \a [W].",\
			"You [blocked ? "weld" : "unweld"] \the [src] with \the [W].",\
			"You hear something being welded.")
			update_icon()
			return

	if(blocked)
		user << "\red \The [src] is welded solid!"
		return


	if( istype(C, /obj/item/weapon/crowbar) || ( istype(C,/obj/item/weapon/twohanded/fireaxe) && C:wielded == 1 ) )
		if(operating)
			return

		if( blocked && istype(C, /obj/item/weapon/crowbar) )
			user.visible_message("\red \The [user] pries at \the [src] with \a [C], but \the [src] is welded in place!",\
			"You try to pry \the [src] [density ? "open" : "closed"], but it is welded in place!",\
			"You hear someone struggle and metal straining.")
			return

		user.visible_message("\red \The [user] starts to force \the [src] [density ? "open" : "closed"] with \a [C]!",\
				"You start forcing \the [src] [density ? "open" : "closed"] with \the [C]!",\
				"You hear metal strain.")
		if(do_after(user,30))
			if( istype(C, /obj/item/weapon/crowbar) )
				if( stat & (BROKEN|NOPOWER) || !density)
					user.visible_message("\red \The [user] forces \the [src] [density ? "open" : "closed"] with \a [C]!",\
					"You force \the [src] [density ? "open" : "closed"] with \the [C]!",\
					"You hear metal strain, and a door [density ? "open" : "close"].")
			else
				user.visible_message("\red \The [user] forces \the [ blocked ? "welded" : "" ] [src] [density ? "open" : "closed"] with \a [C]!",\
					"You force \the [ blocked ? "welded" : "" ] [src] [density ? "open" : "closed"] with \the [C]!",\
					"You hear metal strain and groan, and a door [density ? "open" : "close"].")
			if(density)
				spawn(0)
					open()
			else
				spawn(0)
					close()
			return



/obj/machinery/door/firedoor/proc/latetoggle()
	if(operating || stat & NOPOWER || !nextstate)
		return
	switch(nextstate)
		if(OPEN)
			nextstate = null
			open()
		if(CLOSED)
			nextstate = null
			close()
	return

/obj/machinery/door/firedoor/close()
	latetoggle()
	return ..()

/obj/machinery/door/firedoor/open()
	latetoggle()
	return ..()


/obj/machinery/door/firedoor/do_animate(animation)
	switch(animation)
		if("opening")
			flick("door_opening", src)
		if("closing")
			flick("door_closing", src)
	return


/obj/machinery/door/firedoor/update_icon()
	overlays.Cut()
	if(density)
		icon_state = "door_closed"
		if(blocked)
			overlays += "welded"
	else
		icon_state = "door_open"
		if(blocked)
			overlays += "welded_open"
	return



/obj/machinery/door/firedoor/border_only
//These are playing merry hell on ZAS.  Sorry fellas :(
/*
	icon = 'icons/obj/doors/edge_Doorfire.dmi'
	glass = 1 //There is a glass window so you can see through the door
			  //This is needed due to BYOND limitations in controlling visibility
	heat_proof = 1
	air_properties_vary_with_direction = 1

	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if(istype(mover) && mover.checkpass(PASSGLASS))
			return 1
		if(get_dir(loc, target) == dir) //Make sure looking at appropriate border
			if(air_group) return 0
			return !density
		else
			return 1

	CheckExit(atom/movable/mover as mob|obj, turf/target as turf)
		if(istype(mover) && mover.checkpass(PASSGLASS))
			return 1
		if(get_dir(loc, target) == dir)
			return !density
		else
			return 1


	update_nearby_tiles(need_rebuild)
		if(!air_master) return 0

		var/turf/simulated/source = loc
		var/turf/simulated/destination = get_step(source,dir)

		update_heat_protection(loc)

		if(istype(source)) air_master.tiles_to_update += source
		if(istype(destination)) air_master.tiles_to_update += destination
		return 1
*/

/obj/machinery/door/firedoor/multi_tile
	icon = 'icons/obj/doors/DoorHazard2x1.dmi'
	width = 2
