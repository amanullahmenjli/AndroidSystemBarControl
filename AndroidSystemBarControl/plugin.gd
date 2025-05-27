@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("AndroidSystemBarControl", "res://addons/AndroidSystemBarControl/android_system_bar_control.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("AndroidSystemBarControl")
