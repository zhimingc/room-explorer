extends Camera

class_name CameraController

export var cameraArm = Vector3(18, 20, 15)
var player
var targetRotation = 0
var rotationSpeed = 0.25
var armRotation = 0
var currentArm
var originalArm
var currentLocation
var currentZoom = 0
var targetZoomVec = Vector3()
var zoomInterval = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	currentArm = cameraArm
	currentLocation = translation
	targetZoomVec = cameraArm
	originalArm = cameraArm
	
func _process(delta):
	# camera orbit translation
	currentLocation = lerp(currentLocation, player.translation + currentArm, 0.5)
	translation = currentLocation

	# camera orbit rotation
	look_at(player.translation, Vector3.UP)	
	armRotation = lerp(armRotation, targetRotation, 0.2)
	currentArm = cameraArm.rotated(Vector3.UP, deg2rad(armRotation))
	
	# camera zoom
	cameraArm = lerp(cameraArm, targetZoomVec, 0.5)
	
func zoom_cam(amt):
	print(currentZoom)
	currentZoom += amt
	targetZoomVec = originalArm + currentZoom * zoomInterval * cameraArm.normalized()
	
func orbit_cam(amount):
	targetRotation += amount * rotationSpeed
