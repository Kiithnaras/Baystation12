// Escape shuttle and pods
/datum/shuttle/autodock/ferry/escape_pod/exodus
	category = /datum/shuttle/autodock/ferry/escape_pod/exodus
	sound_takeoff = 'sound/effects/rocket.ogg'
	sound_landing = 'sound/effects/rocket_backwards.ogg'
	var/number

/datum/shuttle/autodock/ferry/escape_pod/exodus/New()
	name = "Escape Pod [number]"
	dock_target = "escape_pod_[number]"
	arming_controller = "escape_pod_[number]_berth"
	waypoint_station = "escape_pod_[number]_start"
	landmark_transition = "escape_pod_[number]_interim"
	waypoint_offsite = "escape_pod_[number]_out"
	current_location = "escape_pod_[number]_start"
	..()

/obj/effect/shuttle_landmark/escape_pod/
	var/number

/obj/effect/shuttle_landmark/escape_pod/start
	name = "Docked"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/escape_pod/start/New()
	landmark_tag = "escape_pod_[number]_start"
	docking_controller = "escape_pod_[number]_berth"
	..()

/obj/effect/shuttle_landmark/escape_pod/transit
	name = "In transit"
	base_area = /area/space
	base_turf = /turf/space/bluespace

/obj/effect/shuttle_landmark/escape_pod/transit/New()
	landmark_tag = "escape_pod_[number]_interim"
	..()

/obj/effect/shuttle_landmark/escape_pod/out
	name = "Escaped"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/escape_pod/out/New()
	landmark_tag = "escape_pod_[number]_out"
	docking_controller = "escape_pod_[number]_recovery"
	..()



/datum/shuttle/autodock/ferry/escape_pod/exodus/escape_pod1
	warmup_time = 10
	number = 1
	shuttle_area = /area/shuttle/escape_pod1/station
/obj/effect/shuttle_landmark/escape_pod/start/pod1
	number = 1
/obj/effect/shuttle_landmark/escape_pod/out/pod1
	number = 1
/obj/effect/shuttle_landmark/escape_pod/transit/pod1
	number = 1

/datum/shuttle/autodock/ferry/escape_pod/exodus/escape_pod2
	warmup_time = 10
	number = 2
	shuttle_area = /area/shuttle/escape_pod2/station
/obj/effect/shuttle_landmark/escape_pod/start/pod2
	number = 2
/obj/effect/shuttle_landmark/escape_pod/out/pod2
	number = 2
/obj/effect/shuttle_landmark/escape_pod/transit/pod2
	number = 2

/datum/shuttle/autodock/ferry/escape_pod/exodus/escape_pod3
	warmup_time = 10
	number = 3
	shuttle_area = /area/shuttle/escape_pod3/station
/obj/effect/shuttle_landmark/escape_pod/start/pod3
	number = 3
/obj/effect/shuttle_landmark/escape_pod/out/pod3
	number = 3
/obj/effect/shuttle_landmark/escape_pod/transit/pod3
	number = 3

/datum/shuttle/autodock/ferry/escape_pod/exodus/escape_pod5
	warmup_time = 10
	number = 5
	shuttle_area = /area/shuttle/escape_pod5/station
/obj/effect/shuttle_landmark/escape_pod/start/pod5
	number = 5
/obj/effect/shuttle_landmark/escape_pod/out/pod5
	number = 5
/obj/effect/shuttle_landmark/escape_pod/transit/pod5
	number = 5

/datum/shuttle/autodock/ferry/voxpost
	name = "Vox Employee"
	warmup_time = 8
	location = 1
	shuttle_area = /area/shuttle/vox
	waypoint_offsite = "vox_shuttle_outpost"
	waypoint_station = "vox_shuttle_station"
	current_location = "vox_shuttle_outpost"
	landmark_transition = "vox_shuttle_transit"
	dock_target = "vox_shuttle"
	move_time = 30
//	arrival_message = "Attention, Vox Employee Shuttle is arriving."
//	departure_message = "Attention, Vox Employee Shuttle is departing."

/obj/effect/shuttle_landmark/voxferry/start
	name = "Off-site"
	landmark_tag = "vox_shuttle_outpost"
	docking_controller = "voxferry_outpost_berth"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/voxferry/transit
	name = "In transit"
	landmark_tag = "vox_shuttle_transit"
	base_turf = /turf/space/bluespace
	base_area = /area/space

/obj/effect/shuttle_landmark/voxferry/station
	name = "Docked"
	landmark_tag = "vox_shuttle_station"
	docking_controller = "voxferry_station_berth"
	base_area = /area/space
	base_turf = /turf/space

/datum/shuttle/autodock/ferry/mining
	name = "Mining"
	warmup_time = 10
	shuttle_area = /area/shuttle/mining
	waypoint_offsite = "mining_outpost"
	waypoint_station = "mining_berth"
	current_location = "mining_berth"
	dock_target = "mining_shuttle"

/obj/effect/shuttle_landmark/mining/station
	name = "Station"
	landmark_tag = "mining_berth"
	docking_controller = "mining_dock_airlock"
	base_turf = /turf/space
	base_area = /area/space

/obj/effect/shuttle_landmark/mining/outpost
	name = "Asteroid"
	landmark_tag = "mining_outpost"
	docking_controller = "mining_outpost_airlock"
	base_turf = /turf/simulated/floor/asteroid
	base_area = /area/mine/explored


/datum/shuttle/autodock/ferry/research
	name = "Research"
	warmup_time = 10
	shuttle_area = /area/shuttle/research/station
	waypoint_offsite = "research_outpost"
	waypoint_station = "research_station"
	current_location = "research_station"
	dock_target = "research_shuttle"

/obj/effect/shuttle_landmark/research/station
	name = "Station"
	landmark_tag = "research_station"
	docking_controller = "research_dock_airlock"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/research/outpost
	name = "Outpost"
	landmark_tag = "research_outpost"
	docking_controller = "research_outpost_dock"
	base_area = /area/mine/explored
	base_turf = /turf/simulated/floor/asteroid


/datum/shuttle/autodock/ferry/engineering
	name = "Engineering"
	warmup_time = 10
	shuttle_area = /area/shuttle/constructionsite
	waypoint_offsite = "engi_shuttle_outpost"
	waypoint_station = "engi_shuttle_station"
	current_location = "engi_shuttle_station"
	dock_target = "engineering_shuttle"

/obj/effect/shuttle_landmark/engineering/station
	name = "Station"
	landmark_tag = "engi_shuttle_station"
	docking_controller = "engineering_dock_airlock"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/engineering/outpost
	name = "Outpost"
	landmark_tag = "engi_shuttle_outpost"
	docking_controller = "edock_airlock"
	base_area = /area/mine/explored
	base_turf = /turf/simulated/floor/asteroid

/datum/shuttle/autodock/ferry/supply/drone
	name = "Supply Drone"
	warmup_time = 20
	location = 1
	current_location = "nav_cargo_start"
	shuttle_area = /area/shuttle/supply
	waypoint_offsite = "nav_cargo_start"
	waypoint_station = "nav_cargo_station"
	dock_target = "supply_shuttle"

/obj/effect/shuttle_landmark/supply/centcom
	name = "Offsite"
	landmark_tag = "nav_cargo_start"

/obj/effect/shuttle_landmark/supply/station
	name = "Hangar"
	landmark_tag = "nav_cargo_station"
	docking_controller = "cargo_bay"

//Departure Shuttle. Unsure if this is necessary. We'll see.
/datum/shuttle/autodock/ferry/emergency
	name = "Departure"
	warmup_time = 10
	shuttle_area = /area/shuttle/escape/centcom
	location = 1
	waypoint_offsite = "departure_centcom"
	waypoint_station = "departure_station"
	landmark_transition = "departure_transit"
	dock_target = "escape_shuttle"
	current_location = "departure_centcom"

/obj/effect/shuttle_landmark/departure/start
	name = "Safe"
	docking_controller ="centcom_dock"
	landmark_tag = "departure_centcom"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/departure/transit
	name = "In Transit"
	landmark_tag = "departure_transit"
	base_area = /area/space
	base_turf = /turf/space/bluespace


/obj/effect/shuttle_landmark/departure/station
	name = "Station"
	docking_controller = "escape_dock"
	landmark_tag = "departure_station"
	base_area = /area/space
	base_turf = /turf/space

/datum/shuttle/autodock/multi/antag/skipjack
	name = "Skipjack"
	warmup_time = 10
	destination_tags = list(
		"nav_skipjack_ne",
		"nav_skipjack_nw",
		"nav_skipjack_se",
		"nav_skipjack_sw",
		"nav_skipjack_telcom",
		"nav_skipjack_mine",
		"nav_skipjack_outpost",
		"nav_skipjack_derelict",
		"nav_skipjack_dock",
		"nav_skipjack_start",
		)
	shuttle_area = /area/skipjack_station/start
//	dock_target = "skipjack_shuttle"
	current_location = "nav_skipjack_start"
	landmark_transition = "nav_skipjack_transition"
	announcer = "Regional Operations Traffic Control"
	home_waypoint = "nav_skipjack_start"
	arrival_message = "Attention, unidentified vessel detected entering station proximity."
	departure_message = "Attention, unidentified vessel detected leaving station proximity."

/obj/effect/shuttle_landmark/skipjack/start
	name = "Raider Outpost"
	landmark_tag = "nav_skipjack_start"
//	docking_controller = "skipjack_base"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/skipjack/interim
	name = "In transit"
	landmark_tag = "nav_skipjack_transition"
/*
/obj/effect/shuttle_landmark/skipjack/dock
	name = "Docking Port"
	landmark_tag = "nav_skipjack_dock"
	docking_controller = "skipjack_shuttle_dock_airlock"*/
	base_turf = /turf/space/bluespace

/obj/effect/shuttle_landmark/skipjack/nw
	name = "Northwest of Station"
	landmark_tag = "nav_skipjack_nw"

/obj/effect/shuttle_landmark/skipjack/ne
	name = "Northeast of Station"
	landmark_tag = "nav_skipjack_ne"

/obj/effect/shuttle_landmark/skipjack/sw
	name = "Southwest of Station"
	landmark_tag = "nav_skipjack_sw"

/obj/effect/shuttle_landmark/skipjack/se
	name = "Southeast of Station"
	landmark_tag = "nav_skipjack_se"

/obj/effect/shuttle_landmark/skipjack/mine
	name = "Asteroid near Station"
	landmark_tag = "nav_skipjack_mine"
	base_area = /area/mine/explored
	base_turf = /turf/simulated/floor/asteroid

/obj/effect/shuttle_landmark/skipjack/outpost
	name = "Curious satellite near station"
	landmark_tag = "nav_skipjack_outpost"

/obj/effect/shuttle_landmark/skipjack/telcom
	name = "Telcom Relay Satellite"
	landmark_tag = "nav_skipjack_telcom"

/obj/effect/shuttle_landmark/skipjack/derelict
	name = "Abandoned Derelict"
	landmark_tag = "nav_skipjack_derelict"





// Cargo shuttle.
/*/datum/shuttle/ferry/supply/cargo
	name = "Supply"
	location = 1
	warmup_time = 10
	area_offsite = /area/supply/dock
	area_station = /area/supply/station
	docking_controller_tag = "supply_shuttle"
	dock_target_station = "cargo_bay"
	flags = SHUTTLE_FLAGS_PROCESS|SHUTTLE_FLAGS_SUPPLY

// The "Elevators"
/datum/shuttle/ferry/engineering
	name = "Engineering"
	warmup_time = 10
	area_offsite = /area/shuttle/constructionsite/site
	area_station = /area/shuttle/constructionsite/station
	docking_controller_tag = "engineering_shuttle"
	dock_target_station = "engineering_dock_airlock"
	dock_target_offsite = "edock_airlock"

/datum/shuttle/ferry/mining
	name = "Mining"
	warmup_time = 10
	area_offsite = /area/shuttle/mining/outpost
	area_station = /area/shuttle/mining/station
	docking_controller_tag = "mining_shuttle"
	dock_target_station = "mining_dock_airlock"
	dock_target_offsite = "mining_outpost_airlock"

/datum/shuttle/ferry/research
	name = "Research"
	warmup_time = 10
	area_offsite = /area/shuttle/research/outpost
	area_station = /area/shuttle/research/station
	docking_controller_tag = "research_shuttle"
	dock_target_station = "research_dock_airlock"
	dock_target_offsite = "research_outpost_dock"

// Admin shuttles.
/datum/shuttle/ferry/centcom
	name = "Centcom"
	location = 1
	warmup_time = 10
	area_offsite = /area/shuttle/transport1/centcom
	area_station = /area/shuttle/transport1/station
	docking_controller_tag = "centcom_shuttle"
	dock_target_station = "centcom_shuttle_dock_airlock"
	dock_target_offsite = "centcom_shuttle_bay"

/datum/shuttle/ferry/administration
	name = "Administration"
	location = 1
	warmup_time = 10	//want some warmup time so people can cancel.
	area_offsite = /area/shuttle/administration/centcom
	area_station = /area/shuttle/administration/station
	docking_controller_tag = "admin_shuttle"
	dock_target_station = "admin_shuttle_dock_airlock"
	dock_target_offsite = "admin_shuttle_bay"

// Traders
/datum/shuttle/ferry/trade
	name = "Trade"
	location = 1
	warmup_time = 10	//want some warmup time so people can cancel.
	area_offsite = /area/shuttle/trade/centcom
	area_station = /area/shuttle/trade/station
	docking_controller_tag = "trade_shuttle"
	dock_target_station = "trade_shuttle_dock_airlock"
	dock_target_offsite = "trade_shuttle_bay"

// Is this even used?
/datum/shuttle/ferry/alien
	name = "Alien"
	area_offsite = /area/shuttle/alien/base
	area_station = /area/shuttle/alien/mine
	flags = SHUTTLE_FLAGS_NONE

// Mercenary
/datum/shuttle/multi_shuttle/mercenary
	name = "Mercenary"
	warmup_time = 0
	origin = /area/syndicate_station/start
	interim = /area/syndicate_station/transit
	can_cloak = TRUE
	cloaked = TRUE
	start_location = "Mercenary Base"
	destinations = list(
		"Northwest of the station" = /area/syndicate_station/northwest,
		"North of the station" = /area/syndicate_station/north,
		"Northeast of the station" = /area/syndicate_station/northeast,
		"Southwest of the station" = /area/syndicate_station/southwest,
		"South of the station" = /area/syndicate_station/south,
		"Southeast of the station" = /area/syndicate_station/southeast,
		"Telecomms Satellite" = /area/syndicate_station/commssat,
		"Mining Station" = /area/syndicate_station/mining,
		"Arrivals dock" = /area/syndicate_station/arrivals_dock,
		)
	docking_controller_tag = "merc_shuttle"
	destination_dock_targets = list(
		"Mercenary Base" = "merc_base",
		"Arrivals dock" = "nuke_shuttle_dock_airlock",
		)
	announcer = "Automated Traffic Control"

/datum/shuttle/multi_shuttle/mercenary/New()
	arrival_message = "Attention.  A vessel is approaching the colony."
	departure_message = "Attention.  A vessel is now leaving from the colony."
	..()

// Heist
/datum/shuttle/multi_shuttle/skipjack
	name = "Skipjack"
	warmup_time = 0
	origin = /area/skipjack_station/start
	interim = /area/skipjack_station/transit
	can_cloak = TRUE
	cloaked = TRUE
	destinations = list(
		"Fore Starboard Solars" = /area/skipjack_station/northeast_solars,
		"Fore Port Solars" = /area/skipjack_station/northwest_solars,
		"Aft Starboard Solars" = /area/skipjack_station/southeast_solars,
		"Aft Port Solars" = /area/skipjack_station/southwest_solars,
		"Mining Station" = /area/skipjack_station/mining
		)
	announcer = "Automated Traffic Control"

/datum/shuttle/multi_shuttle/skipjack/New()
	arrival_message = "Attention.  Unidentified object approaching the colony."
	departure_message = "Attention.  Unidentified object exiting local space.  Unidentified object expected to escape Kara gravity well with current velocity."
	..()

/datum/shuttle/ferry/multidock/specops/ert
	name = "Special Operations"
	location = 0
	warmup_time = 10
	area_offsite = /area/shuttle/specops/station	//centcom is the home station, the Exodus is offsite
	area_station = /area/shuttle/specops/centcom
	docking_controller_tag = "specops_shuttle_port"
	docking_controller_tag_station = "specops_shuttle_port"
	docking_controller_tag_offsite = "specops_shuttle_fore"
	dock_target_station = "specops_centcom_dock"
	dock_target_offsite = "specops_dock_airlock"

/datum/shuttle/ferry/multidock/vox
	name = "Vox Outpost"
	location = 0
	warmup_time = 10
	area_offsite = /area/shuttle/vox/station
	area_station = /area/shuttle/vox/outpost
	docking_controller_tag = "vox_shuttle_airlock"
	docking_controller_tag_station = "vox_shuttle_airlock"
	docking_controller_tag_offsite = "vox_shuttle_airlock"
	dock_target_station = "vox_outpost_dock"
	dock_target_offsite = "vox_shuttle_dock"*/

