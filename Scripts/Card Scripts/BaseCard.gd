class_name BaseCard
extends Node2D
@export var card_to_load:Card
var name_text:Label
var value_text:RichTextLabel
var ap_text:RichTextLabel
var sprite:Sprite2D
var card_type
var owner_character:Character
var value:int
var ap:int 

func initialize():
	name_text=$NameText
	value_text=$ValueText
	ap_text=$APText
	sprite = $Sprite2D
	name_text.text = card_to_load.card_name
	ap = card_to_load.ap_cost
	value = card_to_load.value
	value_text.text = str(value)
	ap_text.text = str(ap)
	sprite.texture = card_to_load.card_art
	card_type=card_to_load.card_type

##_effect will select the appropriate effect for each card type, and carry them out using [member Card.Value]
func _effect(target:Character):
	match  card_type:
		Card.CARD_TYPE.ATTACK:
			target.damage(value)
		Card.CARD_TYPE.HEAL:
			if owner_character.health ==owner_character.max_health: 
				owner_character.deduct_ap(-ap)
				use_failed()
				return
			owner_character.damage(-value)
		Card.CARD_TYPE.OVERSHIELD:
			pass 
		Card.CARD_TYPE.POISON:
			pass
		Card.CARD_TYPE.CHARGE:
			pass
			
	
	owner_character.hand.erase(self)
	queue_free()
	
	
func _try_use():
	if ap<=owner_character.ap:
		owner_character.deduct_ap(ap)
		_select_target()
	else:
		use_failed()
		
func _select_target():
	var players = get_tree().get_nodes_in_group("character")
	var target:Node2D
	for i in range(players.size()):
		if players[i]!=owner_character:
			target=players[i]
			break
	
	_effect(target)
func use_failed():
	pass
		
