extends Node

@export var enemy_scene: PackedScene
var score: int = 0
var enemy_count: int = 0
var damage: int = 0

var enemy_spawn_location: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()
	$HUD/Health.max_value = $Tower.health
	enemy_spawn_location = $EnemyPath/EnemySpawnLocation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_timer_timeout():
	print("Spawn timeout")
	spawn_enemy()

func _on_score_timer_timeout():
	print("Score timeout")
	score += 1
	$HUD/Score.text = str(score)

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
	enemy.prepare(get_new_spawn_location(), $Tower)
	$Enemies.add_child(enemy)
	
	enemy_count += 1
	$HUD/EnemyCount.text = str(enemy_count)

func get_new_spawn_location() -> Vector2:
	enemy_spawn_location.progress_ratio = randf()
	return enemy_spawn_location.position

func _on_tower_death():
	game_over()

func deal_damage_to_tower(damage: int):
	print("Tower is under siege!!")
	$Tower.take_damage(damage)

func _on_tower_damage_taken():
	$HUD/Health.value = $Tower.health
