extends Character
@export var game_manager:Node2D
var selected_card:BaseCard
func _ready() -> void:
	super._ready()
	has_turn=true

func deck_init():
	if PlayerData.deck!= null && !PlayerData.deck.is_empty():
		for i in range(PlayerData.deck.size()):
			deck.append(PlayerData.deck[i])
		print(deck)
	else:
		super.deck_init()
		print("hello!")
	
func deck_refresh():
	if !PlayerData.deck.is_empty():
		for i in range(PlayerData.deck.size()):
			deck.append(PlayerData.deck[i])
	else:
		super.deck_refresh()
	
func turn_start():
	super.turn_start()
	card_sort()


func _on_pass_button_pressed() -> void:
	turn_end()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use_card")&&selected_card!=null:
		selected_card._try_use()

func die():
	game_manager.lose()
	
