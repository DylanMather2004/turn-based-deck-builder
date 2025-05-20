extends Control

@export var enemies:Array[CharacterTemplate]
@export var button_prefab:PackedScene
@export var menu_panel:VBoxContainer
@export_category("Enemy Panel")
@export var sprite:AnimatedSprite2D
@export var health_text:RichTextLabel
@export var ap_text:RichTextLabel

func _ready():
	for i in range(enemies.size()):
		var button = button_prefab.instantiate()
		button.character_to_load = enemies[i]
		button.owner_ref = self 
		menu_panel.add_child(button)
	
func change_enemy_panel(enemy:CharacterTemplate):
	sprite.sprite_frames=enemy.sprite_sheet
	sprite.play("default")
	health_text.text=": "+str(enemy.health)
	ap_text.text = ": "+str(enemy.ap)
	
	
