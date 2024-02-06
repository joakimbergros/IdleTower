extends Area2D

class_name Attack

signal hit(damage: int)

@export var damage: int = 1
@export var cooldown: float = 1.0

func _ready():
	$Cooldown.wait_time = cooldown

func _process(delta):
	pass

func target_is_in_range():
	$Cooldown.start()

func _on_cooldown_timeout():
	hit.emit(damage)
