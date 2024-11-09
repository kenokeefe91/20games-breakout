extends Node2D

var paddle_speed = 500
var current_game_state : GameStates.State

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var x_dir = 0
	
	if Input.is_action_pressed("ui_left"):
		x_dir = -1

	if Input.is_action_pressed("ui_right"):
		x_dir = 1

	position.x += paddle_speed * x_dir * delta
	
	var length = get_viewport_rect().size.x
	
	position.x = clamp(position.x, 50, length-50)	
