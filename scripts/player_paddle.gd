extends Node2D

var paddle_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x_dir = 0
	
	if Input.is_action_pressed("ui_left"):
		x_dir = -1

	if Input.is_action_pressed("ui_right"):
		x_dir = 1

	position.x += paddle_speed * x_dir * delta
