extends Node2D

var current_game_state : GameStates.State

signal launch_game

# Called when the node enters the scene tree for the first time.
func _ready():
	current_game_state = GameStates.State.WAIT_FOR_STATE
	set_start_position()
	transfer_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		current_game_state = new_game_state()
		
	transfer_state()
	
func new_game_state() -> GameStates.State :
	if current_game_state == GameStates.State.RUNNING:
		return GameStates.State.PAUSED
	
	return GameStates.State.RUNNING

func transfer_state():
	$Paddle.current_game_state = current_game_state
	$Ball.current_game_state = current_game_state

func _ball_reach_floor():
	current_game_state = GameStates.State.WAIT_FOR_STATE
	set_start_position()

func set_start_position():
	var length = get_viewport_rect().size.x
	var heigth = get_viewport_rect().size.y
	$Paddle.position = Vector2(length / 2, heigth - heigth/20)
	$Ball.position = Vector2($Paddle.position.x, $Paddle.position.y - 20)
