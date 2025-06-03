extends Button

@export var character_to_load:CharacterTemplate
@export var sprite:Sprite2D
var owner_ref

func _ready():
	sprite.texture=character_to_load.icon
	text = character_to_load.character_name


func _on_pressed() -> void:
	PlayerData.character_selection = character_to_load
	get_tree().change_scene_to_file("res://Scenes/Combat.tscn")

func _on_mouse_entered() -> void:
	owner_ref.change_enemy_panel(character_to_load)
