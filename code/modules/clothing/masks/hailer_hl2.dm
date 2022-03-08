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
	phrase_text = "Prepare for Judgement!"
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

//////////
// HAILER
//////////

// Cooldown times
#define PHRASE_COOLDOWN 30
#define OVERUSE_COOLDOWN 180

// List Size
#define COMBINE_LIST_SIZE 7

// All possible hailer phrases
// Remember to modify above index markers if changing contents
GLOBAL_LIST_INIT(combine_hailer_phrases, list(	// I can't count rn cause covid brain c':
	/datum/hailer_phrase/subjectisnowhighspeed	// 0
	/datum/hailer_phrase/malcompverdict			// 1
	/datum/hailer_phrase/prepareforjudgement	// 2
	/datum/hailer_phrase/holditrightthere		// 3
	/datum/hailer_phrase/malcompliant			// 4
	/datum/hailer_phrase/getdown				// 5
	/datum/hailer_phrase/finalwarning			// 6
	/datum/hailer_phrase/dontmove				// 7
))

/obj/item/clothing/mask/gas/sechailer/combine
	name = "combine gas mask"
	desc = "insert funny joke here"
	actions_types = list(/datum/action/item_action/halt)
	icon_state = "sechailer"
	inhand_icon_state = "sechailer"

/obj/item/clothing/mask/gas/sechailer/combine/screwdriver_act(mob/living/user, obj/item/I)
	return // Removing the function of adjusting the aggression.

/obj/item/clothing/mask/gas/sechailer/combine/wirecutter_act(mob/living/user, obj/item/I)
	return // Removing the function of breaking the aggression.

/obj/item/clothing/mask/gas/sechailer/combine/select_phrase()
	return rand(0, COMBINE_LIST_SIZE) // We dont seem to be using aggression so instead just return a random number from the list.

/obj/item/clothing/mask/gas/sechailer/combine/play_phrase(mob/user, datum/hailer_phrase/phrase)
	. = FALSE
	if (!cooldown)
		usr.audible_message("[usr]'s Combine Vocoder: <font color='red' size='4'><b>[initial(phrase.phrase_text)]</b></font>")
		playsound(src, "sound/runtime/complionator/[initial(phrase.phrase_sound)].ogg", 100, FALSE, 4)
		cooldown = TRUE
		addtimer(CALLBACK(src, /obj/item/clothing/mask/gas/sechailer/combine/proc/reset_cooldown), PHRASE_COOLDOWN)
		. = TRUE

#undef PHRASE_COOLDOWN
#undef OVERUSE_COOLDOWN
#undef COMBINE_LIST_SIZE
