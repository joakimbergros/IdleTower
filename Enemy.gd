extends RigidBody2D

signal hit

@export var health: int
@export var speed: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start(input_position):
	position = input_position

func _on_body_entered(body):
	if health == 0:
		queue_free()
		return
	hit.emit()
