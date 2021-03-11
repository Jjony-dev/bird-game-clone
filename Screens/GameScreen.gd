extends Node

onready var add_score_sfx := $AddScore
onready var game := $CenterContainer/ViewportContainer/Viewport/Game
onready var player: Node2D = game.get_player()
onready var obstacle: Node2D = game.get_obstacle()
onready var backgroud: Node2D = game.get_background()
onready var ui := $CenterContainer/ViewportContainer/Viewport/UI
onready var popup := $CenterContainer/ViewportContainer/Viewport/PopupDialog

var score_best = 0
var score_current = 0

func _ready() -> void:
	get_tree().paused = true
	score_best = HighcoreData.get_highscore()
	popup.set_best(score_best)
	ui.set_highscore(score_best)
	var err: int = player.connect("dead", self, "_on_Player_dead")
	if err:
		print_debug("Error conecting player signal errN:" + str(err))
	err = obstacle.connect("passed", self, "_on_Obstacle_passed")
	if err:
		print_debug("Error conecting player signal errN:" + str(err))
	set_process_unhandled_input(true)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		get_tree().paused = false
		ui.hide_info()


func _on_Obstacle_passed() -> void:
	if not player.dead:
		score_current += 1
		ui.set_score(score_current)
		add_score_sfx.play()


func _on_Player_dead() -> void:
	backgroud.stop_scroll()
	set_process_unhandled_input(false)
	if score_current > score_best:
		HighcoreData.save(score_current)
		popup.new_record(score_current)
	else:
		popup.set_score(score_current)
	popup.popup()


func _on_PopupDialog_retry() -> void:
	var err: int = get_tree().reload_current_scene()
	if err:
		print_debug("Error reload scene")
