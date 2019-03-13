/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_plasma_cutter
	icon = 'maps/exodus/icons/exodus_items.dmi'
	equip_cooldown = 10
	origin_tech = list(TECH_MATERIAL = 5, TECH_PHORON = 5, TECH_ENGINEERING = 7, TECH_COMBAT = 4)
	matter = list(MATERIAL_STEEL = 6000, MATERIAL_PHORON = 2000, MATERIAL_SILVER = 1000, MATERIAL_GOLD = 1000)
	name = "exosuit plasma cutter"
	desc = "The EPC-4421 is a heavy-duty industrial-grade exosuit-mounted plasma cutter. It isn't the most efficient, but it'll strip mine an asteroid in no time with enough power. Should only be used by experienced and trusted exosuit pilots."
	icon_state = "mecha_plasmacutter"
	energy_drain = 25 KILOWATTS // HONGRY
	projectile = /obj/item/projectile/beam/plasmacutter/exo
	fire_sound = 'sound/weapons/plasma_cutter.ogg'
	required_type = list(/obj/mecha/combat, /obj/mecha/working)

/obj/item/projectile/beam/plasmacutter/exo //More damage and range than the handheld model
	name = "heavy plasma arc"
	damage = 30
	kill_count = 7

/obj/item/projectile/beam/plasmacutter/exo/on_impact(var/atom/A) //More effective at mining, but higher rate of burning out mineral turfs
	if(istype(A, /turf/simulated/mineral))
		var/turf/simulated/mineral/M = A
		if(prob(75))
			M.GetDrilled(1)
			return
		else
			M.emitter_blasts_taken += 4
	. = ..()

/datum/design/item/mecha/plasmacutter
	name = "Plasma Cutter"
	desc = "Exosuit-mounted Plasma cutter for all your strip-mining needs."
	id = "mecha_plasmacutter"
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_plasma_cutter
	materials = list(MATERIAL_STEEL = 6000, MATERIAL_PHORON = 2000, MATERIAL_SILVER = 1000, MATERIAL_GOLD = 1000)
	req_tech = list(TECH_MATERIAL = 5, TECH_PHORON = 5, TECH_ENGINEERING = 7, TECH_COMBAT = 4)
	time = 40