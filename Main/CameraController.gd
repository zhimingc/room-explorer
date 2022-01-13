extends Camera

class_name CameraController

export var cameraArm = Vector3(18, 20, 15)
var player
var targetRotation = 0
var rotationSpeed = 0.25
var armRotation = 0
var currentArm

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	currentArm = cameraArm
	
func _process(delta):
	# camera orbit translation
	translation = player.translation + currentArm

	# camera orbit rotation
	look_at(player.translation, Vector3.UP)	
	armRotation = lerp(armRotation, targetRotation, 0.2)
	currentArm = cameraArm.rotated(Vector3.UP, deg2rad(armRotation))
	
func orbit_cam(amount):
	targetRotation += amount * rotationSpeed
