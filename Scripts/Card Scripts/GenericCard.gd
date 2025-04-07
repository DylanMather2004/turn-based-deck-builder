class_name Card
extends Resource
## The Card Class extends Resource and stores a range of stats and details to be used by a card.
## This class can be easily instantiated in a child resource to create multiple card variations.
@export_category("Display Settings")
##[card_name] is the display name of the card that will be seen in game
@export var card_name:String
##{card_art} is the texture for the card to be assigned to [member CardTemplate.sprite]
@export var card_art:Texture2D
@export_category("Stats")

enum CARD_TYPE {ATTACK,HEAL,OVERSHIELD,POISON,CHARGE}
##{card_type} determines the type of card, and the logic that should be used when 
@export var card_type:CARD_TYPE
##[member Card.value] determines the strength of the effect.[br]
##ATTACK: Deals [member Card.value] damage.[br]
##HEAL: Heals [member Card.value] health.[br]
##OVERSHIELD: Provides [member Card.value] overshields.[br]
##POISON: Lasts [member Card.value] turns.[br]
##Charge: grants [member Card.value] bonus charge next turn.
@export var value:int
##{ap_cost} determines the cost to use this card
@export var ap_cost:int
