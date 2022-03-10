//////////
// PHRASES
//////////

/datum/hailer_phrase/malcompverdict
	phrase_text = "You want a malcompliance verdict?!"
	phrase_sound = "malcompverdict"

/datum/hailer_phrase/subjectisnowhighspeed
	phrase_text = "All units be advised, subject is now high speed."
	phrase_sound = "subjectisnowhighspeed"

/datum/hailer_phrase/prepareforjudgement
	phrase_text = "Suspect, prepare to receive Civil Judgement!"
	phrase_sound = "prepareforjudgement"

/datum/hailer_phrase/holditrightthere
	phrase_text = "Hold it right there!"
	phrase_sound = "holditrightthere"

/datum/hailer_phrase/malcompliant
	phrase_text = "Malcompliant 10-107 of my 10-20 preparing to prosecute."
	phrase_sound = "malcompliant"

/datum/hailer_phrase/getdown
	phrase_text = "Get down!"
	phrase_sound = "getdown"

/datum/hailer_phrase/finalwarning
	phrase_text = "Final warning!"
	phrase_sound = "finalwarning"

/datum/hailer_phrase/dontmove
	phrase_text = "Don't move!"
	phrase_sound = "dontmove"

// List Size
#define MPF_LIST_SIZE 8

// All possible hailer phrases
// Remember to modify above index markers if changing contents
GLOBAL_LIST_INIT(mpf_hailer_phrases, list(
	/datum/hailer_phrase/subjectisnowhighspeed,
	/datum/hailer_phrase/malcompverdict,
	/datum/hailer_phrase/prepareforjudgement,
	/datum/hailer_phrase/holditrightthere,
	/datum/hailer_phrase/malcompliant,
	/datum/hailer_phrase/getdown,
	/datum/hailer_phrase/finalwarning,
	/datum/hailer_phrase/dontmove,
))

//////////
// HAILER
//////////

// Cooldown times
#define PHRASE_COOLDOWN 30

/obj/item/clothing/mask/gas/sechailer/mpf
	name = "civil protection officer gas mask"
	desc = "a mask with a vocoder integrated to scare off Citizens."
	icon_state = "mpfsuit-mask"
	actions_types = list(/datum/action/item_action/halt)
	icon = 'icons/obj/clothing/mpf/suits.dmi'
	worn_icon = 'icons/mob/clothing/mpf/mask.dmi'
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH | PEPPERPROOF
	flags_inv = HIDEHAIR
	var/hud_trait = null
	var/hud_type = null
	hud_type = DATA_HUD_SECURITY_ADVANCED
	hud_trait = TRAIT_SECURITY_HUD

/obj/item/clothing/mask/gas/sechailer/mpf/screwdriver_act(mob/living/user, obj/item/I)
	return // Removing the function of adjusting the aggression.

/obj/item/clothing/mask/gas/sechailer/mpf/wirecutter_act(mob/living/user, obj/item/I)
	return // Removing the function of breaking the aggression.

/obj/item/clothing/mask/gas/sechailer/mpf/select_phrase()
	return rand(1, MPF_LIST_SIZE) // We dont seem to be using aggression so instead just return a random number from the list.

/obj/item/clothing/mask/gas/sechailer/mpf/halt()
	set category = "Object"
	set name = "HALT"
	set src in usr
	if(!isliving(usr) || !can_use(usr) || cooldown)
		return

	// select phrase to play
	play_phrase(usr, GLOB.mpf_hailer_phrases[select_phrase()])

/obj/item/clothing/mask/gas/sechailer/mpf/play_phrase(mob/user, datum/hailer_phrase/phrase)
	. = FALSE
	if (!cooldown)
		usr.audible_message("[usr]'s Vocoding Device: <font color='red' size='4'><b>[initial(phrase.phrase_text)]</b></font>")
		playsound(src, "sound/runtime/complionator/[initial(phrase.phrase_sound)].ogg", 100, FALSE, 4)
		cooldown = TRUE
		addtimer(CALLBACK(src, /obj/item/clothing/mask/gas/sechailer/proc/reset_cooldown), PHRASE_COOLDOWN)
		. = TRUE

/obj/item/clothing/mask/gas/sechailer/mpf/equipped(mob/living/carbon/human/user, slot)
	if(slot != ITEM_SLOT_MASK)
		return
	if(hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.add_hud_to(user)
	if(hud_trait)
		ADD_TRAIT(user, hud_trait, GLASSES_TRAIT)
	..()

/obj/item/clothing/mask/gas/sechailer/mpf/dropped(mob/living/carbon/human/user)
	if(!istype(user) || user.wear_mask != src)
		return
	if(hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.remove_hud_from(user)
	if(hud_trait)
		REMOVE_TRAIT(user, hud_trait, GLASSES_TRAIT)
	..()

#undef PHRASE_COOLDOWN
#undef MPF_LIST_SIZE
