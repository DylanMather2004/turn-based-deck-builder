class_name BaseCard
extends Node2D
@export var card_to_load:Card
var name_text:Label
var value_text:RichTextLabel
var ap_text:RichTextLabel
var sprite:Sprite2D
var card_type

func initialize():
	name_text=$NameText
	value_text=$ValueText
	ap_text=$APText
	sprite = $Sprite2D
	name_text.text = card_to_load.card_name
	value_text.text = str(card_to_load.value)
	ap_text.text = str(card_to_load.ap_cost)
	sprite.texture = card_to_load.card_art
	card_type=card_to_load.card_type

##_effect will select the appropriate effect for each card type, and carry them out using [member Card.Value]
func _effect(target:Node2D):
	match  card_type:
		Card.CARD_TYPE.ATTACK:
			pass
		Card.CARD_TYPE.HEAL:
			pass 
		Card.CARD_TYPE.OVERSHIELD:
			pass 
		Card.CARD_TYPE.POISON:
			pass
		Card.CARD_TYPE.CHARGE:
			pass
