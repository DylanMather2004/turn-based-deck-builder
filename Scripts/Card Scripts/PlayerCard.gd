class_name PlayerCard
extends BaseCard
var is_dragging:bool = false 


func _physics_process(delta: float) -> void:
	if is_dragging==true:
		position=get_global_mouse_position()
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Left-Mouse") && sprite.get_rect().has_point(get_local_mouse_position()):
		print("clicked")
		is_dragging = true
	elif Input.is_action_just_released("Left-Mouse") && sprite.get_rect().has_point(get_local_mouse_position()):
		print("up")
		is_dragging = false
		

			
		
