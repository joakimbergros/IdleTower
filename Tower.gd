extends StaticBody2D
class_name Tower

signal death
signal damage_taken()

@export var health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func take_damage(damage: int):
	if health <= 0:
		death.emit()
		return
	health -= damage
	damage_taken.emit()
