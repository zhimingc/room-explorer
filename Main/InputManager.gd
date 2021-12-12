extends Spatial

var ray_length = 1000
var player : KinematicBody

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("lmb")):
		var camera = get_viewport().get_camera()
		var mouse_pos = get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * ray_length
		var space_state = get_world().get_direct_space_state()
		var results =  space_state.intersect_ray(from, to)
		if results.size() > 0:
			var ray_pos = results["position"]
			print(ray_pos)
			player.translation = ray_pos + Vector3(0, 1.0, 0)
	pass
