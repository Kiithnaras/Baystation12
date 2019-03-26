// Xenomorph limbs.
/obj/item/organ/external/head/unbreakable/xeno
	eye_icon_location = 'icons/mob/human_races/species/xenos/eyes.dmi'
	glowing_eyes = TRUE
	encased = "carapace"
	action_button_name = "Switch Stance" // Basically just a wrapper for switch stance verb, since GAS use it more than normals.

/obj/item/organ/external/head/unbreakable/xeno/refresh_action_button()
	. = ..()
	if(.)
		action.button_icon_state = "xeno-stance-[owner && owner.pulling_punches ? 1 : 0]"
		if(action.button) action.button.UpdateIcon()

/obj/item/organ/external/head/unbreakable/xeno/attack_self(var/mob/user)
	. = ..()
	if(.)
		owner.pull_punches()
		refresh_action_button()

/obj/item/organ/external/chest/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/groin/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/arm/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/arm/right/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/leg/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/leg/right/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/foot/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/foot/right/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/hand/unbreakable/xeno
	encased = "carapace"

/obj/item/organ/external/hand/right/unbreakable/xeno
	encased = "carapace"
