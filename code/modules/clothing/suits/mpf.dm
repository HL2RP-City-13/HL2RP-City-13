/obj/item/clothing/head/hooded/mpfsuit
	name = "metropolice helmet"
	desc = "Standard issue Metropolice Force gear."
	icon_state = "mpfsuit-helm"
	armor = list(MELEE = 80, BULLET = 50, LASER = 20, ENERGY = 40, BOMB = 20, BIO = 100, FIRE = 100, ACID = 100)
	strip_delay = 600
	icon = 'icons/obj/clothing/mpf/suits.dmi'
	worn_icon = 'icons/mob/clothing/mpf/suits.dmi'

/obj/item/clothing/suit/hooded/mpfsuit
	name = "metropolice suit"
	desc = "Standard issue Metropolice Force gear."
	icon_state = "mpfsuit"
	inhand_icon_state = "mpfsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list(MELEE = 80, BULLET = 50, LASER = 20, ENERGY = 40, BOMB = 20, BIO = 100, FIRE = 100, ACID = 100)
	hoodtype = /obj/item/clothing/head/hooded/mpfsuit
	strip_delay = 600
	equip_delay_other = 40
	icon = 'icons/obj/clothing/mpf/suits.dmi'
	worn_icon = 'icons/mob/clothing/mpf/suits.dmi'

/obj/item/clothing/suit/hooded/mpfsuit/Initialize(mapload)
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/hooded/mpfsuit/ToggleHood()
	if (hood_up)
		return ..()
	var/mob/living/carbon/user = loc
	var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	ADD_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	hud.add_hud_to(user)
	balloon_alert(user, "<::HUD INITIALIZED.::>")
	return ..()

/obj/item/clothing/suit/hooded/mpfsuit/RemoveHood()
	if (!hood_up)
		return ..()
	var/mob/living/carbon/user = loc
	var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	hud.remove_hud_from(user)
	balloon_alert(user, "<::DISPLAY OFF::>")
	return ..()
