extends Character
@export var game_manager:Node2D
@export var player_character:CharacterTemplate #IMPORTANT - This is a temporary variable that will be used until character selection is implemented
var selected_card:BaseCard
var cards_used=[]
func _ready() -> void:
	super._ready()
	has_turn=true
func character_loader():
	character_resource=player_character
func deck_init():
	if PlayerData.deck!= null && !PlayerData.deck.is_empty():
		for i in range(PlayerData.deck.size()):
			deck.append(PlayerData.deck[i])
		
	else:
		super.deck_init()
		
	
func deck_refresh():
	if PlayerData.deck!=null&&!PlayerData.deck.is_empty():
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
	if Input.is_action_just_pressed("use_card")&&selected_card!=null&&has_turn:
		selected_card._try_use()

func die():
	game_manager.lose()
