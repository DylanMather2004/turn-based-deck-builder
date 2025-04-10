class_name Character
extends Node2D
@export var character_resource:CharacterTemplate
@export var card_template:PackedScene
@export var sprite_animator:AnimatedSprite2D

@export_category("UI References")
@export var healthbar:ProgressBar
@export var ap_bar:ProgressBar

var health:int
var ap:int
var deck:Array[Card]
var hand:Array
var sprite_frames:SpriteFrames
var max_hand_size = 6
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	health = character_resource.health
	ap=character_resource.ap
	deck=character_resource.deck.duplicate()
	sprite_frames=character_resource.sprite_sheet
	sprite_animator.sprite_frames = sprite_frames
	sprite_animator.play("default")
	healthbar.max_value=health
	healthbar.value=health
	ap_bar.max_value=ap
	ap_bar.value=ap
func draw_card():
	print(character_resource.deck)
	rng.randomize()
	var card_ID = rng.randi_range(0,deck.size()-1)
	var card_to_draw = deck[card_ID] 
	var new_card_node:Node2D = card_template.instantiate()
	new_card_node.card_to_load = card_to_draw
	new_card_node.initialize()
	new_card_node.owner_character = self
	deck.remove_at(card_ID)
	hand.append(new_card_node)
	place_card(new_card_node)
	print(deck)
	print(character_resource.deck)
	if deck.is_empty():
		deck_refresh()
	
func place_card(card:Node2D):
	pass
func damage(change):
	health-=change
	health = clamp(health,0,character_resource.health)
	healthbar.value=health
	if health ==0:
		die()
func die():
	pass 
	
func deduct_ap(cost:int):
	ap-=cost
	ap_bar.value=ap
	if ap<=0:
		pass_turn()
	print(ap)

func turn_start():
	while hand.size()<max_hand_size:
		draw_card()
func pass_turn():
	pass
func deck_refresh():
	deck=character_resource.deck.duplicate()
	print(character_resource.deck)
	print(deck)
	
