class_name CardTemplate
extends Node2D
@export var card_to_load:Card
var name_text:RichTextLabel
var value_text:RichTextLabel
var ap_text:RichTextLabel
var sprite:Sprite2D

func _ready() -> void:
	name_text=$NameText
	value_text=$ValueText
	ap_text=$APText
	sprite = $Sprite2D
	name_text.text = card_to_load.card_name
	value_text.text = str(card_to_load.value)
	ap_text.text = str(card_to_load.ap_cost)
	sprite.texture = card_to_load.card_art
