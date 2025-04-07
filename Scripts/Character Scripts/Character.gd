class_name Character
extends Node2D
@export var character_resource:CharacterTemplate
@export var card_template:PackedScene
@export var sprite_animator:AnimatedSprite2D

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
	deck=character_resource.deck
	sprite_frames=character_resource.sprite_sheet
	sprite_animator.sprite_frames = sprite_frames
	sprite_animator.play("default")
func draw_card():
	rng.randomize()
	var card_ID = rng.randi_range(0,deck.size()-1)
	var card_to_draw = deck[card_ID] 
	var new_card_node:Node2D = card_template.instantiate()
	new_card_node.card_to_load = card_to_draw
	new_card_node.initialize()
	deck.remove_at(card_ID)
	hand.append(new_card_node)
	place_card(new_card_node)
	
func place_card(card:Node2D):
	pass
func damage(change):
	health-=change
	health = clamp(health,0,character_resource.health)
	if health ==0:
		die()
func die():
	pass 
	
