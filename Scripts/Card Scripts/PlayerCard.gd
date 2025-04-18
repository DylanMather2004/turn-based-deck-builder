class_name PlayerCard
extends BaseCard
var is_dragging:bool = false 
var reset_pos:Vector2
var in_play=false 


func _physics_process(delta: float) -> void:
	if is_dragging==true:
		position=get_global_mouse_position()
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Left-Mouse") && sprite.get_rect().has_point(get_local_mouse_position()):
		print("clicked")
		is_dragging = true
	elif Input.is_action_just_released("Left-Mouse") && sprite.get_rect().has_point(get_local_mouse_position())&&is_dragging:
		print("up")
		is_dragging = false
		if in_play==true:
			_try_use()
		else:
			position=reset_pos


func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("play area"):
		in_play=true


func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("play area"):
		in_play=false
		
func use_failed():
	super.use_failed()
	position=reset_pos
