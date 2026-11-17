class_name Shroom extends PowerUpBase

@export var speed : float = 0.5
var direction : int = 1

func _physics_process(delta: float) -> void:
	gravity(delta)
	checkRay()
	move()
	move_and_slide()

func move()->void:
	velocity.x += speed * direction
	
func gravity(delta:float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func checkRay() -> void:
	if direction > 0 and r_cast.is_colliding():
		direction = -1
	if direction < 1 and l_cast.is_colliding():
		direction = 1
