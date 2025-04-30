class_name BaseCard
extends Node2D
@export var card_to_load:Card
@export var name_text:Label
@export var value_text:RichTextLabel
@export var ap_text:RichTextLabel
@export var sprite:Sprite2D
var card_type
var owner_character:Character
var value:int
var ap:int 
@export var card_animator:AnimationPlayer
var reset_pos:Vector2

func initialize():
	
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
				use_failed()
				return
			owner_character.heal(value)
		Card.CARD_TYPE.OVERSHIELD:
			if owner_character.overshield<owner_character.max_overshield:
				owner_character.grant_overshield(value)
			else:
				use_failed()
				return
		Card.CARD_TYPE.POISON:
			pass #Replace wiith Poison Logic
		Card.CARD_TYPE.CHARGE:
			pass #Replace with Charge Logic 
	owner_character.deduct_ap(ap)
	
	card_animator.play("Used")
	
	
func _try_use():
	if ap<=owner_character.ap&&get_tree()!=null:
		_select_target()
	else:
		use_failed()
		
func _select_target():
	print(get_tree())
	var players = get_tree().get_nodes_in_group("character")
	var target:Node2D
	for i in range(players.size()):
		if players[i]!=owner_character:
			target=players[i]
			break
	if target==null:
		use_failed()
		return
	_effect(target)
func use_failed():
	pass

func card_delete():
	owner_character.hand.erase(self)
	queue_free()
