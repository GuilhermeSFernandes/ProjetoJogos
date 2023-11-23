extends CharacterBody2D

@export var animation_tree: AnimationTree
@export var timer: Timer
@export_category("Objects")

var hp = 10
var damage = 10
var is_attack: bool = false
var state_machine
var vel_mov = 50.0
var is_started = false
var is_dead: bool = false

func _ready():

	state_machine = animation_tree["parameters/playback"]
	velocity = Vector2.ZERO

func _physics_process(delta):
	
	if is_dead:
		return
		
	attack()
	move()
	animation()
	
func move():
	
	var dir : Vector2 = Vector2 (
		Input.get_axis("esquerda", "direita"),
		Input.get_axis("cima", "baixo"),
	)
	if dir != Vector2.ZERO:
		animation_tree ["parameters/idle/blend_position"] = dir
		animation_tree ["parameters/walk/blend_position"] = dir
		animation_tree ["parameters/attack/blend_position"] = dir
	
	velocity = dir.normalized() * vel_mov
	set_velocity(velocity)
	move_and_slide()
	
func attack():
	
	if Input.is_action_just_pressed("attack") and is_attack == false:
		set_physics_process(false)
		timer.start()
		is_attack = true

func animation():
	
	if is_dead:
		state_machine.travel("death")
		return
		
	if is_attack:
		state_machine.travel("attack")
		return
		
	if velocity.length() > 10 :
		state_machine.travel("walk")
		return
		
	state_machine.travel("idle")
	
func _on_attack_timer_timeout():
	
	set_physics_process(true)
	is_attack = false


func _on_area_attack_body_entered(body):
	if body.is_in_group("Inimigo"):
		body.hit(damage)
		
func hit(damage):
	hp -= damage
	
	if hp < 0:
		is_dead = true
	state_machine.travel("death")
	
func die():
	is_dead = true
	state_machine.travel("death")
	await get_tree().create_timer(2.0).timeout
	
