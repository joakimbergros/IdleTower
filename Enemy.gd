extends CharacterBody2D

signal hit

@export var health: int
@export var speed: int

var target_position: Vector2
var navigation_agent: NavigationAgent2D

func _ready():
	navigation_agent = $NavigationAgent2D
	navigation_agent.target_position = target_position


func _process(delta):
	var current_location = global_transform.origin
	var next_location = navigation_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = new_velocity
	move_and_slide()


func set_target_location(target_location: Vector2):
	target_position = target_location


func _on_body_entered(body):
	if health == 0:
		queue_free()
		return
	hit.emit()
