class_name Character
extends Node2D
var character_resource:CharacterTemplate
@export var card_template:PackedScene
@export_category("Graphics References")
@export var sprite_animator:AnimatedSprite2D
@export var poison_particles:GPUParticles2D
@export_category("UI References")
@export var healthbar:ProgressBar
@export var health_text:RichTextLabel
@export var ap_bar:ProgressBar
@export var ap_text:RichTextLabel
@export var turn_animator:AnimationPlayer
@export var effect_animator:AnimationPlayer
@export var hand_slot:Node2D
@export var shield_icon_pref:PackedScene
@export var poison_icon_ref:PackedScene
var max_health:int
var health:int
var max_ap:int
var ap:int
var deck:Array[Card]
var hand:Array[BaseCard]
var sprite_frames:SpriteFrames
var max_hand_size = 6
var rng = RandomNumberGenerator.new()
var has_turn:bool
#overshield variables
var overshield:int = 0
var max_overshield:int = 3
@export var shield_bar:HBoxContainer
@export var poison_bar:HBoxContainer
var shield_icons=[]
var poison_icons=[]
#poison variables
var poison_stacks:int = 0
var poison_ticks:int = 0

func _ready() -> void:
	character_loader()
	max_health = character_resource.health
	health = max_health
	max_ap=character_resource.ap
	ap=max_ap
	deck_init()
	sprite_frames=character_resource.sprite_sheet
	sprite_animator.sprite_frames = sprite_frames
	sprite_animator.play("default")
	healthbar.max_value=health
	healthbar.value=health
	health_text.text="HP: "+ str(health)
	ap_bar.max_value=ap
	ap_bar.value=ap
	ap_text.text="AP: "+str(ap)
	for i in range(max_hand_size):
		draw_card()
	card_sort()
func character_loader():
	pass
func deck_init():
	deck=character_resource.deck.duplicate()

func draw_card():
	if hand.size()<max_hand_size:
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
			
	else:
		print("Deck Full!")
func place_card(card:Node2D):
	get_tree().get_root().call_deferred("add_child",card)
func damage(change):
	if overshield == 0:
		health-=change
		health = clamp(health,0,max_health)
		healthbar.value=health
		health_text.text = "HP: "+str(health)
		effect_animator.play("hit")
		if health ==0:
			die()
	else:
		overshield-=1
		shield_icons[shield_icons.size()-1].queue_free()
		shield_icons.erase(shield_icons[shield_icons.size()-1])
func poison_damage():
	health -=poison_stacks*3
	health=clamp(health,0,max_health)
	health_text.text="HP:"+str(health)
	healthbar.value=health
	effect_animator.play("poison")
	if health==0:
		die()
func heal(heal):
	
	health +=heal
	health = clamp(health,0,max_health)
	healthbar.value=health
	health_text.text="HP: "+ str(health)
	effect_animator.play("heal")
	
func die():
	pass 
func deduct_ap(cost:int):
	ap-=cost
	ap_bar.value=ap
	ap_text.text="AP: "+ str(ap)
	if ap<=0:
		turn_end()
	print(ap)
func turn_start():
	has_turn=true
	if hand.size()>0:
		draw_card()
	else:
		for i in range(max_hand_size):
			draw_card()
	turn_animator.play("turn_start")
func turn_end():
	if !has_turn:
		return
	has_turn=false
	#Restore AP
	ap=max_ap
	ap_bar.value=ap
	ap_text.text="AP: "+str(ap)
	#Manage Poison
	if poison_ticks>0:
		poison_damage()
		poison_ticks-=1
		poison_icons[poison_icons.size()-1].queue_free()
		poison_icons.remove_at(poison_icons.size()-1)
		if poison_ticks ==0:
			poison_particles.emitting=false
	turn_animator.play("turn_end")
func deck_refresh():
	deck=character_resource.deck.duplicate()
	print(character_resource.deck)
	print(deck)
func card_sort():
	for i in range(hand.size()):
		if hand[i]!=null:
			hand[i].position = hand_slot.slots[i].global_position
			hand[i].reset_pos = hand[i].position	
func grant_overshield(add_overshield:int):
	overshield += add_overshield
	overshield = clamp(overshield,0,max_overshield)
	var shield_icon = shield_icon_pref.instantiate()
	shield_icons.append(shield_icon)
	shield_bar.add_child(shield_icon)
	
func poison(ticks:int):
	poison_stacks+=1 
	poison_ticks=ticks
	poison_particles.emitting=true
	while poison_icons.size()<poison_ticks:
		var poison_icon = poison_icon_ref.instantiate()
		poison_icons.append(poison_icon)
		poison_bar.add_child(poison_icon)
	
