extends TextureButton
var hovering = false
func _process(delta: float) -> void:
	if hovering == false:
		scale = lerp(scale,Vector2(0.8,0.8),0.1)
	else:
		scale=lerp(scale,Vector2(1,1),0.1)


func _on_mouse_entered() -> void:
	hovering=true


func _on_mouse_exited() -> void:
	hovering=false
