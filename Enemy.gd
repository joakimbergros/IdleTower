extends RigidBody2D

signal hit

@export var health: int = 100
@export var speed: int = 200

var viewport: Vector2 = Vector2.ZERO

func _ready():
	viewport = Vector2(get_viewport_rect().size) / 2

func _physics_process(delta):
	var view
	# Get the direction towards the middle of the screen
	var direction_to_middle = (viewport - global_position).normalized()
	# Rotate the enemy towards the middle
	look_at(global_position + direction_to_middle)
	# Move the enemy in the calculated direction
	linear_velocity = direction_to_middle * speed
	$Sprite2D.flip_v = position.x > viewport.x

func _on_body_entered(body):
	if health == 0:
		queue_free()
		return
	hit.emit()
