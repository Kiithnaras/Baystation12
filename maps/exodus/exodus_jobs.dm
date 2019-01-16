/datum/map/exodus
	species_to_job_whitelist = list(
		/datum/species/adherent = list(/datum/job/ai, /datum/job/cyborg, /datum/job/assistant, /datum/job/janitor, /datum/job/chef, /datum/job/bartender, /datum/job/cargo_tech,
										/datum/job/roboticist, /datum/job/chemist, /datum/job/mining, /datum/job/scientist, /datum/job/hydro),
		/datum/species/nabber = list(/datum/job/ai, /datum/job/cyborg, /datum/job/janitor, /datum/job/chemist, /datum/job/mining, /datum/job/scientist,
									 /datum/job/roboticist, /datum/job/cargo_tech, /datum/job/chef, /datum/job/bartender, /datum/job/hydro),
	)

#define HUMAN_ONLY_JOBS /datum/job/captain, /datum/job/hop, /datum/job/cmo, /datum/job/chief_engineer, /datum/job/hos, /datum/job/lawyer
	species_to_job_blacklist = list(
		/datum/species/unathi  = list(HUMAN_ONLY_JOBS, /datum/job/warden), //Other jobs unavailable via branch restrictions,
		/datum/species/skrell  = list(HUMAN_ONLY_JOBS),
		/datum/species/machine = list(HUMAN_ONLY_JOBS),
		/datum/species/diona   = list(HUMAN_ONLY_JOBS, /datum/job/officer, /datum/job/rd, /datum/job/warden),	//Other jobs unavailable via branch restrictions,
	)
#undef HUMAN_ONLY_JOBS
	species_to_job_blacklist = list(
		/datum/species/vox = list(/datum/job/lawyer),
	)

/datum/job/captain
	ideal_character_age = 45

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT,
	                    SKILL_PILOT       = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)
	skill_points = 54

/datum/job/hop
	ideal_character_age = 35

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	skill_points = 36

/datum/job/hop/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(H.species.name == SPECIES_VOX)
		H.implant_loyalty(H)

/datum/job/chief_engineer
	ideal_character_age = 30
	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_EVA          = SKILL_ADEPT,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_ADEPT,
	                    SKILL_ATMOS        = SKILL_BASIC,
	                    SKILL_ENGINES      = SKILL_ADEPT)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)
	skill_points = 36

/datum/job/chief_engineer/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(H.species.name == SPECIES_VOX)
		H.implant_loyalty(H)

/datum/job/rd
	ideal_character_age = 45
	skill_points = 44

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/aidiag,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_FINANCE     = SKILL_ADEPT,
	                    SKILL_BOTANY      = SKILL_BASIC,
	                    SKILL_ANATOMY     = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

/datum/job/rd/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(H.species.name == SPECIES_VOX)
		H.implant_loyalty(H)

/datum/job/cmo
	ideal_character_age = 45
	skill_points = 44

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_ADEPT,
	                    SKILL_ANATOMY     = SKILL_EXPERT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
	                    SKILL_VIROLOGY    = SKILL_BASIC)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX,
	                    SKILL_VIROLOGY    = SKILL_MAX)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

/datum/job/cmo/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(H.species.name == SPECIES_VOX)
		H.implant_loyalty(H)

/datum/job/hos
	ideal_character_age = 35
	skill_points = 36
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_ADEPT,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_MAX,
	                    SKILL_WEAPONS     = SKILL_MAX,
	                    SKILL_FORENSICS   = SKILL_MAX)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

//Security

/datum/job/warden
	skill_points = 32

/datum/job/detective
	skill_points = 32

/datum/job/officer
	skill_points = 24

//Medical

/datum/job/doctor
	skill_points = 36

/datum/job/chemist
	skill_points = 32

/datum/job/psychiatrist
	skill_points = 24

/datum/job/paramedic
	skill_points = 24

//Science

/datum/job/scientist
	skill_points = 32

/datum/job/xenobiologist
	skill_points = 32

/datum/job/roboticist
	skill_points = 28

//Engineering

/datum/job/engineer
	skill_points = 32

/datum/job/atmos
	skill_points = 24

//Cargo

/datum/job/qm
	skill_points = 24

/datum/job/cargo_tech
	skill_points = 16

/datum/job/mining
	skill_points = 20

/datum/job/janitor
	skill_points = 16

//Civilian

/datum/job/bartender
	skill_points = 20

/datum/job/chef
	skill_points = 24

/datum/job/hydro
	skill_points = 24

/datum/job/librarian
	skill_points = 24

/datum/job/lawyer
	skill_points = 48

/datum/job/assistant
	skill_points = 24