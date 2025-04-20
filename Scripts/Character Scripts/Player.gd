extends Character
@export var hand_slot:Node2D
func _ready() -> void:
	super._ready()
	for i in range(max_hand_size):
		draw_card()
	card_sort()
	has_turn=true
func place_card(card:Node2D):
	
	get_tree().get_root().call_deferred("add_child",card)
	
	
func card_sort():
	for i in range(hand.size()):
		hand[i].position = hand_slot.slots[i].global_position
		hand[i].reset_pos = hand[i].position
	
func turn_start():
	super.turn_start()
	card_sort()
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("e key"):
		draw_card()
		card_sort()


func _on_pass_button_pressed() -> void:
	turn_end()
