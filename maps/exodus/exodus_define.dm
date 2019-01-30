#define Z_LEVEL_MAIN								1
#define Z_LEVEL_CENTCOM								2
#define Z_LEVEL_TELECOMMS							3
#define Z_LEVEL_ABANDONED_ASTEROID					4
#define Z_LEVEL_MINING								5
#define Z_LEVEL_EMPTY								6
#define Z_LEVEL_VOX_OUTPOST							7


// Z-level flags bitfield - Set these flags to determine the z level's purpose
#define MAP_LEVEL_STATION		0x001 // Z-levels the station exists on
#define MAP_LEVEL_ADMIN			0x002 // Z-levels for admin functionality (Centcom, shuttle transit, etc)
#define MAP_LEVEL_CONTACT		0x004 // Z-levels that can be contacted from the station, for eg announcements
#define MAP_LEVEL_PLAYER		0x008 // Z-levels a character can typically reach
#define MAP_LEVEL_SEALED		0x010 // Z-levels that don't allow random transit at edge
#define MAP_LEVEL_EMPTY			0x020 // Empty Z-levels that may be used for various things (currently used by bluespace jump)
#define MAP_LEVEL_CONSOLES		0x040 // Z-levels available to various consoles, such as the crew monitor (when that gets coded in). Defaults to station_levels if unset.

#define PIPE_COLOR_PURPLE		#ff00ff

// Misc map defines.
#define SUBMAP_MAP_EDGE_PAD 15 // Automatically created submaps are forbidden from being this close to the main map's edge.

/datum/map/exodus
	name = "Exodus"
	full_name = "NSS Exodus"
	path = "exodus"

	station_name  = "NSS Endeavor"
	station_short = "Endeavor"
	dock_name     = "Pyro VI L2 R&R Outpost"
	boss_name     = "Regional Operations"
	boss_short    = "RegOps"
	company_name  = "Nanotrasen"
	company_short = "NT"
	system_name   = "Pyro"

	station_levels = list(1, 3, 5, 7)
	contact_levels = list(1, 2, 3, 5, 7)
	player_levels = list(1, 3, 4, 5, 6, 7)
	admin_levels = list(2)
	empty_levels = list(6)

	default_law_type = /datum/ai_laws/nanotrasen

	accessible_z_levels = list("1"=2,"3"=1,"4"=1,"5"=5,"6"=20,"7"=1)

	use_overmap = 0
	//num_exoplanets = 0

	allowed_spawns = list("Arrivals Shuttle", "Gateway", "Cryogenic Storage", "Cyborg Storage", "Vox Employee Outpost")
	default_spawn = "Arrivals Shuttle"

	shuttle_docked_message = "The scheduled shuttle to the %dock_name% has docked with the station at docks one and two. It will depart in approximately %ETD%."
	shuttle_leaving_dock = "The Crew Transfer Shuttle has left the station. Estimate %ETA% until the shuttle docks at %dock_name%."
	shuttle_called_message = "A crew transfer to %Dock_name% has been scheduled. The shuttle has been called. Those leaving should proceed to docks one and two in approximately %ETA%."
	shuttle_recall_message = "The scheduled crew transfer has been cancelled."
	emergency_shuttle_docked_message = "The Emergency Shuttle has docked with the station at docks one and two. You have approximately %ETD% to board the Emergency Shuttle."
	emergency_shuttle_leaving_dock = "The Emergency Shuttle has left the station. Estimate %ETA% until the shuttle docks at %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation shuttle has been called. It will arrive at docks one and two in approximately %ETA%."
	emergency_shuttle_recall_message = "The emergency shuttle has been recalled."

	evac_controller_type = /datum/evacuation_controller/shuttle
/*
/datum/map/exodus/perform_map_generation()

//	new /datum/random_map/automata/cave_system(TRUE, 1, 1, Z_LEVEL_ABANDONED_ASTEROID, world.maxx, world.maxy) // Create the mining Z-level.
//	new /datum/random_map/noise/ore(TRUE, 1, 1, Z_LEVEL_ABANDONED_ASTEROID, world.maxx, world.maxy)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(TRUE, 1, 1, Z_LEVEL_MINING, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(TRUE, 1, 1, Z_LEVEL_MINING, world.maxx, world.maxy)         // Create the mining ore distribution map.
	return 1
*/