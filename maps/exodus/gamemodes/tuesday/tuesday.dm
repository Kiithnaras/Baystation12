/datum/game_mode/tuesday
	name = "Tuesday"
	round_description = "For you, this is just a day like any other...or it could be the single most important day of your life."
	extended_round_description = "Extended with various automatic antagonist elements added. Not as insane as Calamity, but allows for most simple antagonist types to generate automatically or on late join. Relaxed start requirements, designed for smaller populations, and easily scalable. It might just be the perfect gamemode. Then again, it might just be another Tuesday..."
	config_tag = "tuesday"
	required_players = 0
	required_enemies = 0
	end_on_antag_death = 0
	round_autoantag = TRUE
	antag_tags = list(MODE_TRAITOR, MODE_RENEGADE, MODE_CHANGELING, MODE_XENOMORPH, MODE_NINJA, MODE_WIZARD)
	antag_scaling_coeff = 4
	latejoin_antag_tags = list(MODE_TRAITOR, MODE_RENEGADE, MODE_CHANGELING, MODE_XENOMORPH, MODE_NINJA, MODE_WIZARD)

//Don't try to spawn any antags initially on Tuesday
/datum/game_mode/tuesday/pre_setup()
	. = ..()
	for(var/datum/antagonist/antag in antag_templates)
		antag.initial_spawn_target = 0