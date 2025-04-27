extends Character
func _ready() -> void:
	super._ready()
	has_turn=true

	
	
	
func turn_start():
	super.turn_start()
	card_sort()
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("e key"):
		draw_card()
		card_sort()


func _on_pass_button_pressed() -> void:
	turn_end()
