extends Node

@export var enemy_scene: PackedScene
var score
var spawn_location
var tower_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_location = $EnemyPath/EnemySpawnLocation
	tower_position = $Tower.position
	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_timer_timeout():
	print("Spawn timeout")
	spawn_enemy()

func _on_score_timer_timeout():
	print("Score timeout")
	score += 1

func _on_start_timer_timeout():
	print("Start timeout")
	new_game()


func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	
func new_game():
	score = 0
	$ScoreTimer.start()
	$EnemyTimer.start()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.set_target_location(tower_position)
	get_node("Enemies").add_child(enemy)
