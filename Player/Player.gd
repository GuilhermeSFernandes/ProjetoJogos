extends KinematicBody2D


var vel_mov = 50.0
var velocity = Vector2.ZERO
func _physics_process(delta):
	move()
	
func move():
	var x_mov = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	var y_mov = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized()*vel_mov
	move_and_slide(velocity)
