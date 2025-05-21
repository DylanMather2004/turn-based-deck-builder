extends AnimatedSprite2D
var has_mouse = false 
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use_card")&&has_mouse:
		play("hurt")
		await get_tree().create_timer(0.1).timeout
		play("default")


func _on_spritebox_mouse_entered() -> void:
	has_mouse=true


func _on_spritebox_mouse_exited() -> void:
	has_mouse=false
