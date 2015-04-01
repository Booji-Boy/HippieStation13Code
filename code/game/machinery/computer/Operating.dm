/obj/machinery/computer/operating
	name = "operating computer"
	desc = "Used to monitor the vitals of a patient during surgery."
	icon_state = "operating"
	density = 1
	anchored = 1.0
	circuit = /obj/item/weapon/circuitboard/operating
	var/mob/living/carbon/human/patient = null
	var/obj/structure/optable/table = null


/obj/machinery/computer/operating/New()
	..()
	if(ticker)
		find_table()

/obj/machinery/computer/operating/initialize()
	find_table()

/obj/machinery/computer/operating/proc/find_table()
	for(var/dir in cardinal)
		table = locate(/obj/structure/optable, get_step(src, dir))
		if(table)
			table.computer = src
			break


/obj/machinery/computer/operating/attack_hand(mob/user)
	if(..())
		return
	interact(user)

/obj/machinery/computer/operating/interact(mob/user)
	var/dat = ""
	if(table)
		dat += "<B>Patient information:</B><BR>"
		if(table.check_patient())
			patient = table.patient
			dat += get_patient_info()
		else
			patient = null
			dat += "<B>No patient detected</B>"
	else
		dat += "<B>Operating table not found.</B>"

	var/datum/browser/popup = new(user, "op", "Operating Computer", 400, 500)
	popup.set_content(dat)
	popup.open()

/obj/machinery/computer/operating/proc/get_patient_info()
	var/dat = {"
				<div class='statusLabel'>Patient:</div> [patient.stat ? "<span class='bad'>Non-Responsive</span>" : "<span class='good'>Stable</span>"]<BR>
				<div class='statusLabel'>Blood Type:</div> [patient.blood_type]

				<BR>
				<div class='line'><div class='statusLabel'>Health:</div><div class='progressBar'><div style='width: [max(patient.health, 0)]%;' class='progressFill good'></div></div><div class='statusValue'>[patient.health]%</div></div>
				<div class='line'><div class='statusLabel'>\> Brute Damage:</div><div class='progressBar'><div style='width: [max(patient.getBruteLoss(), 0)]%;' class='progressFill bad'></div></div><div class='statusValue'>[patient.getBruteLoss()]%</div></div>
				<div class='line'><div class='statusLabel'>\> Resp. Damage:</div><div class='progressBar'><div style='width: [max(patient.getOxyLoss(), 0)]%;' class='progressFill bad'></div></div><div class='statusValue'>[patient.getOxyLoss()]%</div></div>
				<div class='line'><div class='statusLabel'>\> Toxin Content:</div><div class='progressBar'><div style='width: [max(patient.getToxLoss(), 0)]%;' class='progressFill bad'></div></div><div class='statusValue'>[patient.getToxLoss()]%</div></div>
				<div class='line'><div class='statusLabel'>\> Burn Severity:</div><div class='progressBar'><div style='width: [max(patient.getFireLoss(), 0)]%;' class='progressFill bad'></div></div><div class='statusValue'>[patient.getFireLoss()]%</div></div>
				<div class='line'><div class='statusLabel'>\> Bloodloss Severity:</div><div class='progressBar'><div style='width: [max(round(patient.getBloodLoss(1)), 0)]%;' class='progressFill bad'></div></div><div class='statusValue'>[round(patient.getBloodLoss(1))]%</div></div>

				"}
	if(patient.surgeries.len)
		dat += "<BR><B>Initiated Procedures</B><div class='statusDisplay'>"
		for(var/datum/surgery/procedure in patient.surgeries)
			dat += "[capitalize(procedure.name)]<BR>"
			dat += "   current step: [procedure.status]<BR>"
			dat += "   targeted limb: [procedure.location]<BR>"
		dat += "</div>"
	return dat