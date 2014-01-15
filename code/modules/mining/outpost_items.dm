//copied code from Mining Shuttle, modified for a short transit in hyperspace.

var/outpost_shuttle_tickstomove = 10
var/outpost_shuttle_moving = 0
var/outpost_shuttle_location = 1 // 0 = station 13, 1 = outpost

proc/move_outpost_shuttle()
	var/obj/item/device/radio/intercom/R = new /obj/item/device/radio/intercom(null)
	outpost_shuttle_moving = 1
	var/area/fromArea
	if(outpost_shuttle_location == 1)
		R.autosay("\improper The Vox outpost shuttle is preparing for transit to the station.","Outpost Shuttle Computer")
		fromArea = locate(/area/shuttle/outpost/outpost)
		spawn(outpost_shuttle_tickstomove*27)
			for(var/obj/machinery/door/unpowered/shuttle/D in fromArea) //lock dem do's!
				D.close()
				D.locked = 1
			for(var/obj/machinery/door/airlock/external/D in locate(/area/outpost/docking)) //station-side also. We don't like accidents.
				D.close()
				spawn(10)
					D.locked = 1
					D.update_icon()
			spawn(outpost_shuttle_tickstomove*3) //then launch
				shuttlemove()
	else if(outpost_shuttle_location == 2)
		R.autosay("\improper The Vox outpost shuttle has entered hyperspace and shall arrive at the station in 30 seconds.","Outpost Shuttle Computer")
		spawn(outpost_shuttle_tickstomove*30) //fly through hyperspace for 90 seconds
			shuttlemove()
	else if(outpost_shuttle_location == 0)
		fromArea = locate(/area/shuttle/outpost/station)
		R.autosay("\improper The Vox outpost shuttle is preparing to depart the station.","Outpost Shuttle Computer")
		spawn(outpost_shuttle_tickstomove*27)
//			toArea = locate(/area/shuttle/outpost/transit)
			for(var/obj/machinery/door/unpowered/shuttle/D in fromArea) //lock dem do's!
				D.close()
				D.locked = 1
			for(var/obj/machinery/door/airlock/external/D in locate(/area/hallway/secondary/entry/filter/doors)) //station-side also. We don't like accidents.
				D.close()
				spawn(10)
					D.locked = 1
					D.update_icon()
			spawn(outpost_shuttle_tickstomove*3) //then launch
				shuttlemove()
	else
		R.autosay("\improper The Vox outpost shuttle has entered hyperspace and shall arrive at the outpost in 30 seconds.","Outpost Shuttle Computer")
		spawn(outpost_shuttle_tickstomove*30)
			shuttlemove()

proc/shuttlemove()
	var/obj/item/device/radio/intercom/R = new /obj/item/device/radio/intercom(null)
	var/list/dstturfs = list()
	var/throwy = world.maxy
	var/area/fromArea
	var/area/toArea
	if(outpost_shuttle_location == 1)
		fromArea = locate(/area/shuttle/outpost/outpost)
		toArea = locate(/area/shuttle/outpost/transit)
	else if(outpost_shuttle_location == 2)
		fromArea = locate(/area/shuttle/outpost/transit)
		toArea = locate(/area/shuttle/outpost/station)
	else if(outpost_shuttle_location == 0)
		fromArea = locate(/area/shuttle/outpost/station)
		toArea = locate(/area/shuttle/outpost/transit)
	else
		fromArea = locate(/area/shuttle/outpost/transit)
		toArea = locate(/area/shuttle/outpost/outpost)

	for(var/turf/T in toArea)
		dstturfs += T
		if(T.y < throwy)
			throwy = T.y

		// hey you, get out of the way!
	for(var/turf/T in dstturfs)
			// find the turf to move things to
		var/turf/D = locate(T.x, throwy - 1, 1)
			//var/turf/E = get_step(D, SOUTH)
		for(var/atom/movable/AM as mob|obj in T)
			AM.Move(D)
				// NOTE: Commenting this out to avoid recreating mass driver glitch
				/*
				spawn(0)
					AM.throw_at(E, 1, 1)
					return
				*/

		if(istype(T, /turf/simulated))
			del(T)

	for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
		bug.gib()

	for(var/mob/living/simple_animal/pest in toArea) // And for the other kind of bug...
		pest.gib()

	fromArea.move_contents_to(toArea)

	for(var/mob/M in toArea)
		if(M.client)
			spawn(0)
				if(M.buckled)
					shake_camera(M, 3, 1) // buckled, not a lot of shaking
				else
					shake_camera(M, 10, 1) // unbuckled, HOLY SHIT SHAKE THE ROOM
		if(istype(M, /mob/living/carbon))
			if(!M.buckled)
				M.Weaken(3)
//	if(outpost_shuttle_location == 1 || outpost_shuttle_location == 0)
//		outpost_shuttle_moving = 0
	if(outpost_shuttle_location == 1)
		outpost_shuttle_location = 2
		move_outpost_shuttle()
	else if(outpost_shuttle_location == 2)
		R.autosay("\improper The Vox outpost shuttle has arrived at the station. All passengers please equip internals and disembark.","Outpost Shuttle Computer")
		spawn(outpost_shuttle_tickstomove*1.5)
			for(var/obj/machinery/door/unpowered/shuttle/D in toArea) //open dem do's!
				D.locked = 0
				D.open()
			for(var/obj/machinery/door/airlock/external/D in locate(/area/hallway/secondary/entry/filter/doors)) //open dem do's!
				D.locked = 0
				D.open()
		outpost_shuttle_location = 0
		outpost_shuttle_moving = 0
	else if (outpost_shuttle_location == 0)
		outpost_shuttle_location = 3
		move_outpost_shuttle()
	else
		R.autosay("\improper The Vox outpost shuttle has arrived at the outpost. All passengers please disembark.","Outpost Shuttle Computer")
		spawn(outpost_shuttle_tickstomove*1.5)
			for(var/obj/machinery/door/unpowered/shuttle/D in toArea) //open dem do's!
				D.locked = 0
				D.open()
			for(var/obj/machinery/door/airlock/external/D in locate(/area/outpost/docking)) //open dem do's!
				D.locked = 0
				D.open()
		outpost_shuttle_location = 1
		outpost_shuttle_moving = 0

/obj/machinery/computer/outpost_shuttle
	name = "outpost shuttle console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	req_access = list()
	circuit = "/obj/item/weapon/circuitboard/outpost_shuttle"
	var/hacked = 0
	var/location = 0 //0 = station, 1 = mining base

/obj/machinery/computer/outpost_shuttle/attack_hand(user as mob)
	if(..(user))
		return
	src.add_fingerprint(usr)
	var/dat

	dat = "<center>Vox Outpost Shuttle Control<hr>"

	if(outpost_shuttle_moving)
		dat += "Location: <font color='red'>Moving</font> <br>"
	else
		dat += "Location: [outpost_shuttle_location ? "Outpost" : "Station"] <br>"

	dat += "<b><A href='?src=\ref[src];move=[1]'>Send</A></b></center>"


	user << browse("[dat]", "window=miningshuttle;size=200x150")

/obj/machinery/computer/outpost_shuttle/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(href_list["move"])
		//if(ticker.mode.name == "blob")
		//	if(ticker.mode:declared)
		//		usr << "Under directive 7-10, [station_name()] is quarantined until further notice."
		//		return

		if (!outpost_shuttle_moving)
			usr << "\blue Shuttle recieved message and will be sent shortly."
			move_outpost_shuttle()
		else
			usr << "\blue Shuttle is already moving."

	updateUsrDialog()

/obj/machinery/computer/outpost_shuttle/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/card/emag))
		src.req_access = list()
		hacked = 1
		usr << "You fried the consoles ID checking system. It's now available to everyone!"

	else if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
			var/obj/item/weapon/circuitboard/outpost_shuttle/M = new /obj/item/weapon/circuitboard/outpost_shuttle( A )
			for (var/obj/C in src)
				C.loc = src.loc
			A.circuit = M
			A.anchored = 1

			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				new /obj/item/weapon/shard( src.loc )
				A.state = 3
				A.icon_state = "3"
			else
				user << "\blue You disconnect the monitor."
				A.state = 4
				A.icon_state = "4"

			del(src)