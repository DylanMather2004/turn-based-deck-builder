extends AnimatedSprite2D
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use_card"):
		play("hurt")
		get_tree().create_timer(0.5).timeout
		play("default")
