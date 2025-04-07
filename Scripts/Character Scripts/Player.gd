extends Character
@export var hand_slot:Node2D
func _ready() -> void:
	super._ready()
	for i in range(0,max_hand_size):
		draw_card()
	card_sort()
func place_card(card:Node2D):
	print("card placed")
	get_tree().get_root().call_deferred("add_child",card)
	
func card_sort():
	for i in range(hand.size()):
		hand[i].position = hand_slot.slots[i].global_position
	
