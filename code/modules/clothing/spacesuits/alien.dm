//Skrell space gear. Sleek like a wetsuit.
/obj/item/clothing/head/helmet/space/skrell
	name = "Skrellian helmet"
	desc = "Smoothly contoured and polished to a shine. Still looks like a fishbowl."
	armor = list(melee = 20, bullet = 20, laser = 50,energy = 50, bomb = 50, bio = 100, rad = 100)
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list("Skrell","Human")

/obj/item/clothing/head/helmet/space/skrell/white
	icon_state = "skrell_helmet_white"
	item_state = "skrell_helmet_white"
	item_color = "skrell_helmet_white"

/obj/item/clothing/head/helmet/space/skrell/black
	icon_state = "skrell_helmet_black"
	item_state = "skrell_helmet_black"
	item_color = "skrell_helmet_black"

/obj/item/clothing/suit/space/skrell
	name = "Skrellian voidsuit"
	desc = "Seems like a wetsuit with reinforced plating seamlessly attached to it. Very chic."
	armor = list(melee = 20, bullet = 20, laser = 50,energy = 50, bomb = 50, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list("Skrell","Human")

/obj/item/clothing/suit/space/skrell/white
	icon_state = "skrell_suit_white"
	item_state = "skrell_suit_white"
	item_color = "skrell_suit_white"

/obj/item/clothing/suit/space/skrell/black
	icon_state = "skrell_suit_black"
	item_state = "skrell_suit_black"
	item_color = "skrell_suit_black"

// Vox space gear (vaccuum suit, low pressure armour)
// Can't be equipped by any other species due to bone structure and vox cybernetics.
/obj/item/clothing/suit/space/vox
	w_class = 3
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank)
	slowdown = 2
	armor = list(melee = 50, bullet = 35, laser = 30, energy = 15, bomb = 30, bio = 100, rad = 50)
	siemens_coefficient = 0.6
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list("Vox")
	sprite_sheets = list("Vox" = 'icons/mob/species/vox/suit.dmi')

/obj/item/clothing/head/helmet/space/vox
	armor = list(melee = 50, bullet = 35, laser = 30, energy = 15, bomb = 30, bio = 100, rad = 50)
	siemens_coefficient = 0.6
	flags = HEADCOVERSEYES|STOPPRESSUREDAMAGE
	species_restricted = list("Vox")
	sprite_sheets = list("Vox" = 'icons/mob/species/vox/head.dmi')

/obj/item/clothing/head/helmet/space/vox/pressure
	name = "alien helmet"
	icon_state = "vox-pressure"
	item_state = "vox-pressure"
	desc = "Hey, wasn't this a prop in \'The Abyss\'?"
	armor = list(melee = 40, bullet = 35, laser = 30, energy = 15, bomb = 30, bio = 100, rad = 100)

/obj/item/clothing/suit/space/vox/pressure
	name = "alien pressure suit"
	icon_state = "vox-pressure"
	item_state = "vox-pressure"
	desc = "A huge, armoured, pressurized suit, designed for distinctly nonhuman proportions. Appears to be well-shielded and air-tight."
	armor = list(melee = 40, bullet = 35, laser = 30, energy = 15, bomb = 30, bio = 100, rad = 100)
	breach_threshold = 10

/obj/item/clothing/head/helmet/space/vox/carapace
	name = "alien visor"
	icon_state = "vox-carapace"
	item_state = "vox-carapace"
	desc = "A glowing visor, perhaps stolen from a depressed Cylon."
	armor = list(melee = 75, bullet = 65, laser = 60, energy = 30, bomb = 60, bio = 75, rad = 75)

/obj/item/clothing/suit/space/vox/carapace
	name = "alien carapace armour"
	icon_state = "vox-carapace"
	item_state = "vox-carapace"
	desc = "An armoured, segmented carapace with glowing purple lights. It looks pretty run-down, but still sports decent protection."
	armor = list(melee = 75, bullet = 65, laser = 60, energy = 30, bomb = 60, bio = 75, rad = 75)
	breach_threshold = 25
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/head/helmet/space/vox/stealth
	name = "alien stealth helmet"
	icon_state = "vox-stealth"
	item_state = "vox-stealth"
	desc = "A smoothly contoured, matte-black alien helmet."
	armor = list(melee = 60, bullet = 55, laser = 50, energy = 25, bomb = 50, bio = 75, rad = 100)
	max_heat_protection_temperature = 25000

/obj/item/clothing/suit/space/vox/stealth
	name = "alien stealth suit"
	icon_state = "vox-stealth"
	item_state = "vox-stealth"
	desc = "A sleek black suit. It seems to have a tail, and is rather light and mobile-looking while appearing to have decent protection in the right places."
	slowdown = 0
	armor = list(melee = 60, bullet = 55, laser = 50, energy = 25, bomb = 50, bio = 75, rad = 100)
	max_heat_protection_temperature = 25000
	breach_threshold = 20

/obj/item/clothing/head/helmet/space/vox/medic
	name = "alien goggled helmet"
	icon_state = "vox-medic"
	item_state = "vox-medic"
	desc = "An alien helmet with enormous goggled lenses."
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 20, bomb = 40, bio = 100, rad = 75)

/obj/item/clothing/suit/space/vox/medic
	name = "alien armour"
	icon_state = "vox-medic"
	item_state = "vox-medic"
	desc = "An almost organic looking nonhuman pressure suit. It appears to be well-suited for toxic environments and has increased mobility."
	slowdown = 1
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 20, bomb = 40, bio = 100, rad = 75)
	breach_threshold = 15

/obj/item/clothing/under/vox
	has_sensor = 0
	species_restricted = list("Vox")

/obj/item/clothing/under/vox/vox_casual
	name = "alien clothing"
	desc = "This doesn't look very comfortable."
	icon_state = "vox-casual-1"
	item_color = "vox-casual-1"
	item_state = "vox-casual-1"
	body_parts_covered = LEGS

/obj/item/clothing/under/vox/vox_robes
	name = "alien robes"
	desc = "Weird and flowing!"
	icon_state = "vox-casual-2"
	item_color = "vox-casual-2"
	item_state = "vox-casual-2"

/obj/item/clothing/gloves/yellow/vox
	desc = "These bizarre gauntlets seem to be fitted for... bird claws?"
	name = "insulated gauntlets"
	icon_state = "gloves-vox"
	item_state = "gloves-vox"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	item_color = "gloves-vox"
	species_restricted = list("Vox")
	sprite_sheets = list("Vox" = 'icons/mob/species/vox/gloves.dmi')
/obj/item/clothing/shoes/magboots/vox

	desc = "A pair of heavy, jagged armoured foot pieces, seemingly suitable for a velociraptor."
	name = "vox magclaws"
	item_state = "boots-vox"
	icon_state = "boots-vox"
	species_restricted = list("Vox")

	action_button_name = "Toggle the magclaws"

/obj/item/clothing/shoes/magboots/vox/attack_self(mob/user)
	if(src.magpulse)
		flags &= ~NOSLIP
		magpulse = 0
		canremove = 1
		user << "You relax your deathgrip on the flooring."
	else
		//make sure these can only be used when equipped.
		if(!ishuman(user))
			return
		var/mob/living/carbon/human/H = user
		if (H.shoes != src)
			user << "You will have to put on the [src] before you can do that."
			return


		flags |= NOSLIP
		magpulse = 1
		canremove = 0	//kinda hard to take off magclaws when you are gripping them tightly.
		user << "You dig your claws deeply into the flooring, bracing yourself."
		user << "It would be hard to take off the [src] without relaxing your grip first."

//In case they somehow come off while enabled.
/obj/item/clothing/shoes/magboots/vox/dropped(mob/user as mob)
	..()
	if(src.magpulse)
		user.visible_message("The [src] go limp as they are removed from [usr]'s feet.", "The [src] go limp as they are removed from your feet.")
		flags &= ~NOSLIP
		magpulse = 0
		canremove = 1

/obj/item/clothing/shoes/magboots/vox/examine(mob/user)
	..(user)
	if (magpulse)
		user << "It would be hard to take these off without relaxing your grip first." //theoretically this message should only be seen by the wearer when the claws are equipped.
