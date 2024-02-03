extends RigidBody2D

const Tower = preload("res://Tower.gd")

signal hit(damage: int)

@export var health: int = 100
@export var speed: int = 200
@export var damage: int = 1
@export var hit_cooldown: float = 1.0

var target_tower: Tower
var viewport: Vector2 = Vector2.ZERO

func _ready():
	$HitTimer.wait_time = hit_cooldown

func _physics_process(delta):
	if target_tower == null:
		return
	
	# Get the direction towards the middle of the screen
	var direction_to_middle = (target_tower.position - global_position).normalized()
	# Rotate the enemy towards the middle
	look_at(global_position + direction_to_middle)
	# Move the enemy in the calculated direction
	linear_velocity = direction_to_middle * speed
	$Sprite2D.flip_v = position.x > target_tower.position.x
	
	if position.distance_to(target_tower.position) <= 10:
		$HitTimer.start()

func prepare(spawn_position: Vector2, attack_target: Tower):
	position = spawn_position
	target_tower = attack_target

func _on_hit_timer_timeout():
	target_tower.take_damage(damage)
	#hit.emit(damage)

func attack(target: Tower):
	target_tower = target



