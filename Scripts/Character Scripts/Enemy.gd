class_name Enemy
extends Character
enum PRIORITY{NONE,HEAL}
var current_priority:PRIORITY
var cannot_use:Array[BaseCard]
var card_to_use:EnemyCard
@export var card_display_point:Node2D
func _ready() -> void:
	super._ready()
	for i in range(max_hand_size):
		draw_card()
		

func turn_start():
	super.turn_start()
	print("enemy turn started")
	turn()
	
	
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
	use_card(card_to_use)
func use_card(card:EnemyCard):
	if has_turn:
		get_tree().get_root().add_child(card)
		card.position=card_display_point.global_position
		card._try_use()
	
func turn():
	if has_turn:
		while hand.size()>0:
			_choose_random_card()
			print(hand)
			await get_tree().create_timer(1).timeout
			if hand.size()==0||ap<=0:
				turn_end()
				return
	
func turn_end():
	super.turn_end()
	for i in range(cannot_use.size()-1):
		hand.append(cannot_use[i])
		cannot_use.remove_at(i)

func die():
	queue_free()
	
