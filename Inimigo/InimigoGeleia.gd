extends CharacterBody2D

@export_category("Objects")
@export var texture: Sprite2D
@export var animation: AnimationPlayer
@export var mov_speed = 50
@onready var player = get_tree().get_first_node_in_group("Player")


var death = 0
signal KillCounter(death)
var is_dead= false
var hp = 100
var damage = 50

func _ready():
	
	connect("KillCounter", Callable(player, "KillCounter"))
	
func _physics_process(_delta : float):
	
	if is_dead:
		return
		
	_animation()
	
	var dir: Vector2 = global_position.direction_to(player.global_position)
	var dist: float = global_position.distance_to(player.global_position)
	
	velocity = dir * mov_speed
		
	move_and_slide()

func _animation():
	
	if velocity.x > 0:
		texture.flip_h = false
		
	if velocity.x < 0:
		texture.flip_h = true 
		
	if velocity != Vector2.ZERO:
		animation.play("walk")
		return
		
	animation.play("idle")

func _on_area_attack_body_entered(body):
	
	if body.is_in_group("Player"):
		body.hit(damage)
		
func hit(damage):
	
	hp -= damage
	
	if hp < 0:
		death += 1
		is_dead = true
		animation.play("die")
			
#	var deaths = death
	emit_signal("KillCounter",death)
	queue_free()





