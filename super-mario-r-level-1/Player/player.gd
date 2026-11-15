class_name Player extends CharacterBody2D

enum State{IDLE,WALK,JUMP,CROUCH,FALL}
enum PowerState{Small,Super}

@export var JUMP_VELOCITY : float = - 400.0 
@export var SPEEDMin : float = 400.0
@export var SPEEDMax : float = 400.0
@export var SPEED : float = 300.0
@export var SpeedAcceleration : float = 2.0
 
@export var Dead : bool = false

@export var currentState :State = State.IDLE
@export var currentPowerState:PowerState = PowerState.Small

func _physics_process(delta: float) -> void:
	if !Dead:
		gravity(delta)
		
		match currentState:
			State.IDLE:idle_State()
			State.WALK:walk_State()
			State.JUMP:jump_State()
			State.CROUCH:crouch_State()
			State.FALL:fall_State()
		
		move_and_slide()

func idle_State() -> void:
	print("Entering Idle")
	currentState = State.IDLE
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		get_jump()
	if get_input() != 0 :
		walk_State()
	
func crouch_State() -> void:
	pass
	
func walk_State() -> void:
	print("Entering Walk")
	currentState = State.WALK
	var dir : float = get_input()
	
	if dir == 0 :
		idle_State()
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		get_jump()
		 
	if Input.is_action_just_pressed("sprint"):
		SPEED += SpeedAcceleration
	else:
		SPEED -= SpeedAcceleration
		
	SPEED = clampf(SPEED,SPEEDMin,SPEEDMax)
	
	velocity.x = dir * SPEED
	
	
func jump_State() -> void:
	velocity.x = get_input() * SPEED
	if velocity.y >= 0 :
		fall_State()
	
func fall_State() -> void:
	print("Entering Fall")
	velocity.x = get_input() * SPEED
	currentState = State.FALL
	
	if is_on_floor():
		if get_input() == 0 :
			idle_State()
		else:
			walk_State()

func gravity(delta:float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func get_input() -> float:
	return Input.get_axis("left", "right")

func get_jump() -> void:
	print("Entering Jump")
	velocity.y = JUMP_VELOCITY
	currentState = State.JUMP

func Damage()-> void:
	if PowerState.Small :
		Dead = true
		Death()
	
func Death()-> void:
	print("dead")
