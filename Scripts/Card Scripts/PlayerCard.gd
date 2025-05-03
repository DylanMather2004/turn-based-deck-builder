class_name PlayerCard
extends BaseCard
var is_dragging:bool = false 
var in_play=false 
		
	
func _physics_process(delta: float) -> void:
	if sprite.get_rect().has_point(get_local_mouse_position()):
		owner_character.selected_card=self


		
func use_failed():
	super.use_failed()
	position=reset_pos



	
