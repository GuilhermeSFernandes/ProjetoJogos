extends KinematicBody2D

var enemy_scene_path = "res://Inimigo/Inimigo.tscn"
export var velo_mov = 30.0
var velocity = Vector2.ZERO
var spawn_interval = 2.0
var time_since_last_spawn = 0.0
onready var player: Node = null

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	spawn_enemy()

func _process(delta):
	time_since_last_spawn += delta
	if time_since_last_spawn >= spawn_interval:
		generate_enemies()
		time_since_last_spawn = 0.0
		
func _physics_process(_delta):
	if player:
		var direction = player.global_position - global_position
		velocity = direction.normalized() * velo_mov
		move_and_slide(velocity)

func calculate_enemies_for_level(difficulty_level):
	var base_enemies = 5
	var extra_enemies = difficulty_level * 2
	return base_enemies + extra_enemies

func generate_enemies():
	var enemies_to_spawn = calculate_enemies_for_level(2) 
	for i in range(enemies_to_spawn):
		spawn_enemy()

func spawn_enemy():
	var enemy_instance = load(enemy_scene_path).instance()
	get_parent().add_child(enemy_instance)
	enemy_instance.global_position = global_position
