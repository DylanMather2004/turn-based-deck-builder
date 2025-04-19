class_name Enemy
extends Character
enum PRIORITY{NONE,HEAL}
var current_priority:PRIORITY
var cannot_use:Array[Card]
var card_to_use:BaseCard
@export var card_display_point:Node2D
func _ready() -> void:
	super._ready()
	for i in range(max_hand_size):
		draw_card()
func turn_start():
	super.turn_start()
	print("enemy turn started")
	print(hand)
	_choose_random_card()
	
	
func pick_priority():
	if health <= max_health/4:
		current_priority=PRIORITY.HEAL
	else:
		current_priority=PRIORITY.NONE

func _choose_priority_card():
	match current_priority:
		PRIORITY.NONE:
			_choose_random_card()
		PRIORITY.HEAL:
			for i in range(0,hand.size()):
				if hand[i].card_type == Card.CARD_TYPE.HEAL:
					card_to_use=hand[i]
					break
					
			if card_to_use!=null:
				use_card(card_to_use)
			else:
				_choose_random_card()
func _choose_random_card():
	rng.randomize()
	card_to_use = hand[rng.randi_range(0,hand.size()-1)]
	print(card_to_use)
	use_card(card_to_use)
func use_card(card:BaseCard):
	get_tree().get_root().add_child(card)
	card.position=card_display_point.global_position
	card._try_use()
