class_name PowerUpBase extends CharacterBody2D

@export var PowerType : Player.PowerState

@onready var r_cast: RayCast2D = $RCast
@onready var l_cast: RayCast2D = $LCast

func hitPower(body:Player)-> void:
	body.Powering(PowerType)
	queue_free()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		hitPower(body)
