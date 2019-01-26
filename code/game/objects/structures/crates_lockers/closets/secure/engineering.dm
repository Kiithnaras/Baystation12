/obj/structure/closet/secure_closet/engineering_chief
	name = "chief engineer's locker"
	closet_appearance = /decl/closet_appearance/secure_closet/engineering/ce
	req_access = list(access_ce)

/obj/structure/closet/secure_closet/engineering_chief/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/clothing/accessory/storage/brown_vest = 70, /obj/item/clothing/accessory/storage/webbing = 30)),
		new/datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/industrial, /obj/item/weapon/storage/backpack/satchel/eng)),
		new/datum/atom_creator/simple(/obj/item/weapon/storage/backpack/dufflebag/eng, 50),
		/obj/item/blueprints,
		/obj/item/clothing/under/rank/chief_engineer,
		/obj/item/clothing/head/hardhat/white,
		/obj/item/clothing/head/welding,
		/obj/item/clothing/gloves/insulated,
		/obj/item/clothing/shoes/brown,
		/obj/item/device/radio/headset/heads/ce,
		/obj/item/weapon/storage/toolbox/mechanical,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/mask/gas,
		/obj/item/device/multitool,
		/obj/item/device/flash,
		/obj/item/taperoll/engineering,
		/obj/item/weapon/crowbar/brace_jack
	)

/obj/structure/closet/secure_closet/engineering_electrical
	name = "electrical supplies"
	req_access = list(access_engine_equip)
	closet_appearance = /decl/closet_appearance/secure_closet/engineering/electrical

/obj/structure/closet/secure_closet/engineering_electrical/WillContain()
	return list(
		/obj/item/clothing/gloves/nabber = 2,
		/obj/item/clothing/gloves/insulated = 3,
		/obj/item/weapon/storage/toolbox/electrical = 3,
		/obj/item/weapon/module/power_control = 3,
		/obj/item/device/multitool = 3
	)

/obj/structure/closet/secure_closet/engineering_welding
	name = "welding supplies"
	req_access = list(access_construction)
	closet_appearance = /decl/closet_appearance/secure_closet/engineering/welding

/obj/structure/closet/secure_closet/engineering_welding/WillContain()
	return list(
		/obj/item/clothing/head/welding = 3,
		/obj/item/weapon/weldingtool/largetank = 3,
		/obj/item/weapon/weldpack = 3,
		/obj/item/clothing/glasses/welding = 3,
		/obj/item/weapon/welder_tank = 6
	)

/obj/structure/closet/secure_closet/engineering_personal
	name = "engineer's locker"
	req_access = list(access_engine_equip)
	closet_appearance = /decl/closet_appearance/secure_closet/engineering

/obj/structure/closet/secure_closet/engineering_personal/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/clothing/accessory/storage/brown_vest = 70, /obj/item/clothing/accessory/storage/webbing = 30)),
		new/datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/industrial, /obj/item/weapon/storage/backpack/satchel/eng)),
		new/datum/atom_creator/simple(/obj/item/weapon/storage/backpack/dufflebag/eng, 50),
		/obj/item/weapon/storage/toolbox/mechanical,
		/obj/item/device/radio/headset/headset_eng,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/mask/gas,
		/obj/item/clothing/glasses/meson,
		/obj/item/taperoll/engineering
	)

/obj/structure/closet/secure_closet/atmos_personal
	name = "technician's locker"
	req_access = list(access_atmospherics)
	closet_appearance = /decl/closet_appearance/secure_closet/engineering/atmos

/obj/structure/closet/secure_closet/atmos_personal/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/clothing/accessory/storage/brown_vest = 70, /obj/item/clothing/accessory/storage/webbing = 30)),
		new/datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/industrial, /obj/item/weapon/storage/backpack/satchel/eng)),
		new/datum/atom_creator/simple(/obj/item/weapon/storage/backpack/dufflebag/eng, 50),
		/obj/item/clothing/suit/fire/firefighter,
		/obj/item/device/flashlight,
		/obj/item/weapon/extinguisher,
		/obj/item/device/radio/headset/headset_eng,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/mask/gas,
		/obj/item/taperoll/atmos
	)

/obj/structure/closet/secure_closet/voxatmos
	name = "Vox replacement internals"
	req_access = null
	closet_appearance = /decl/closet_appearance/secure_closet

/obj/structure/closet/secure_closet/voxatmos/WillContain()
	return list(
        /obj/item/clothing/mask/gas/vox = 4,
        /obj/item/weapon/tank/emergency/nitrogen = 4,
        /obj/item/weapon/tank/emergency/nitrogen/double = 2,
	)


/obj/structure/closet/secure_closet/voxengieva
	name = "Vox Engineering EVA Closet"
	req_access = list(access_eva)
	closet_appearance = /decl/closet_appearance/secure_closet/engineering/atmos

/obj/structure/closet/secure_closet/voxengieva/WillContain()
	return list(
		/obj/item/clothing/suit/space/vox/stealth = 3,
		/obj/item/clothing/head/helmet/space/vox/stealth = 3,
		/obj/item/weapon/tank/nitrogen = 3,
		/obj/item/clothing/shoes/magboots/vox = 3,
		/obj/item/clothing/gloves/vox = 3,
	)

/obj/structure/closet/secure_closet/voxsecarmor
	name = "Vox Security Body Armor Closet"
	req_access = list(access_eva,access_security)
	closet_appearance = /decl/closet_appearance/secure_closet/security

/obj/structure/closet/secure_closet/voxsecarmor/WillContain()
	return list(
		/obj/item/clothing/suit/space/vox/carapace = 3,
		/obj/item/clothing/head/helmet/space/vox/carapace = 3,
		/obj/item/weapon/tank/nitrogen = 3,
		/obj/item/clothing/shoes/magboots/vox = 3,
		/obj/item/clothing/gloves/vox = 3,
	)

