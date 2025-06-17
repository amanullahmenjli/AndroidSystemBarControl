@tool
extends Node

const Utils = preload("utils.gd")

# needed Android utilities
var android_runtime: JNISingleton
var window: JavaObject
var activity: JavaObject
var layout_params: JavaClass
var view: JavaClass
var insets_controller: JavaObject
var window_insets_controller: JavaClass
var window_insets_types: JavaClass


func _ready() -> void:
	if Engine.has_singleton("AndroidRuntime"):
		android_runtime = Engine.get_singleton("AndroidRuntime")
		activity = android_runtime.getActivity()
		window = activity.getWindow()
		layout_params = JavaClassWrapper.wrap("android.view.WindowManager$LayoutParams")
		view = JavaClassWrapper.wrap("android.view.View")
		insets_controller = window.getInsetsController()
		window_insets_controller = JavaClassWrapper.wrap("android.view.WindowInsetsController")
		window.addFlags(layout_params.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)


func toggle_system_bars_transparency(transparent: bool, dark: bool = false) -> void:
	if transparent:
		activity.runOnUiThread(
			android_runtime.createRunnableFromGodotCallable(make_system_bars_transparent)
		)
	else:
		activity.runOnUiThread(
			android_runtime.createRunnableFromGodotCallable(make_system_bars_opaque)
		)

	if dark:
		insets_controller.setSystemBarsAppearance(
			0, window_insets_controller.APPEARANCE_LIGHT_STATUS_BARS
		)
	else:
		insets_controller.setSystemBarsAppearance(
			window_insets_controller.APPEARANCE_LIGHT_STATUS_BARS,
			window_insets_controller.APPEARANCE_LIGHT_STATUS_BARS
		)


func make_system_bars_transparent() -> void:
	# Allow UI to render behind status bar
	window.getDecorView().setSystemUiVisibility(view.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)

	# Make the system bars transparent
	window.setStatusBarColor(Color.TRANSPARENT.to_argb32())
	window.setNavigationBarColor(Color.TRANSPARENT.to_argb32())


func make_system_bars_opaque() -> void:
	# Allow UI to render behind status bar
	window.getDecorView().setSystemUiVisibility(view.SYSTEM_UI_FLAG_LAYOUT_STABLE)

	# Make the system bars transparent
	window.setStatusBarColor(Color.TRANSPARENT.to_argb32())
	window.setNavigationBarColor(Color.TRANSPARENT.to_argb32())


func get_window_insets() -> Dictionary:
	window_insets_types = JavaClassWrapper.wrap("android.view.WindowInsets$Type")

	var rootWindowInsets = window.getDecorView().getRootWindowInsets()

	var system_bars = window_insets_types.systemBars()

	return Utils.insets_to_dict(rootWindowInsets.getInsets(system_bars))
