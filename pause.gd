extends CanvasLayer

@onready var resume = $menu/resume

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	get_tree().paused = false
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		visible = true
		get_tree().paused = true
		resume.grab_focus()
		
func _on_quit_pressed():
	get_tree().quit()


func _on_voltar_menu_pressed():
	get_tree().change_scene_to_file("res://Ultilidades/start_screen.tscn")
