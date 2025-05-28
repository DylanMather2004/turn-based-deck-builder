class_name PlayerCard
extends BaseCard
@export var card_flick_audio:WwiseEvent
var sound_played = false
var in_play=false 


func _physics_process(delta: float) -> void:
	if sprite.get_rect().has_point(get_local_mouse_position()):
		if sound_played==false:
			card_flick_audio.post(self)
			sound_played= true
		owner_character.selected_card=self
		scale=lerp(scale,Vector2(1.5,1.5),0.5)
		position.y=lerp(position.y,reset_pos.y-30,0.5)
	else:
		scale=lerp(scale,Vector2(1,1),0.5)
		position.y =lerp(position.y,reset_pos.y,0.5)
		sound_played=false

func _try_use():
	if sprite.get_rect().has_point(get_local_mouse_position())&&!in_play:
		in_play=true
		owner_character.cards_used.append(card_to_load.card_name)
		super._try_use()
		
		
func use_failed():
	in_play=false
	super.use_failed()
	position=reset_pos



	
