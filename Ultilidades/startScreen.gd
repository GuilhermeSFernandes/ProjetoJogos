extends Control

func _ready():
	
	$controls/start.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_file("res://terreno/terreno.tscn")


func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Ultilidades/controles_screen.tscn")


func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://Ultilidades/creditos.tscn")


func _on_quit_pressed():
	get_tree().quit()
