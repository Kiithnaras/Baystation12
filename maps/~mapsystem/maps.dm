GLOBAL_DATUM_INIT(using_map, /datum/map, new using_map_DATUM)
GLOBAL_LIST_EMPTY(all_maps)

var/const/MAP_HAS_BRANCH = 1	//Branch system for occupations, togglable
var/const/MAP_HAS_RANK = 2		//Rank system, also togglable

/hook/startup/proc/initialise_map_list()
	for(var/type in typesof(/datum/map) - /datum/map)
		var/datum/map/M
		if(type == GLOB.using_map.type)
			M = GLOB.using_map
			M.setup_map()
		else
			M = new type
		if(!M.path)
			log_error("Map '[M]' does not have a defined path, not adding to map list!")
		else
			GLOB.all_maps[M.path] = M
	return 1


/datum/map
	var/name = "Unnamed Map"
	var/full_name = "Unnamed Map"
	var/path

	var/list/zlevels = list()
	var/zlevel_datum_type			// If populated, all subtypes of this type will be instantiated and used to populate the *_levels lists.

	var/list/station_levels = list() // Z-levels the station exists on
	var/list/admin_levels = list()   // Z-levels for admin functionality (Centcom, shuttle transit, etc)
	var/list/contact_levels = list() // Z-levels that can be contacted from the station, for eg announcements
	var/list/player_levels = list()  // Z-levels a character can typically reach
	var/list/sealed_levels = list()  // Z-levels that don't allow random transit at edge
	var/list/empty_levels = null     // Empty Z-levels that may be used for various things (currently used by bluespace jump)

	var/list/map_levels              // Z-levels available to various consoles, such as the crew monitor. Defaults to station_levels if unset.

	var/list/base_turf_by_z = list() // Custom base turf by Z-level. Defaults to world.turf for unlisted Z-levels
	var/list/usable_email_tlds = list("freemail.net")
	var/base_floor_type = /turf/simulated/floor/airless // The turf type used when generating floors between Z-levels at startup.
	var/base_floor_area                                 // Replacement area, if a base_floor_type is generated. Leave blank to skip.

	//This list contains the z-level numbers which can be accessed via space travel and the percentile chances to get there.
	var/list/accessible_z_levels = list()

	var/list/allowed_jobs	       //Job datums to use.
	                               //Works a lot better so if we get to a point where three-ish maps are used
	                               //We don't have to C&P ones that are only common between two of them
	                               //That doesn't mean we have to include them with the rest of the jobs though, especially for map specific ones.
	                               //Also including them lets us override already created jobs, letting us keep the datums to a minimum mostly.
	                               //This is probably a lot longer explanation than it needs to be.

	var/station_name  = "BAD Station"
	var/station_short = "Baddy"
	var/dock_name     = "THE PirateBay"
	var/boss_name     = "Captain Roger"
	var/boss_short    = "Cap'"
	var/company_name  = "BadMan"
	var/company_short = "BM"
	var/system_name = "Uncharted System"

	var/map_admin_faxes = list()

	var/shuttle_docked_message
	var/shuttle_leaving_dock
	var/shuttle_called_message
	var/shuttle_recall_message
	var/emergency_shuttle_docked_message
	var/emergency_shuttle_leaving_dock
	var/emergency_shuttle_recall_message

	var/list/station_networks = list() 		// Camera networks that will show up on the console.

	var/list/holodeck_programs = list() // map of string ids to /datum/holodeck_program instances
	var/list/holodeck_supported_programs = list() // map of maps - first level maps from list-of-programs string id (e.g. "BarPrograms") to another map
												  // this is in order to support multiple holodeck program listings for different holodecks
	                                              // second level maps from program friendly display names ("Picnic Area") to program string ids ("picnicarea")
	                                              // as defined in holodeck_programs
	var/list/holodeck_restricted_programs = list() // as above... but EVIL!

	var/allowed_spawns = list("Arrivals Shuttle","Gateway", "Cryogenic Storage", "Cyborg Storage")
	var/default_spawn = "Arrivals Shuttle"
	var/flags = 0
	var/evac_controller_type = /datum/evacuation_controller
	var/use_overmap = 0		//If overmap should be used (including overmap space travel override)
	var/overmap_size = 20		//Dimensions of overmap zlevel if overmap is used.
	var/overmap_z = 0		//If 0 will generate overmap zlevel on init. Otherwise will populate the zlevel provided.
	var/overmap_event_areas = 0 //How many event "clouds" will be generated

	var/lobby_icon									// The icon which contains the lobby image(s)
	var/list/lobby_screens = list()                 // The list of lobby screen to pick() from. If left unset the first icon state is always selected.
	var/music_track/lobby_track                     // The track that will play in the lobby screen.
	var/list/lobby_tracks = list()                  // The list of lobby tracks to pick() from. If left unset will randomly select among all available /music_track subtypes.
	var/welcome_sound = 'sound/AI/welcome.ogg'		// Sound played on roundstart

	var/default_law_type = /datum/ai_laws/nanotrasen  // The default lawset use by synth units, if not overriden by their laws var.
	var/security_state = /decl/security_state/default // The default security state system to use.

	var/id_hud_icons = 'icons/mob/hud.dmi' // Used by the ID HUD (primarily sechud) overlay.

	var/num_exoplanets = 0
	var/list/planet_size  //dimensions of planet zlevel, defaults to world size. Due to how maps are generated, must be (2^n+1) e.g. 17,33,65,129 etc. Map will just round up to those if set to anything other.
	var/away_site_budget = 0

	var/list/loadout_blacklist	//list of types of loadout items that will not be pickable

	//Economy stuff
	var/starting_money = 75000		//Money in station account
	var/department_money = 5000		//Money in department accounts
	var/salary_modifier	= 1			//Multiplier to starting character money
	var/station_departments = list()//Gets filled automatically depending on jobs allowed

	var/supply_currency_name = "Credits"
	var/supply_currency_name_short = "Cr."

	var/list/available_cultural_info = list(
		TAG_HOMEWORLD = list(
			HOME_SYSTEM_MARS,
			HOME_SYSTEM_LUNA,
			HOME_SYSTEM_EARTH,
			HOME_SYSTEM_VENUS,
			HOME_SYSTEM_CERES,
			HOME_SYSTEM_PLUTO,
			HOME_SYSTEM_TAU_CETI,
			HOME_SYSTEM_HELIOS,
			HOME_SYSTEM_TERRA,
			HOME_SYSTEM_TERSTEN,
			HOME_SYSTEM_LORRIMAN,
			HOME_SYSTEM_CINU,
			HOME_SYSTEM_YUKLID,
			HOME_SYSTEM_LORDANIA,
			HOME_SYSTEM_KINGSTON,
			HOME_SYSTEM_GAIA,
			HOME_SYSTEM_OTHER
		),
		TAG_FACTION = list(
			FACTION_SOL_CENTRAL,
			FACTION_INDIE_CONFED,
			FACTION_CORPORATE,
			FACTION_NANOTRASEN,
			FACTION_FREETRADE,
			FACTION_XYNERGY,
			FACTION_HEPHAESTUS,
			FACTION_DAIS,
			FACTION_EXPEDITIONARY,
			FACTION_FLEET,
			FACTION_PCRC,
			FACTION_OTHER
		),
		TAG_CULTURE = list(
			CULTURE_HUMAN_MARTIAN,
			CULTURE_HUMAN_MARSTUN,
			CULTURE_HUMAN_LUNAPOOR,
			CULTURE_HUMAN_LUNARICH,
			CULTURE_HUMAN_VENUSIAN,
			CULTURE_HUMAN_VENUSLOW,
			CULTURE_HUMAN_BELTER,
			CULTURE_HUMAN_PLUTO,
			CULTURE_HUMAN_EARTH,
			CULTURE_HUMAN_CETI,
			CULTURE_HUMAN_SPACER,
			CULTURE_HUMAN_SPAFRO,
			CULTURE_HUMAN_CONFED,
			CULTURE_HUMAN_OTHER,
			CULTURE_OTHER
		),
		TAG_RELIGION = list(
			RELIGION_OTHER,
			RELIGION_JUDAISM,
			RELIGION_HINDUISM,
			RELIGION_BUDDHISM,
			RELIGION_ISLAM,
			RELIGION_CHRISTIANITY,
			RELIGION_AGNOSTICISM,
			RELIGION_DEISM,
			RELIGION_ATHEISM,
			RELIGION_THELEMA,
			RELIGION_SPIRITUALISM
		),
		TAG_EDUCATION = list(
			EDUCATION_NONE,
			EDUCATION_DROPOUT,
			EDUCATION_HIGH_SCHOOL,
			EDUCATION_TRADE_SCHOOL,
			EDUCATION_UNDERGRAD,
			EDUCATION_MASTERS,
			EDUCATION_DOCTORATE,
			EDUCATION_MEDSCHOOL
		)
	)

	var/list/default_cultural_info = list(
		TAG_HOMEWORLD = HOME_SYSTEM_MARS,
		TAG_FACTION =   FACTION_SOL_CENTRAL,
		TAG_CULTURE =   CULTURE_HUMAN_MARTIAN,
		TAG_RELIGION =  RELIGION_AGNOSTICISM,
		TAG_EDUCATION = EDUCATION_HIGH_SCHOOL
	)

	var/access_modify_region = list(
		ACCESS_REGION_SECURITY = list(access_hos, access_change_ids),
		ACCESS_REGION_MEDBAY = list(access_cmo, access_change_ids),
		ACCESS_REGION_RESEARCH = list(access_rd, access_change_ids),
		ACCESS_REGION_ENGINEERING = list(access_ce, access_change_ids),
		ACCESS_REGION_COMMAND = list(access_change_ids),
		ACCESS_REGION_GENERAL = list(access_change_ids),
		ACCESS_REGION_SUPPLY = list(access_change_ids)
	)

/datum/map/New()
	if(!map_levels)
		map_levels = station_levels.Copy()
	if(!allowed_jobs)
		allowed_jobs = list()
		for(var/jtype in subtypesof(/datum/job))
			var/datum/job/job = jtype
			if(initial(job.available_by_default))
				allowed_jobs += jtype
	if(!planet_size)
		planet_size = list(world.maxx, world.maxy)

/datum/map/proc/setup_map()
	var/lobby_track_type
	if(lobby_tracks.len)
		lobby_track_type = pick(lobby_tracks)
	else
		lobby_track_type = pick(subtypesof(/music_track))

	lobby_track = decls_repository.get_decl(lobby_track_type)
	world.update_status()

/datum/map/proc/send_welcome()
	return

/datum/map/proc/perform_map_generation()
	return

/datum/map/proc/build_away_sites()
#ifdef UNIT_TEST
	report_progress("Unit testing, so not loading away sites")
	return // don't build away sites during unit testing
#else
	report_progress("Loading away sites...")
	var/list/sites_by_spawn_weight = list()
	for (var/site_name in SSmapping.away_sites_templates)
		var/datum/map_template/ruin/away_site/site = SSmapping.away_sites_templates[site_name]

		if((site.template_flags & TEMPLATE_FLAG_SPAWN_GUARANTEED) && site.load_new_z()) // no check for budget, but guaranteed means guaranteed
			report_progress("Loaded guaranteed away site [site]!")
			away_site_budget -= site.cost
			continue

		sites_by_spawn_weight[site] = site.spawn_weight
	while (away_site_budget > 0 && sites_by_spawn_weight.len)
		var/datum/map_template/ruin/away_site/selected_site = pickweight(sites_by_spawn_weight)
		if (!selected_site)
			break
		sites_by_spawn_weight -= selected_site
		if(selected_site.cost > away_site_budget)
			continue
		if (selected_site.load_new_z())
			report_progress("Loaded away site [selected_site]!")
			away_site_budget -= selected_site.cost
	report_progress("Finished loading away sites, remaining budget [away_site_budget], remaining sites [sites_by_spawn_weight.len]")
#endif

/datum/map/proc/build_exoplanets()
	if(!use_overmap)
		return

	for(var/i = 0, i < num_exoplanets, i++)
		var/exoplanet_type = pick(subtypesof(/obj/effect/overmap/sector/exoplanet))
		var/obj/effect/overmap/sector/exoplanet/new_planet = new exoplanet_type(null, planet_size[1], planet_size[2])
		new_planet.build_level()

// Used to apply various post-compile procedural effects to the map.
/datum/map/proc/refresh_mining_turfs(var/zlevel)

	set background = 1
	set waitfor = 0

	for(var/thing in mining_walls["[zlevel]"])
		var/turf/simulated/mineral/M = thing
		M.update_icon()
	for(var/thing in mining_floors["[zlevel]"])
		var/turf/simulated/floor/asteroid/M = thing
		if(istype(M))
			M.updateMineralOverlays()

/datum/map/proc/get_network_access(var/network)
	return 0

// By default transition randomly to another zlevel
/datum/map/proc/get_transit_zlevel(var/current_z_level)
	var/list/candidates = GLOB.using_map.accessible_z_levels.Copy()
	candidates.Remove(num2text(current_z_level))

	if(!candidates.len)
		return current_z_level
	return text2num(pickweight(candidates))

/datum/map/proc/get_empty_zlevel()
	if(empty_levels == null)
		world.maxz++
		empty_levels = list(world.maxz)
	return pick(empty_levels)
/*
// Get the list of zlevels that a computer on srcz can see maps of (for power/crew monitor, cameras, etc)
// The long_range parameter expands the coverage.  Default is to return map_levels for long range otherwise just srcz.
// zLevels outside station_levels will return an empty list.
/datum/map/proc/get_map_levels(var/srcz, var/long_range = TRUE)
	if (long_range && (srcz in map_levels))
		return map_levels
	else if (srcz in station_levels)
		return list(srcz)
	else
		return list()

/datum/map/proc/get_zlevel_name(var/index)
	var/datum/map_z_level/Z = zlevels["[index]"]
	return Z.name

// Another way to setup the map datum that can be convenient.  Just declare all your zlevels as subtypes of a common
// subtype of /datum/map_z_level and set zlevel_datum_type on /datum/map to have the lists auto-initialized.

// Structure to hold zlevel info together in one nice convenient package.
/datum/map_z_level
	var/z = 0				// Actual z-index of the zlevel. This had better be right!
	var/name				// Friendly name of the zlevel
	var/flags = 0			// Bitflag of which *_levels lists this z should be put into.
	var/turf/base_turf		// Type path of the base turf for this z
	var/transit_chance = 0	// Percentile chance this z will be chosen for map-edge space transit.

// Holomaps
	var/holomap_offset_x = -1	// Number of pixels to offset the map right (for centering) for this z
	var/holomap_offset_y = -1	// Number of pixels to offset the map up (for centering) for this z
	var/holomap_legend_x = 96	// x position of the holomap legend for this z
	var/holomap_legend_y = 96	// y position of the holomap legend for this z

// Default constructor applies itself to the parent map datum

// Default constructor applies itself to the parent map datum

/datum/map_z_level/New(var/datum/map/map)
	if(!z) return
	map.zlevels["[z]"] = src
	if(flags & MAP_LEVEL_STATION) map.station_levels += z
	if(flags & MAP_LEVEL_ADMIN) map.admin_levels += z
	if(flags & MAP_LEVEL_CONTACT) map.contact_levels += z
	if(flags & MAP_LEVEL_PLAYER) map.player_levels += z
	if(flags & MAP_LEVEL_SEALED) map.sealed_levels += z
	if(flags & MAP_LEVEL_EMPTY)
		if(!map.empty_levels) map.empty_levels = list()
		map.empty_levels += z
	if(flags & MAP_LEVEL_CONSOLES)
		if (!map.map_levels) map.map_levels = list()
		map.map_levels += z
	if(base_turf)
		map.base_turf_by_z["[z]"] = base_turf
	if(transit_chance)
		map.accessible_z_levels["[z]"] = transit_chance
	// Holomaps
	// Auto-center the map if needed (Guess based on maxx/maxy)
*/


/datum/map/proc/setup_economy()
	news_network.CreateFeedChannel("Nyx Daily", "SolGov Minister of Information", 1, 1)
	news_network.CreateFeedChannel("The Gibson Gazette", "Editor Mike Hammers", 1, 1)

	for(var/loc_type in typesof(/datum/trade_destination) - /datum/trade_destination)
		var/datum/trade_destination/D = new loc_type
		weighted_randomevent_locations[D] = D.viable_random_events.len
		weighted_mundaneevent_locations[D] = D.viable_mundane_events.len

	if(!station_account)
		station_account = create_account("[station_name()] Primary Account", starting_money)

	for(var/job in allowed_jobs)
		var/datum/job/J = decls_repository.get_decl(job)
		if(J.department)
			station_departments |= J.department
	for(var/department in station_departments)
		department_accounts[department] = create_account("[department] Account", department_money)

	department_accounts["Vendor"] = create_account("Vendor Account", 0)
	vendor_account = department_accounts["Vendor"]

/datum/map/proc/map_info(var/client/victim)
	return

/datum/map/proc/bolt_saferooms()
	return // overriden by torch

/datum/map/proc/unbolt_saferooms()
	return // overriden by torch

/datum/map/proc/make_maint_all_access(var/radstorm = 0) // parameter used by torch
	maint_all_access = 1
	priority_announcement.Announce("The maintenance access requirement has been revoked on all maintenance airlocks.", "Attention!")

/datum/map/proc/revoke_maint_all_access(var/radstorm = 0) // parameter used by torch
	maint_all_access = 0
	priority_announcement.Announce("The maintenance access requirement has been readded on all maintenance airlocks.", "Attention!")

// Access check is of the type requires one. These have been carefully selected to avoid allowing the janitor to see channels he shouldn't
// This list needs to be purged but people insist on adding more cruft to the radio.
/datum/map/proc/default_internal_channels()
	return list(
		num2text(PUB_FREQ)   = list(),
		num2text(AI_FREQ)    = list(access_synth),
		num2text(ENT_FREQ)   = list(),
		num2text(ERT_FREQ)   = list(access_cent_specops),
		num2text(COMM_FREQ)  = list(access_bridge),
		num2text(ENG_FREQ)   = list(access_engine_equip, access_atmospherics),
		num2text(MED_FREQ)   = list(access_medical_equip),
		num2text(MED_I_FREQ) = list(access_medical_equip),
		num2text(SEC_FREQ)   = list(access_security),
		num2text(SEC_I_FREQ) = list(access_security),
		num2text(SCI_FREQ)   = list(access_tox,access_robotics,access_xenobiology),
		num2text(SUP_FREQ)   = list(access_cargo),
		num2text(SRV_FREQ)   = list(access_janitor, access_hydroponics),
	)
