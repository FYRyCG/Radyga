extends Node2D


func _on_ControleNode_script_changed():
	print("script changed")
	$ControleNode._ready()
	$ControleNode.set_physics_process(true)
