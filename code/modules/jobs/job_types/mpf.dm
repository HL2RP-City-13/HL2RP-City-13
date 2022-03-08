/datum/job/mpf
	title = JOB_MPF
	description = "Protect. Serve the Universal Union."
	department_head = list(JOB_MPFRL)
	faction = FACTION_STATION
	total_positions = 10
	spawn_positions = 1
	supervisors = "the rank leaders"
	selection_color = "#0400d6"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/citizen

	display_order = JOB_DISPLAY_ORDER_MPF
	departments_list = list(
		/datum/job_department/command,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/outfit/job/mpf
	name = "Civil Protection"
	jobtype = /datum/job/mpf

	id_trim = /datum/id_trim/job/assistant
	uniform = /obj/item/clothing/under/mpfuniform
	suit = /obj/item/clothing/suit/hooded/mpfsuit
