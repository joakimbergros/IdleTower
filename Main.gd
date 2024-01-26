extends Node

@export var enemy_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	var spawn_location = $EnemyPath/EnemySpawnLocation
	spawn_location.progress_ratio = randf()
	
	var target_location = $Tower.position
	
	enemy.look_at(target_location)
	enemy.position = spawn_location.position
	enemy.linear_velocity = Vector2(1, 2)
	
	get_node("Enemies").add_child(enemy)
