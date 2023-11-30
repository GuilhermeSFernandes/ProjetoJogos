extends CharacterBody2D

@export var animation_tree: AnimationTree
@export var timer: Timer
@export_category("Objects")
@onready var HpBar = get_node("GUIlayer/GUI/HealthBar")
@onready var lblTimer = get_node("GUIlayer/Timer")
@onready var lblKillCounter = get_node("GUIlayer/KillCounter")

var maxhp = 100
var hp = 100
var damage = 100
var is_attack: bool = false
var state_machine
var vel_mov = 50.0
var is_started = false
var is_dead: bool = false
var time = 0
var kill = 0
var is_fast = false


func _ready():

	state_machine = animation_tree["parameters/playback"]
	velocity = Vector2.ZERO
	hit(0)
	

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
	
	HpBar.max_value = maxhp
	hp -= damage
	HpBar.value = hp
	
	if hp < 0:
		die()
	
func die():
	is_dead = true
	state_machine.travel("death")
	get_tree().change_scene_to_file("res://Ultilidades/game_over_screen.tscn")

func timers (argtime = 0):
	
	time = argtime
	var get_m = int(time/60)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	lblTimer.text = str(get_m,":",get_s)

func KillCounter(deaths):
	
	kill += deaths
	lblKillCounter.text = str(kill)
	
func boost():
	
	is_fast = true
	vel_mov += 50
	
