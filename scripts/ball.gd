extends Node2D

@export var paddle: Node2D

signal reach_floor

var current_game_state: GameStates.State
var moving_vector: Vector2
var ball_speed : int = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	moving_vector = Vector2(0, -1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_game_state == GameStates.State.WAIT_FOR_STATE:
		position.x = paddle.position.x
		
	if current_game_state == GameStates.State.PAUSED:
		return
		
	if current_game_state == GameStates.State.RUNNING:
		move_ball(delta)

func move_ball(delta: float):
	position += moving_vector.normalized() * ball_speed * delta
	
func _collide_on_area(area: Area2D):
	if area.name == "TopWall":
		moving_vector.y *= -1
		
	if area.name == "LeftWall" or area.name == "RightWall":
		moving_vector.x *= -1
		
	if area.name == "PaddleArea":
		moving_vector.y *= -1
		moving_vector.x += paddle_x_offset(paddle.position.x, position.x)
		
	if area.name == "BrickTopBot":
		moving_vector.y *= -1
	
	if area.name == "BrickLeftRight":
		moving_vector.x *= -1
		
	if area.name == "Floor":
		emit_signal("reach_floor")

func paddle_x_offset(x_paddle: float, x_ball: float) -> float:
	var coeff = abs(x_ball - x_paddle) / 50
	
	if x_paddle < x_ball: # On the right
		return coeff
		
	if x_paddle > x_ball: # On the left
		return coeff * - 1
		
	return 0.0
