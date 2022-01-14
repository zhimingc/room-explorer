extends KinematicBody

class_name Player

export var moveLerpSpeed = 0.05
export var maxAccel = .5
var targetLocation
var velocity = Vector3()
var drag = 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	targetLocation = translation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# update physics
	var moveVec = targetLocation - translation	
	var accel = clamp_acceleration(moveVec * moveLerpSpeed)
	velocity *= drag
	velocity += accel
	# update movement lerp
	translation += velocity

func move_to_location(location):
	targetLocation = location

func clamp_acceleration(accel : Vector3):
	if accel.length() > maxAccel:
		return accel.normalized() * maxAccel
	return accel
