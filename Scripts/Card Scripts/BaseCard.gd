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
@export var card_audio:WwiseEvent

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
	if burn_check()==true&&!(card_type==Card.CARD_TYPE.HEAL&&owner_character.health==owner_character.max_health):
		owner_character.deduct_ap(ap)
		card_delete()
		return
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
			target.poison(value)
		Card.CARD_TYPE.SACRIFICE:
			owner_character.health-=ap
			owner_character.health = clamp(owner_character.health,0,owner_character.max_health)
			if owner_character.health ==0:
				owner_character.die()
			owner_character.healthbar.value=owner_character.health
			owner_character.health_text.text="HP: "+ str(owner_character.health)
			
		Card.CARD_TYPE.BURN:
			target.burn(value)
			
	if card_type!=Card.CARD_TYPE.SACRIFICE:
		owner_character.deduct_ap(ap)
	
	card_animator.play("Used")
	card_audio.post(self)
	
	
func _try_use():
	if get_tree()!=null&& ((card_type != Card.CARD_TYPE.SACRIFICE&&ap <=owner_character.ap) or (card_type==Card.CARD_TYPE.SACRIFICE and ap<owner_character.health)):
		_select_target()
	else:
		use_failed()
		print("can't use")
		
func _select_target():
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
	if card_type==Card.CARD_TYPE.SACRIFICE:
		for i in range(value):
			owner_character.draw_card()
			owner_character.card_sort()
	queue_free()
func burn_check() -> bool:
	if owner_character.burn_stacks>0:
		var rng = RandomNumberGenerator.new()
		if rng.randi_range(1,10) <=3:
			owner_character.clear_burn()
			return true
	return false 
		
		
	
