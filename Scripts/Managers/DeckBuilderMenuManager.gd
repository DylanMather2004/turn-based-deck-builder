extends Control
var owned_cards = []
var deck=[]
var deck_buttons=[]
@export_category("Deck Settings")
@export var max_deck_size:int =20
@export_category("UI Settings")
@export var cells_per_row = 5
@export var attack_card_menu:VBoxContainer
@export var heal_card_menu:VBoxContainer
@export var shield_card_menu:VBoxContainer
@export var poison_card_menu:VBoxContainer
@export var deck_menu:HBoxContainer
@export var menu_button_prefab:PackedScene
@export var deck_button_prefab:PackedScene
@export var deck_size_text:RichTextLabel
@export var deck_status_text:RichTextLabel
@export_category("Card Display")
@export var sprite:Sprite2D
@export var name_Text:Label
@export var value_text:RichTextLabel
@export var ap_cost_text:RichTextLabel
@export_category("Save Settings")
@export var save_path:String = "user://deck.save"
var save_manager = SaveManager.new()


func _ready() -> void:
	for i in (PlayerData.owned_cards):
		owned_cards.append(load(i))
		
	for i in range(owned_cards.size()):
		var new_button:TextureButton = menu_button_prefab.instantiate()
		new_button.texture_normal=owned_cards[i].card_art
		new_button.card=owned_cards[i]
		new_button.menu_manager =self
		match owned_cards[i].card_type:
			Card.CARD_TYPE.ATTACK:
				attack_card_menu.call_deferred("add_card",new_button)
			Card.CARD_TYPE.HEAL:
				heal_card_menu.call_deferred("add_card",new_button)
			Card.CARD_TYPE.OVERSHIELD:
				shield_card_menu.call_deferred("add_card",new_button)
			Card.CARD_TYPE.POISON:
				poison_card_menu.call_deferred("add_card",new_button)
	load_deck()
	if deck==null:
		deck=[]
	update_deck_size_text()
				
func add_card_to_deck(card:Card):
	if deck.size()!=max_deck_size:
		deck.append(card.resource_path)
		add_deck_button(card)
		update_deck_size_text()
	
func remove_card_from_deck(cardbutton:TextureButton):
	deck.erase(cardbutton.card.resource_path)
	deck_buttons.erase(cardbutton)
	cardbutton.queue_free()
	update_deck_size_text()
func save_deck():
	if deck.size()==max_deck_size:
		var file = FileAccess.open(save_path,FileAccess.WRITE)
		file.store_var(deck)
		file.close()
func load_deck():
	clear_deck()
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		for i in file.get_var():
			deck.append(i)
			
		for i in range(deck.size()):
			add_deck_button(load(deck[i]))
		deck_status_text.text="Deck Loaded!"
	else:
		deck_status_text.text="No saved deck!"
func clear_deck():
	while deck_buttons.size()>0:
		remove_card_from_deck(deck_buttons[0])
		
		

func add_deck_button(card:Card):
	var new_button:TextureButton=deck_button_prefab.instantiate()
	new_button.texture_normal=card.card_art
	new_button.menu_manager=self
	new_button.card = card
	deck_menu.add_child(new_button)
	deck_buttons.append(new_button)
	


func _on_save_button_pressed() -> void:
	if deck.size()==max_deck_size:
		save_manager._save_deck(deck,save_path)
		deck_status_text.text = "Deck Saved!"
	else: 
		deck_status_text.text= "Deck Too Small!"


func _on_load_button_pressed() -> void:
	clear_deck()
	deck = save_manager._load_deck(save_path)
	if deck!=null:
		for i in range(deck.size()):
			if is_instance_valid(deck[i]):
				add_deck_button(deck[i])
		deck_status_text.text="Deck Loaded"
	else:
		deck_status_text.text="No Deck to Load"

func _on_texture_button_pressed() -> void:
	print("press")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func show_card(card:Card):
	sprite.texture=card.card_art
	name_Text.text=card.card_name
	value_text.text=str(card.value)
	ap_cost_text.text=str(card.ap_cost)
	
func update_deck_size_text():
	deck_size_text.text=str(deck.size())+"/"+str(max_deck_size)
