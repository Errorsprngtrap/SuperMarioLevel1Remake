class_name Shroom extends PowerUpBase

@export var speed : float = 100

func _physics_process(delta: float) -> void:
	gravity(delta)
	
	
	
	move_and_slide()
	
func gravity(delta:float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
