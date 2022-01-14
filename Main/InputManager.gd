extends Spatial

var ray_length = 1000
var player : Player
var cameraCont : CameraController

var oldMousePos

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	cameraCont = get_viewport().get_camera()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("rmb"):
		var camera = get_viewport().get_camera()
		var mouse_pos = get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * ray_length
		var space_state = get_world().get_direct_space_state()
		var results =  space_state.intersect_ray(from, to)
		if results.size() > 0:
			var ray_pos = results["position"]
			var target_location = ray_pos
			player.move_to_location(target_location)
	
	# camera controls
	if Input.is_action_just_pressed("lmb"):
		oldMousePos = get_viewport().get_mouse_position()
	if Input.is_action_pressed("lmb"):
		var curMousePos = get_viewport().get_mouse_position()
		var mouseOffset = curMousePos - oldMousePos
		cameraCont.orbit_cam(mouseOffset.x)
		oldMousePos = get_viewport().get_mouse_position()		

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				# call the zoom function
				cameraCont.zoom_cam(-1)
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				cameraCont.zoom_cam(1)				
		
