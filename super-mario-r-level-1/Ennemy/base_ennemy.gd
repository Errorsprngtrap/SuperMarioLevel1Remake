class_name Base_Ennemy extends CharacterBody2D

@export var SPEED : float = 100

var direction : int = 1
var canDamage : bool = true

@onready var left_ray: RayCast2D = $LeftRay
@onready var right_ray: RayCast2D = $RightRay


func _physics_process(delta: float) -> void:
	## Add the gravity.
	gravity(delta)
	
	##handle movemement
	movement()

	move_and_slide()

func gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func movement() -> void:
	if direction > 0 and right_ray.is_colliding():
		direction = -1
	elif direction < 0 and left_ray.is_colliding():
		direction = 1
	velocity.x = (direction * SPEED)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and canDamage :
		body.Damage()

func death()-> void:
	canDamage = false
	queue_free()
