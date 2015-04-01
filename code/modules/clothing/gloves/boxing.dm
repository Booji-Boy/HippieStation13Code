//TODO: Use this function below instead
// // Called just before an attack_hand(), in mob/UnarmedAttack()
// /obj/item/clothing/gloves/proc/Touch(var/atom/A, var/proximity)
// 	return 0 // return 1 to cancel attack_hand()

/obj/item/clothing/gloves/boxing
	name = "boxing gloves"
	desc = "Because you really needed another excuse to punch your crewmates."
	icon_state = "boxing"
	item_state = "boxing"
	put_on_delay = 60
	species_exception = list(/datum/species/golem, /datum/species/golem/adamantine) // now you too can be a golem boxing champion
	staminaDamage = 1
	atk_verb = list("whammed", "knocked", "uppercut", "Hulk Hogan'd", "brought the smackdown on")
	hitsound = list("boxgloves")

/obj/item/clothing/gloves/boxing/green
	icon_state = "boxinggreen"
	item_state = "boxinggreen"

/obj/item/clothing/gloves/boxing/blue
	icon_state = "boxingblue"
	item_state = "boxingblue"

/obj/item/clothing/gloves/boxing/yellow
	icon_state = "boxingyellow"
	item_state = "boxingyellow"
