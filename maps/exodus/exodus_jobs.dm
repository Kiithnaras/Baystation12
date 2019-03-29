/datum/map/exodus
	species_to_job_whitelist = list(
		/datum/species/adherent = list(/datum/job/ai, /datum/job/cyborg, /datum/job/assistant, /datum/job/janitor, /datum/job/chef, /datum/job/bartender, /datum/job/cargo_tech,
										/datum/job/roboticist, /datum/job/chemist, /datum/job/mining, /datum/job/scientist, /datum/job/hydro),
		/datum/species/nabber = list(/datum/job/ai, /datum/job/cyborg, /datum/job/janitor, /datum/job/chemist, /datum/job/mining, /datum/job/scientist, /datum/job/engineer, /datum/job/Paramedic,
									 /datum/job/roboticist, /datum/job/cargo_tech, /datum/job/chef, /datum/job/bartender, /datum/job/hydro, /datum/job/officer, /datum/job/assistant, /datum/job/qm)
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
	alt_titles = list("Commander","Overseer","Station Director")

/datum/job/captain/get_description_blurb()
	return "As Captain or other Station Director, you are ultimately responsible for the safety and productivity of the station at large. A proper Captain should not actively take a role in any department, but rely on their subordinate Heads to keep the station running smoothly and efficiently. A Captain becomes an active crew member when other Heads are absent or indisposed, and every Captain should be capable of adequately filling another Head role should the need arise. Otherwise, a Captain's primary responsibility is to resolve conflicts or authorize certain activities, actions, and policies in accordance with the best interests of NanoTrasen and the Endeavour. All persons assigned to Captaincy should be highly experienced and are required to receive and maintain a NanoTrasen-issued Loyalty Implant."

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
	alt_titles = list("Human Resources Director","Operations Director","Chief Organizational Officer")

/datum/job/hop/get_description_blurb()
	return "As Ops Director/HOP, you are second-in-command of station operations. You answer directly to and only to the Captain (and Reg Ops). Unlike the Captain, you take a more active role in departmental and inter-departmental affairs, particularly where divisions are under- or over-staffed. It is also ultimately your duty to resolve any interpersonal conflicts that may arise within departments that may affect station productivity."

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

/datum/job/chief_engineer/get_description_blurb()
	return "As Chief Engineer, you are an experienced engineering staff member. You answer directly to the Captain and Operations Director. A Chief Engineer should be well-versed in all of the electrical, mechanical, and atmospheric functions of the station. The CE is also responsible for developing, maintaining, and enacting various emergency response protocols, particularly in response to fire, hull breach, explosion, or power loss events."

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

/datum/job/rd/get_description_blurb()
	return "As Chief Science Officer, you are a well-versed scientist, likely holding one or more doctorates in different fields of study. You answer directly to the Captain and Ops Director. A CSO is responsible for the productivity of scientific research aboard the station. This includes analytical studies, archaeology digs, xenobiology studies, and safe explosive testing."

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

/datum/job/cmo/get_description_blurb()
	return "As Chief Medical Officer, you are responsible for the skill and competence of your medical team. You answer directly to the Captain and Ops Director. A CMO is responsible for the speed, efficiency, and effectivity of the rest of the medical staff, especially in organizational and duty delegations."

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
	alt_titles = list("Chief of Security","Security Chief")

/datum/job/hos/get_description_blurb()
	return "The Head of Security is responsible for the safe and smooth operation of the station and the safety of its crew. You answer directly to the Captain and Ops Director. The Security Chief is reponsible for maintaining a competent and proper security force and observing appropriate Standard Operating Procedures for a given situation. They are also responsible for the security and timely processing of security violators as well as responding to emergency security threats."

//Security

/datum/job/warden
	skill_points = 32
	alt_titles = list("Armory Quartermaster","Prison Overseer")
	min_skill = list(	SKILL_BUREAUCRACY	= SKILL_BASIC,
						SKILL_WEAPONS		= SKILL_BASIC,
						SKILL_COMBAT		= SKILL_BASIC)
	max_skill = list(	SKILL_COMBAT		= SKILL_MAX,
						SKILL_WEAPONS		= SKILL_MAX,
						SKILL_FORENSICS		= SKILL_MAX)

/datum/job/warden/get_description_blurb()
	return "As Warden, your reponsibilities are twofold - the Armory and Brig. You answer directly to the Security Chief. Your task is to maintain proper authorizations and documentation of Armory and Sub-Armory equipment usage as well as proper and timely processing, detention, and release of security violators."

/datum/job/detective
	skill_points = 32
	min_skill = list(	SKILL_FORENSICS		= SKILL_ADEPT,
						SKILL_COMBAT		= SKILL_BASIC,
						SKILL_BUREAUCRACY	= SKILL_BASIC)
	max_skill = list(	SKILL_FORENSICS		= SKILL_MAX,
						SKILL_COMBAT		= SKILL_MAX,
						SKILL_WEAPONS		= SKILL_MAX)

/datum/job/detective/get_description_blurb()
	return "As Detective, you answer to the Chief of Security and are reponsible for the gathering of any necessary forensic evidence to prosecute CorpReg violators. You are NOT a stone-cold one-man army, despite any proclivity toward noir-style self-narration, nor are you permitted to make arrests without explicit authorization or support of other Officers."

/datum/job/officer
	skill_points = 24
	min_skill = list(	SKILL_COMBAT		= SKILL_BASIC,
						SKILL_WEAPONS		= SKILL_BASIC,
						SKILL_BUREAUCRACY	= SKILL_BASIC)
	max_skill = list(	SKILL_COMBAT		= SKILL_MAX,
						SKILL_WEAPONS		= SKILL_MAX)

/datum/job/officer/get_description_blurb()
	return "As a Security Officer, you are responsible for maintaining a safe work environment by ensuring the crew adhere to Corporate Regulations. Timely apprehension and processing along with appropriate use of force are crucial to Security Officer performance."

//Medical

/datum/job/doctor
	skill_points = 36
	min_skill = list(	SKILL_MEDICINE		= SKILL_ADEPT,
						SKILL_ANATOMY		= SKILL_BASIC,
						SKILL_VIROLOGY		= SKILL_BASIC,
						SKILL_CHEMISTRY		= SKILL_BASIC)
	max_skill = list(	SKILL_MEDICINE		= SKILL_MAX,
						SKILL_ANATOMY		= SKILL_MAX,
						SKILL_VIROLOGY		= SKILL_MAX,
						SKILL_CHEMISTRY		= SKILL_MAX)

/datum/job/doctor/get_description_blurb()
	return "As a Medical Officer, you are responsible for the health of the station's crew. These responsibilities include proper and timely diagnosis and treatment of any and all ailments. All Medical Officers should be properly trained and well-versed in their particular fields."

/datum/job/chemist
	skill_points = 32
	min_skill = list(	SKILL_CHEMISTRY		= SKILL_ADEPT,
						SKILL_MEDICINE		= SKILL_BASIC,
						SKILL_VIROLOGY		= SKILL_BASIC)
	max_skill = list(	SKILL_MEDICINE		= SKILL_MAX,
						SKILL_ANATOMY		= SKILL_MAX,
						SKILL_VIROLOGY		= SKILL_MAX,
						SKILL_CHEMISTRY		= SKILL_MAX)

/datum/job/chemist/get_description_blurb()
	return "A Chemist is responsible for keeping the Medical department properly staffed with various pharmaceuticals, and for providing other departments with necessary chemicals and reagents necessary to perform their duties."

/datum/job/psychiatrist
	skill_points = 24
	min_skill = list(	SKILL_CHEMISTRY		= SKILL_ADEPT,
						SKILL_MEDICINE		= SKILL_BASIC)
	max_skill = list(	SKILL_MEDICINE		= SKILL_MAX,
						SKILL_ANATOMY		= SKILL_MAX,
						SKILL_CHEMISTRY		= SKILL_MAX)

/datum/job/psychiatrist/get_description_blurb()
	return "The Psychiatrist is responsible for helping the remainder of the crew cope with the rigors of life in space confined on board an artifical station. NanoTrasen recognizes the various difficulties associated with artificial space habitation and that comfortable employees are productive employees."

/datum/job/Paramedic
	skill_points = 28
	min_skill = list(	SKILL_MEDICINE		= SKILL_BASIC,
						SKILL_ANATOMY		= SKILL_BASIC,
						SKILL_CHEMISTRY		= SKILL_BASIC)
	max_skill = list(	SKILL_MEDICINE		= SKILL_MAX,
						SKILL_ANATOMY		= SKILL_MAX,
						SKILL_VIROLOGY		= SKILL_MAX,
						SKILL_CHEMISTRY		= SKILL_MAX)

/datum/job/Paramedic/get_description_blurb()
	return "A Paramedic is the Medical Staff's first line of defense against loss of crew life. While Doctors are largely responsible for maintaining a presence within the Medical Wing, Paramedics are often required to venture into hazardous parts of the station or even space in order to retrieve, stabilize, and transport injured members of the crew."

//Science

/datum/job/scientist
	skill_points = 32
	min_skill = list(	SKILL_DEVICES		= SKILL_ADEPT,
						SKILL_SCIENCE		= SKILL_ADEPT)
	max_skill = list(	SKILL_DEVICES		= SKILL_MAX,
						SKILL_SCIENCE		= SKILL_MAX)

/datum/job/scientist/get_description_blurb()
	return "A Scientist is a member of the Research division and responsible for studying materials and devices to further NanoTrasen's studies of various concepts and materials. It is highly encouraged to work closely with Supply and Archaeology in order to accomplish these goals with expedience and minimal loss of materials. It is also your reponsibility to supply other departments with new discoveries that will enhance their productivity, and you should strive to return to Regional Operations with any discoveries at the end of the shift."

/datum/job/xenobiologist
	skill_points = 32
	min_skill = list(	SKILL_DEVICES		= SKILL_BASIC,
						SKILL_SCIENCE		= SKILL_BASIC,
						SKILL_ANATOMY		= SKILL_ADEPT)
	max_skill = list(	SKILL_DEVICES		= SKILL_MAX,
						SKILL_SCIENCE		= SKILL_MAX,
						SKILL_ANATOMY		= SKILL_MAX)

/datum/job/xenobiologist/get_description_blurb()
	return "A Xenobiologist primarily studies alien species and cultures and interfaces with alien species in first-contact situations. They are responsible for reporting any discoveries or useful information to the Chief Science Officer in a timely and concise manner,"

/datum/job/roboticist
	skill_points = 32
	alt_titles = list("Biomech Engineer","Mechanomotive Engineer","Synthetics Engineer","Prosthesis Engineer")
	min_skill = list(	SKILL_DEVICES		= SKILL_BASIC,
						SKILL_SCIENCE		= SKILL_BASIC,
						SKILL_ANATOMY		= SKILL_ADEPT,
						SKILL_MEDICINE		= SKILL_BASIC)
	max_skill = list(	SKILL_DEVICES		= SKILL_MAX,
						SKILL_SCIENCE		= SKILL_MAX,
						SKILL_ANATOMY		= SKILL_MAX)


/datum/job/roboticist/get_description_blurb()
	return "A Roboticist responsible for the construction, maintenance, and disbursement of Mechanical Exosuits and AI-slaved Robots and Androids. They may also be called upon for any cybernetic prosthetics required by the crew."

//Engineering

/datum/job/engineer
	skill_points = 32
	min_skill = list(	SKILL_CONSTRUCTION	= SKILL_BASIC,
						SKILL_ELECTRICAL	= SKILL_BASIC,
						SKILL_ENGINES		= SKILL_BASIC,
						SKILL_ATMOS			= SKILL_BASIC)
	max_skill = list(	SKILL_CONSTRUCTION	= SKILL_MAX,
						SKILL_ELECTRICAL	= SKILL_MAX,
						SKILL_ENGINES		= SKILL_MAX,
						SKILL_ATMOS			= SKILL_MAX)

/datum/job/engineer/get_description_blurb()
	return "An Engineer is, as a member of the Chief Engineer's team, responsible for the safe and effective operation of the station. They are required to repair, maintain, and properly operate the station's atmospherics, power, and hazard prevention systems."

/datum/job/atmos
	skill_points = 24

//Cargo

/datum/job/qm
	skill_points = 24

/datum/job/qm/get_description_blurb()
	return "The Quartermaster is the senior member of the Supply department and is responsible for handling requests and disbursement of materiel to and from Regional Operations. They are responsible for appropriate authorizations and any necessary Thaler payments to Reg Ops for required materiel. It is also the Quartermaster's responsibility to lead and direct any Mining operations by specifying desired materials."

/datum/job/cargo_tech
	skill_points = 20

/datum/job/cargo_tech/get_description_blurb()
	return "As a Cargo Technician, your role is relatively limited to handling requests and approvals through the Quartermaster for various materiel, as well as ensuring the proper disposal of refuse and recovery of discarded non-refuse."

/datum/job/mining
	skill_points = 20

/datum/job/mining/get_description_blurb()
	return "As a Mining Technician, you are responsible for gathering, processing, and recovery of minerals and materials from the nearby asteroid. This includes hand drill operation, Industrial Drill operation, and, if necessary, Exosuit-based mining operations."

/datum/job/janitor
	skill_points = 20

/datum/job/janitor/get_description_blurb()
	return "As a part of the janitorial staff, you are responsible for keeping the station clean and free from minor hazards and obstructions."

//Civilian

/datum/job/bartender
	skill_points = 20

/datum/job/bartender/get_description_blurb()
	return "As the Bartender, you are responsible for the comfort and happiness of the crew during relaxation downtime. A proper Bartender should appropriately disburse a reasonable amount of alcoholic (or non-alcoholic) beverages to crew that request it, but not do so to a degree that would impair said crew's productivity."

/datum/job/chef
	skill_points = 24

/datum/job/chef/get_description_blurb()
	return "The chef is responsible for preparing meals that are more nutritious and enjoyable than the vending snacks supplied around the station. To do so, they should work closely with the agricultural staff to generate the required ingredients for their desired dishes."

/datum/job/hydro
	skill_points = 24

/datum/job/hydro/get_description_blurb()
	return "As a part of the Agricultural Staff, you are expected to sustainably grow foodstuffs and ingredients for the chef to prepare meals with."

/datum/job/librarian
	skill_points = 24

/datum/job/lawyer
	skill_points = 48
	alt_titles = list("Corporate Investigator","Regional Operations Agent")
	min_skill = list(	SKILL_BUREAUCRACY	= SKILL_ADEPT,
						SKILL_FINANCE		= SKILL_ADEPT,
						SKILL_FORENSICS		= SKILL_BASIC,
						SKILL_WEAPONS		= SKILL_BASIC,
						SKILL_COMBAT		= SKILL_BASIC)
	min_skill = list(	SKILL_FORENSICS		= SKILL_MAX,
						SKILL_WEAPONS		= SKILL_MAX,
						SKILL_COMBAT		= SKILL_MAX)

/datum/job/lawyer/get_description_blurb()
	return "The Internal Affairs Agent is a crucial and important role aboard the station. You report to no one, and you are responsible for no one. Instead, you are NanoTrasen's direct line for the expression and retention of corporate interests aboard the station. Your duty is primarily to observe and advise based on Corporate Regulations and Standard Operating Procedures. If general crew display subversive, illegal, or otherwise anti-productive tendencies, these crew should be promptly reported to Head Staff. Should Head Staff display these tendencies, you should promptly report them to Regional Operations and await further instructions. You are not permitted to take Corporate Regulation nor UEE Law into your own hands."

/datum/job/assistant
	skill_points = 24

/datum/job/assistant/get_description_blurb()
	return "You are literally nobody. And everybody. Sometimes, more experienced crewmembers just need a helping hand. This is where you come in. As an assistant, your first stop should be the Operations Director's office for assignment. Failing that, simply make yourself present in common spaces and pay attention to radio communications and offer your services where you feel you may be of assistance. Everyone has to start somewhere, and with NanoTrasen, your Future(tm) is a Bright One(tm)!"