class_name CharacterTemplate
extends Resource
##The [CharacterTemplate] class contains statistics and details for building characters
##Instantiate this classs to create new characters

@export_category("Display Settings")
##[member CharacterTemplate.character_name] is a string containing the character's name to be displayed in-game
@export var character_name:String
##[member CharacterTemplate.sprite_sheet] is a SpriteFrames resource reference that freatures the sprite sheet of the character
@export var sprite_sheet:SpriteFrames
@export var icon:Texture2D
@export_category("Combat Settings")
@export var health:int
@export var ap:int
@export var deck: Array[Card]
