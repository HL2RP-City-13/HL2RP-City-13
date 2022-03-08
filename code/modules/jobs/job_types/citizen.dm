/datum/job/citizen
	title = JOB_CITIZEN
	description = "Survive, serve the Universal Union."
	department_head = list(JOB_ADMIN)
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 1
	supervisors = "the civil protection"
	selection_color = "#329cff"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/citizen

	display_order = JOB_DISPLAY_ORDER_CITIZEN
	departments_list = list(
		/datum/job_department/command,
		)

	job_flags = JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/outfit/job/citizen
	name = "Citizen"
	jobtype = /datum/job/citizen

	id_trim = /datum/id_trim/job/assistant
	uniform = /obj/item/clothing/under/mpfuniform
