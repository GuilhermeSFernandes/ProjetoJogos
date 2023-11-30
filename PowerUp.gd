extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
var is_fast = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func fast():
	
	is_fast = true
	self.velocity = 100
	

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.boost()
		queue_free()
