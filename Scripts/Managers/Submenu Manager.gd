extends VBoxContainer
@export var max_cards_per_row:int
var current_row:HBoxContainer
var cards_in_row = 0
func _ready() -> void:
	add_new_row()
	
func add_card(card:TextureButton):
	current_row.add_child(card)
	cards_in_row+=1
	if cards_in_row ==max_cards_per_row:
		add_new_row()
		cards_in_row=0 
func add_new_row():
	current_row=HBoxContainer.new()
	add_child(current_row)
