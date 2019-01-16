var/const/NETWORK_COMMAND = "Command"
var/const/NETWORK_CENTRAL = "Nanotrasen Regional Hub"
var/const/NETWORK_ATMOS = "Atmospherics"
var/const/NETWORK_SUPPLY = "Cargo & Supply"
var/const/NETWORK_SHUTTLE = "Shuttle Cameras"
var/const/NETWORK_VOX_OUTPOST = "Vox Outpost"
var/const/NETWORK_RESEARCH_OUTPOST = "Research Outpost"
var/const/NETWORK_CIVILIAN_WEST = "West Commons"
var/const/NETWORK_PRISON = "Prison"
var/const/NETWORK_CIVILIAN_EAST = "East Commons"
var/const/NETWORK_CIVILIAN = "Commons"
var/const/NETWORK_ENGINE = "Engine Room"
var/const/NETWORK_TELECOMM = "Telcomm Satellite"
var/const/NETWORK_ENGINEERING_OUTPOST = "Engineering Outpost"

/obj/machinery/camera/network/vox
	network = list(NETWORK_VOX_OUTPOST)

/obj/machinery/camera/network/engine
	network = list(NETWORK_ENGINE)

/obj/machinery/camera/network/telecomm
	network = list(NETWORK_TELECOMM)

/obj/machinery/camera/network/civilian
	network = list(NETWORK_CIVILIAN)

/obj/machinery/camera/network/command
	network = list(NETWORK_COMMAND)

/obj/machinery/camera/all/command
	network = list(NETWORK_COMMAND)

/obj/machinery/camera/all/security
	network = list(NETWORK_SECURITY)

/obj/machinery/camera/xray/security
	network = list(NETWORK_SECURITY)

/obj/machinery/camera/network/civilian_east
	network = list(NETWORK_CIVILIAN_EAST)

/obj/machinery/camera/network/civilian_west
	network = list(NETWORK_CIVILIAN_WEST)

/obj/machinery/camera/network/supply
	network = list(NETWORK_SUPPLY)

/obj/machinery/camera/network/researchop
	network = list(NETWORK_RESEARCH_OUTPOST)

/obj/machinery/camera/network/atmos
	network = list(NETWORK_ENGINEERING,NETWORK_ATMOS)

/obj/machinery/camera/network/shuttle
	network = list(NETWORK_SHUTTLE)

/obj/machinery/camera/network/prison
	network = list(NETWORK_PRISON)

/obj/machinery/camera/network/crescent
	network = list(NETWORK_CRESCENT)

/obj/machinery/camera/network/engineering_outpost
	network = list(NETWORK_ENGINEERING_OUTPOST)

/obj/machinery/camera/motion/engineering_outpost
	network = list(NETWORK_ENGINEERING_OUTPOST)

/obj/machinery/camera/network/research_outpost
	network = list(NETWORK_RESEARCH_OUTPOST)

/datum/map/exodus
	station_networks = list(
		NETWORK_ATMOS,
		NETWORK_CIVILIAN_WEST,
		NETWORK_CIVILIAN_EAST,
		NETWORK_CIVILIAN,
		NETWORK_COMMAND,
		NETWORK_ENGINE,
		NETWORK_ENGINEERING,
		NETWORK_ENGINEERING_OUTPOST,
		NETWORK_MEDICAL,
		NETWORK_MINE,
		NETWORK_RESEARCH,
		NETWORK_RESEARCH_OUTPOST,
		NETWORK_ROBOTS,
		NETWORK_SECURITY,
		NETWORK_SHUTTLE,
		NETWORK_PRISON,
		NETWORK_VOX_OUTPOST,
		NETWORK_TELECOMM,
	)

	holodeck_programs = list(
		"emptycourt"       = new/datum/holodeck_program(/area/holodeck/source_emptycourt, list('sound/music/THUNDERDOME.ogg')),
		"boxingcourt"      = new/datum/holodeck_program(/area/holodeck/source_boxingcourt, list('sound/music/THUNDERDOME.ogg')),
		"basketball"       = new/datum/holodeck_program(/area/holodeck/source_basketball, list('sound/music/THUNDERDOME.ogg')),
		"thunderdomecourt" = new/datum/holodeck_program(/area/holodeck/source_thunderdomecourt, list('sound/music/THUNDERDOME.ogg')),
		"beach"            = new/datum/holodeck_program(/area/holodeck/source_beach, list('sound/music/europa/WildEncounters.ogg')),
		"desert"           = new/datum/holodeck_program(/area/holodeck/source_desert,
														list(
															'sound/effects/wind/wind_2_1.ogg',
											 				'sound/effects/wind/wind_2_2.ogg',
											 				'sound/effects/wind/wind_3_1.ogg',
											 				'sound/effects/wind/wind_4_1.ogg',
											 				'sound/effects/wind/wind_4_2.ogg',
											 				'sound/effects/wind/wind_5_1.ogg'
												 			)
		 												),
		"snowfield"        = new/datum/holodeck_program(/area/holodeck/source_snowfield,
														list(
															'sound/effects/wind/wind_2_1.ogg',
											 				'sound/effects/wind/wind_2_2.ogg',
											 				'sound/effects/wind/wind_3_1.ogg',
											 				'sound/effects/wind/wind_4_1.ogg',
											 				'sound/effects/wind/wind_4_2.ogg',
											 				'sound/effects/wind/wind_5_1.ogg'
												 			)
		 												),
		"space"            = new/datum/holodeck_program(/area/holodeck/source_space,
														list(
															'sound/ambience/ambispace.ogg',
															'sound/music/main.ogg',
															'sound/music/space.ogg',
															'sound/music/traitor.ogg',
															)
														),
		"picnicarea"       = new/datum/holodeck_program(/area/holodeck/source_picnicarea, list('sound/music/title2.ogg')),
		"theatre"          = new/datum/holodeck_program(/area/holodeck/source_theatre),
		"meetinghall"      = new/datum/holodeck_program(/area/holodeck/source_meetinghall),
		"courtroom"        = new/datum/holodeck_program(/area/holodeck/source_courtroom, list('sound/music/traitor.ogg')),
		"wildlifecarp"     = new/datum/holodeck_program(/area/holodeck/source_wildlife, list()),
		"turnoff"          = new/datum/holodeck_program(/area/holodeck/source_plating, list())
	)

	holodeck_supported_programs = list(

		"Basketball Court"  = "basketball",
		"Beach"             = "beach",
		"Boxing Ring"       = "boxingcourt",
		"Courtroom"         = "courtroom",
		"Desert"            = "desert",
		"Empty Court"       = "emptycourt",
		"Meeting Hall"      = "meetinghall",
		"Picnic Area"       = "picnicarea",
		"Snow Field"        = "snowfield",
		"Space"             = "space",
		"Theatre"           = "theatre",
		"Thunderdome Court" = "thunderdomecourt",

	)

	holodeck_restricted_programs = list(

		"Wildlife Simulation" = "wildlifecarp"

	)

/datum/map/exodus/default_internal_channels()
	return list(
		num2text(PUB_FREQ)   = list(),
		num2text(AI_FREQ)    = list(access_synth),
		num2text(ENT_FREQ)   = list(),
		num2text(ERT_FREQ)   = list(access_cent_specops),
		num2text(COMM_FREQ)  = list(access_heads),
		num2text(ENG_FREQ)   = list(access_engine_equip, access_atmospherics),
		num2text(MED_FREQ)   = list(access_medical_equip),
		num2text(MED_I_FREQ) = list(access_medical_equip),
		num2text(SEC_FREQ)   = list(access_security),
		num2text(SEC_I_FREQ) = list(access_security),
		num2text(SCI_FREQ)   = list(access_tox,access_robotics,access_xenobiology),
		num2text(SUP_FREQ)   = list(access_cargo),
		num2text(SRV_FREQ)   = list(access_janitor, access_hydroponics)
	)


/obj/item/modular_computer/tablet/preset/security/install_default_hardware()
	..()
	processor_unit = new/obj/item/weapon/computer_hardware/processor_unit/small(src)
	tesla_link = new/obj/item/weapon/computer_hardware/tesla_link(src)
	hard_drive = new/obj/item/weapon/computer_hardware/hard_drive/small(src)
	network_card = new/obj/item/weapon/computer_hardware/network_card(src)
	battery_module = new/obj/item/weapon/computer_hardware/battery_module/micro(src)
	battery_module.charge_to_full()

/obj/item/modular_computer/tablet/preset/security/install_default_programs()
	..()
	hard_drive.store_file(new/datum/computer_file/program/camera_monitor())
	hard_drive.store_file(new/datum/computer_file/program/digitalwarrant())
	hard_drive.store_file(new/datum/computer_file/program/forceauthorization())
	hard_drive.store_file(new/datum/computer_file/program/records())
	hard_drive.store_file(new/datum/computer_file/program/wordprocessor())

/obj/item/modular_computer/tablet/preset/medical/install_default_hardware()
	..()
	processor_unit = new/obj/item/weapon/computer_hardware/processor_unit/small(src)
	tesla_link = new/obj/item/weapon/computer_hardware/tesla_link(src)
	hard_drive = new/obj/item/weapon/computer_hardware/hard_drive/small(src)
	network_card = new/obj/item/weapon/computer_hardware/network_card(src)
	battery_module = new/obj/item/weapon/computer_hardware/battery_module/micro(src)
	battery_module.charge_to_full()

/obj/item/modular_computer/tablet/preset/medical/install_default_programs()
	..()
	hard_drive.store_file(new/datum/computer_file/program/suit_sensors())
	hard_drive.store_file(new/datum/computer_file/program/camera_monitor())
	hard_drive.store_file(new/datum/computer_file/program/records())
	hard_drive.store_file(new/datum/computer_file/program/wordprocessor())
	set_autorun("sensormonitor")


/obj/item/modular_computer/laptop/preset/detective/install_default_hardware()
	..()
	processor_unit = new/obj/item/weapon/computer_hardware/processor_unit(src)
	tesla_link = new/obj/item/weapon/computer_hardware/tesla_link(src)
	hard_drive = new/obj/item/weapon/computer_hardware/hard_drive/advanced(src)
	network_card = new/obj/item/weapon/computer_hardware/network_card/advanced(src)
	nano_printer = new/obj/item/weapon/computer_hardware/nano_printer(src)
	card_slot = new/obj/item/weapon/computer_hardware/card_slot(src)
	battery_module = new/obj/item/weapon/computer_hardware/battery_module/advanced(src)
	battery_module.charge_to_full()

/obj/item/modular_computer/laptop/preset/detective/install_default_programs()
	..()
	hard_drive.store_file(new/datum/computer_file/program/camera_monitor())
	hard_drive.store_file(new/datum/computer_file/program/digitalwarrant())
	hard_drive.store_file(new/datum/computer_file/program/forceauthorization())
	hard_drive.store_file(new/datum/computer_file/program/records())
	hard_drive.store_file(new/datum/computer_file/program/wordprocessor())

/obj/item/modular_computer/laptop/preset/medical/install_default_hardware()
	..()
	processor_unit = new/obj/item/weapon/computer_hardware/processor_unit(src)
	tesla_link = new/obj/item/weapon/computer_hardware/tesla_link(src)
	hard_drive = new/obj/item/weapon/computer_hardware/hard_drive/advanced(src)
	network_card = new/obj/item/weapon/computer_hardware/network_card/advanced(src)
	nano_printer = new/obj/item/weapon/computer_hardware/nano_printer(src)
	card_slot = new/obj/item/weapon/computer_hardware/card_slot(src)
	battery_module = new/obj/item/weapon/computer_hardware/battery_module/advanced(src)
	battery_module.charge_to_full()

/obj/item/modular_computer/laptop/preset/medical/install_default_programs()
	..()
	hard_drive.store_file(new/datum/computer_file/program/suit_sensors())
	hard_drive.store_file(new/datum/computer_file/program/camera_monitor())
	hard_drive.store_file(new/datum/computer_file/program/records())
	hard_drive.store_file(new/datum/computer_file/program/wordprocessor())
	set_autorun("sensormonitor")

/turf/simulated/floor/plating/airless
	initial_gas = null

/obj/machinery/atmospherics/pipe/manifold/visible/purple
	color = PIPE_COLOR_BLACK

/obj/machinery/atmospherics/pipe/simple/visible/purple
	color = PIPE_COLOR_BLACK

/obj/machinery/portable_atmospherics/canister/nitrogen/airlock
	start_pressure = 2 * ONE_ATMOSPHERE

/obj/structure/window/basic/clear
	alpha = 80
	name = "clear window"
	desc = "It's considerably clearer than most windows."

/obj/structure/window/basic/full/clear
	alpha = 80
	name = "clear window"
	desc = "It's considerably clearer than most windows."

/obj/structure/window/reinforced/clear
	alpha = 80
	name = "clear window"
	desc = "It's considerably clearer than most windows."

/obj/structure/window/reinforced/full/clear
	alpha = 80
	name = "clear window"
	desc = "It's considerably clearer than most windows."

/obj/machinery/button
	layer = ABOVE_WINDOW_LAYER

/obj/machinery/airlock_sensor
	layer = ABOVE_WINDOW_LAYER

/obj/machinery/access_button
	layer = ABOVE_WINDOW_LAYER

/obj/machinery/embedded_controller
	layer = ABOVE_WINDOW_LAYER