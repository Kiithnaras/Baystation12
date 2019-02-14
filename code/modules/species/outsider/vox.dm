/datum/species/vox
	name = SPECIES_VOX
	name_plural = SPECIES_VOX
	icobase = 'icons/mob/human_races/species/vox/body.dmi'
	deform = 'icons/mob/human_races/species/vox/body.dmi'
	husk_icon = 'icons/mob/human_races/species/vox/husk.dmi'
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick,  /datum/unarmed_attack/claws/strong, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite/strong)
	rarity_value = 4
	description = "The Vox are a secretive and technologically-powerful race, though it may not seem such at \
	first glance. They often prey upon isolated outposts, ships, or planets to scavenge technology and resources \
	from others. They are four to five feet tall, reptillian, beaked, tailed and quilled; human crews often have \
	referred to them as 'shitbirds' for their violent and offensive nature, as well as their unpleasant \
	odor.<br/><br/>Most humans will never meet a Vox raider, instead learning of this insular species through \
	dealing with their traders and merchants; those that do rarely enjoy the experience."
	codex_description = "The Vox are a species from the edges of human space. They prey on isolated stations, ships, \
	or planets without any apparent logic or reason and often refuse communications or negotiations except \
	in desperation. They are four to five feet tall, reptillian, beaked, tailed and quilled. Many scientific studies \
	on the Vox have conjectured that they are not an evolved race but an engineered one, serving a purpose akin \
	to the workers of a bee colony. They are substantially tough, fast, strong, and well-adapted to the rigors of \
	space. Their use of Nitrogen for respiration - and the toxicity of Oxygen to their physiology - suggests \
	a strong potential for immortality.<br/><br/>Many Human and crews refer \
	to them as 'shitbirds' for their violent and offensive tendencies as well as their unpleasant odor. This practice \
	is highly frowned-upon, however, as Vox are quick to take offense and seldom pleasant in the face of disrespect. Not \
	all Vox are created equal, though, as some can be quite cordial and pragmatic. One such Arkship has gone \
	so far as to exchange the labor, knowledge, and skills of its Vox for technology and materials. As such,\
	all Vox should be treated with a cautious respect until circumstances reveal their intentions. Failure to do so \
	may result in civil or criminal penalties subject to Sol Government Code 14524 subsection 42B through Q.<br/><br/>\
	While Vox may be employed in nearly any position on a Nanotrasen facility, certain restrictions exist. First, any \
	Vox employee must have their suit sensors at maximum at all times, regardless of alert levels. Second, any Vox in \
	a Department Head or Command position must receive and maintain a Loyalty Implant. Vox transferring to a Nanotrasen \
	facility from Regional Operations will be checked for and receive a Loyalty Implant if necessary, while any Vox \
	elevated to a Command-level position will require one to be supplied <i>in situ</i>. Any Vox employee violating \
	either of these conditions is to be confined immediately, fined, and have any deficiencies corrected."
	hidden_from_codex = FALSE

	taste_sensitivity = TASTE_DULL
	speech_sounds = list('sound/voice/shriek1.ogg')
	speech_chance = 33

	brute_mod = 0.75
	burn_mod = 0.75

	warning_low_pressure = 50
	hazard_low_pressure = 0

	cold_level_1 = 80
	cold_level_2 = 50
	cold_level_3 = 0

	heat_level_1 = 500
	heat_level_2 = 800
	heat_level_3 = 1550

	darksight_range = 4
	darksight_tint = DARKTINT_GOOD

	slowdown = -1

	gluttonous = GLUT_TINY|GLUT_ITEM_NORMAL
	stomach_capacity = 12

	breath_type = "nitrogen"
	poison_types = list("oxygen" = TRUE,"phoron" = TRUE, "chlorine" = TRUE)
	exhale_type = "ammonia"
	siemens_coefficient = 0.2

	species_flags = SPECIES_FLAG_NO_SCAN
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_NO_FBP_CONSTRUCTION
	appearance_flags = HAS_EYE_COLOR | HAS_HAIR_COLOR

	blood_color = "#2299fc"
	flesh_color = "#808d11"
	default_hair_color = "#3f2413"

	min_age = 10
	max_age = 1000

	strength = STR_HIGH

	reagent_tag = IS_VOX

	inherent_verbs = list(
		/mob/living/carbon/human/proc/leap
		)

	override_limb_types = list(
		BP_GROIN = /obj/item/organ/external/groin/vox,
		BP_HEAD = /obj/item/organ/external/head/vox
		)

	has_organ = list(
		BP_STOMACH =  /obj/item/organ/internal/stomach,
		BP_HEART =    /obj/item/organ/internal/heart/vox,
		BP_LUNGS =    /obj/item/organ/internal/lungs/vox,
		BP_LIVER =    /obj/item/organ/internal/liver/vox,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys/vox,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_EYES =     /obj/item/organ/internal/eyes,
		BP_STACK =    /obj/item/organ/internal/stack/vox
		)

	genders = list(NEUTER)
	descriptors = list(
		/datum/mob_descriptor/height = -1,
		/datum/mob_descriptor/build = 1,
		/datum/mob_descriptor/vox_markings = 0
		)

	available_cultural_info = list(
		TAG_CULTURE =   list(
			CULTURE_VOX_ARKSHIP,
			CULTURE_VOX_SALVAGER,
			CULTURE_VOX_RAIDER
		),
		TAG_HOMEWORLD = list(
			HOME_SYSTEM_VOX_ARK,
			HOME_SYSTEM_VOX_SHROUD,
			HOME_SYSTEM_VOX_SHIP
		),
		TAG_FACTION = list(
			FACTION_VOX_RAIDER,
			FACTION_VOX_CREW,
			FACTION_VOX_APEX
		),
		TAG_RELIGION =  list(
			RELIGION_VOX
		)
	)

/datum/species/vox/equip_survival_gear(var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/vox(H), slot_wear_mask)

	if(istype(H.get_equipped_item(slot_back), /obj/item/weapon/storage/backpack))
		H.equip_to_slot_or_del(new /obj/item/weapon/tank/emergency/nitrogen/double(H), slot_r_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/vox(H.back), slot_in_backpack)
//		H.internal = H.r_hand
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/tank/emergency/nitrogen/double(H), slot_back)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/vox(H), slot_r_hand)
//		H.internal = H.back

//	if(H.internals)
//		H.internals.icon_state = "internal1"

/datum/species/vox/disfigure_msg(var/mob/living/carbon/human/H)
	var/datum/gender/T = gender_datums[H.get_gender()]
	return "<span class='danger'>[T.His] beak is chipped! [T.He] [T.is] not even recognizable.</span>\n" //Pretty birds.
