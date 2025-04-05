class_name CardTemplate
extends Node2D
@export var card_to_load:Card
var name_text:Label
var value_text:RichTextLabel
var ap_text:RichTextLabel
var sprite:Sprite2D


var is_dragging:bool = false 
func _ready() -> void:
	name_text=$NameText
	value_text=$ValueText
	ap_text=$APText
	sprite = $Sprite2D
	name_text.text = card_to_load.card_name
	value_text.text = str(card_to_load.value)
	ap_text.text = str(card_to_load.ap_cost)
	sprite.texture = card_to_load.card_art
	
	
func _physics_process(delta: float) -> void:
	if is_dragging==true:
		position=get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Left-Mouse") && sprite.get_rect().has_point(get_local_mouse_position()):
		print("clicked")
		is_dragging = true
	elif Input.is_action_just_released("Left-Mouse") && sprite.get_rect().has_point(get_local_mouse_position()):
		print("up")
		is_dragging = false
