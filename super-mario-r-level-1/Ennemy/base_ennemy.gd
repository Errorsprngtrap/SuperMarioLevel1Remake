class_name Base_Ennemy extends CharacterBody2D

@export var SPEED : float = 100

var direction : int = 1
var canDamage : bool = true

@onready var left_ray: RayCast2D = $LeftRay
@onready var right_ray: RayCast2D = $RightRay
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("Walk")
	
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
	if !canDamage :
		return
		
	if body is Player :
		if body.velocity.y > 0 and body.global_position.y < global_position.y:
			return
		body.Damage()

func damage()-> void:
	death()
	
func death()-> void:
	canDamage = false
	animated_sprite_2d.play("Stomped")
	await get_tree().create_timer(.2).timeout
	queue_free()
