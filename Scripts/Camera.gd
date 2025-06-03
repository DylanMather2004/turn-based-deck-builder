extends Camera2D

@export var strength_multiplier=1
@export var shake_fade: float =  5.0 
var shaking=false 

var rng = RandomNumberGenerator.new()

var strength:float =0
func start_shake(damage:float):
	shaking = true
	strength=damage*strength_multiplier

func _process(delta: float) -> void:
	if strength>0:
		strength=lerpf(strength,0,shake_fade*delta)
		offset=randomOffset()
	await get_tree().create_timer(0.01).timeout
	shaking=false
	
func randomOffset() ->Vector2:
	rng.randomize()
	return Vector2(rng.randf_range(-strength, strength),rng.randf_range(-strength,strength))
