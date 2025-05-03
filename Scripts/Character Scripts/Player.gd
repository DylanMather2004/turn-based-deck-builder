extends Character
var selected_card:BaseCard
func _ready() -> void:
	super._ready()
	has_turn=true


	
	
func turn_start():
	super.turn_start()
	card_sort()


func _on_pass_button_pressed() -> void:
	turn_end()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use_card")&&selected_card!=null:
		selected_card._try_use()
