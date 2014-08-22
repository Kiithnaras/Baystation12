/mob/living/carbon/alien/humanoid/queen
	name = "alien queen"
	caste = "q"
	maxHealth = 250
	health = 250
	icon_state = "alienq_s"
	status_flags = CANPARALYSE
	heal_rate = 5
	plasma_rate = 20


/mob/living/carbon/alien/humanoid/queen/New()
	var/datum/reagents/R = new/datum/reagents(100)
	reagents = R
	R.my_atom = src

	//there should only be one queen
	for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
		if(Q == src)		continue
		if(Q.stat == DEAD)	continue
		if(Q.client)
			name = "alien princess ([rand(1, 999)])"	//if this is too cutesy feel free to change it/remove it.
			break

	real_name = src.name
	verbs.Add(/mob/living/carbon/alien/humanoid/proc/corrosive_acid,/mob/living/carbon/alien/humanoid/proc/neurotoxin,/mob/living/carbon/alien/humanoid/proc/resin)
	verbs -= /mob/living/carbon/alien/verb/ventcrawl
	..()


/mob/living/carbon/alien/humanoid/queen

	handle_regular_hud_updates()

		..() //-Yvarov

		if (src.healths)
			if (src.stat != 2)
				switch(health)
					if(250 to INFINITY)
						src.healths.icon_state = "health0"
					if(175 to 250)
						src.healths.icon_state = "health1"
					if(100 to 175)
						src.healths.icon_state = "health2"
					if(50 to 100)
						src.healths.icon_state = "health3"
					if(0 to 50)
						src.healths.icon_state = "health4"
					else
						src.healths.icon_state = "health5"
			else
				src.healths.icon_state = "health6"


//Queen verbs
/mob/living/carbon/alien/humanoid/queen/verb/lay_egg()

	set name = "Lay Egg (75)"
	set desc = "Lay an egg to produce huggers to impregnate prey with."
	set category = "Alien"

	if(locate(/obj/effect/alien/egg) in get_turf(src))
		src << "There's already an egg here."
		return

	if(powerc(75,1))//Can't plant eggs on spess tiles. That's silly.
		src.visible_message("[src] squats and starts to contort!","\green You squat and begin begin laying an egg!")
		if(do_after(src,60))
			if(locate(/obj/effect/alien/egg) in get_turf(src))
				src << "There's already an egg here."
				return
			adjustToxLoss(-75)
			src.visible_message("[src] has planted a large, purplish egg-like object on the ground.","\green You have planted an egg.")
			new /obj/effect/alien/egg(loc)
		return


/mob/living/carbon/alien/humanoid/queen/verb/evolve()

	set name = "Evolve (500)"
	set desc = "Evolve into an Empress! You must have at least 6 servants to support the strain, however."
	set category = "Alien"

	if(src.has_brain_worms())
		src << "<span class='warning'>We cannot perform this ability at the present time!</span>"
		return

	var/aliencount = 0
	for(var/mob/living/carbon/alien/humanoid/GG in living_mob_list)
		if(!GG.key && GG.brain_op_stage != 4) continue  //Don't include playerless aliens!
		if(istype(GG, /mob/living/carbon/alien/humanoid/queen/large))
			src << "\green There is already an empress! There can be only one!" //cancel proc if there's already an empress!
			return
		if(GG == src) continue //Don't include yourself!
		aliencount += 1

	if(aliencount >= 6)
		src.visible_message("[src] curls up and begins to vibrate slightly!","\green <B>You begin to evolve! Stay still and be patient!</B>")
		if(do_after(src,120))
			adjustToxLoss(-100)
			src.visible_message("[src] ceases to vibrate and appears to harden!","\green The evolution progresses...you can no longer move!")
			src.anchored = 1
			src.update_canmove()
			src.maxHealth += 250
			src.health += 250
			src.heal_rate += 5
			if(do_after(src,120))
				adjustToxLoss(-100)
				src.visible_message("[src] grows steadily and appears to strain the confines of its hardened exterior!","\green You feel stronger...it won't be long now!")
				src.maxHealth += 500
				src.health += 500
				src.heal_rate += 5
				if(do_after(src,120))
					adjustToxLoss(-300)
					src.visible_message("<B>[src] explodes violently and rears up as a newly-risen giant alien creature!</B>","\green <B>Your evolution is complete!</B>")
					src.say(":a Rejoice, childen! Your new empress has arisen!")
					var/mob/living/carbon/alien/humanoid/queen/large/new_empress = new (loc)
					mind.transfer_to(new_empress)
					playsound(src,'sound/voice/hiss5.ogg',150,1)
					gib(src)
	else
		src << "\green There are not enough servants to support your transformation!"
		return


/mob/living/carbon/alien/humanoid/queen/large
	name = "alien empress"
	icon = 'icons/mob/alienqueen.dmi'
	icon_state = "queen_s"
	pixel_x = -16
	maxHealth = 600
	health = 600
	heal_rate = 10
	plasma_rate = 30
	storedPlasma = 750
	max_plasma = 1000

	handle_regular_hud_updates()

		..() //-Yvarov

		if (src.healths)
			if (src.stat != 2)
				switch(health)
					if(600 to INFINITY)
						src.healths.icon_state = "health0"
					if(450 to 600)
						src.healths.icon_state = "health1"
					if(300 to 450)
						src.healths.icon_state = "health2"
					if(150 to 300)
						src.healths.icon_state = "health3"
					if(0 to 150)
						src.healths.icon_state = "health4"
					else
						src.healths.icon_state = "health5"
			else
				src.healths.icon_state = "health6"

/mob/living/carbon/alien/humanoid/queen/large/update_icons()
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again
	update_hud()		//TODO: remove the need for this to be here
	overlays.Cut()
	if(lying)
		if(resting)					icon_state = "queen_sleep"
		else						icon_state = "queen_l"
		for(var/image/I in overlays_lying)
			overlays += I
	else
		icon_state = "queen_s"
		for(var/image/I in overlays_standing)
			overlays += I