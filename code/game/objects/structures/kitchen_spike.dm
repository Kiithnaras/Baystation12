//////Kitchen Spike

/obj/structure/kitchenspike
	name = "meat spike"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spike"
	desc = "A spike for collecting meat from animals."
	density = 1
	anchored = 1
	var/meat = 0
	var/occupied
	var/meat_type
	var/victim_name = "corpse"

/obj/structure/kitchenspike/attackby(obj/item/grab/G, mob/living/carbon/human/user)
	if(!istype(G) || !G.affecting)
		return
	if(!G.force_danger())
		to_chat(user, "<span class = 'notice'>You need a stronger grip to do that.</span>")
		return
	if(occupied)
		to_chat(user, "<span class = 'danger'>The spike already has something on it, finish collecting its meat first!</span>")
	else
		if(do_after(user,30,src) && G.affecting.Adjacent(src))
			if(spike(G.affecting))
				visible_message("<span class = 'danger'>[user] has forced \the [G.affecting] onto the spike, killing them instantly!</span>")
				qdel(G.affecting)
				qdel(G)
			else
				to_chat(user, "<span class='danger'>They are too big for the spike, try something smaller!</span>")

/obj/structure/kitchenspike/MouseDrop_T(mob/target, mob/user)
	if(user.stat || user.restrained())
		return
	if(!target.Adjacent(src))
		to_chat(user, "<span class = 'notice'>Your target must be next to the spike to do this</span>")
		return
	user.visible_message("<span class = 'warning'>\The [user] begins forcing \the [target] onto \the [src]!</span>",\
		"<span class = 'notice'>You begin forcing \the [target] onto \the [src]!</span>")
	if(do_after(user,60,target) && target.Adjacent(src))
		if(spike(target))
			visible_message("<span class = 'danger'>[user] has forced \the [target] onto the spike, killing them instantly!</span>")
			qdel(target)
		else
			to_chat(user, "<span class='danger>They just don't seem to fit on \the [src]. Try something else!</span>")

/obj/structure/kitchenspike/proc/spike(var/mob/living/victim)

	if(!istype(victim))
		return

	if(istype(victim, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = victim
		if(!issmall(H))
			return 0
		meat_type = H.species.meat_type
		icon_state = "spikebloody"
	else if(istype(victim, /mob/living/carbon/alien))
		meat_type = /obj/item/weapon/reagent_containers/food/snacks/xenomeat
		icon_state = "spikebloodygreen"
	else if(istype(victim, /mob/living/simple_animal))
		var/mob/living/simple_animal/SA = victim
		meat_type = SA.meat_type
		icon_state = "spikebloody"
	else
		return 0

	victim_name = victim.name
	occupied = 1
	meat = 5
	return 1

/obj/structure/kitchenspike/attack_hand(mob/user as mob)
	if(..() || !occupied)
		return
	meat--
	new meat_type(get_turf(src))
	if(src.meat > 1)
		to_chat(user, "You remove some meat from \the [victim_name].")
	else if(src.meat == 1)
		to_chat(user, "You remove the last piece of meat from \the [victim_name]!")
		icon_state = "spike"
		occupied = 0
