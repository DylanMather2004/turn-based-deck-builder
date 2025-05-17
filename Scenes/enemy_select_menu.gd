extends Control

@export var enemies:Array[CharacterTemplate]
@export var button_prefab:PackedScene
@export var menu_panel:VBoxContainer

func _ready():
	for i in range(enemies.size()):
		var button = button_prefab.instantiate()
		button.character_to_load = enemies[i]
		menu_panel.add_child(button)
