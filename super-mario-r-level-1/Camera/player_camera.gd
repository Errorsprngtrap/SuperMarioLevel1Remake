extends Camera2D

@export var player : Player

func _ready() -> void:
	print(player)

func _physics_process(delta: float) -> void:
	position.x = player.position.x * delta
