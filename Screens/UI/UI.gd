extends Control

onready var score := $VBoxContainer/MarginContainer/VBoxContainer/Score
onready var highscore := $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Best
onready var container_info := $VBoxContainer/CenterContainer
onready var info := $VBoxContainer/CenterContainer/Info
onready var timer := $VBoxContainer/CenterContainer/Timer


func set_score(value: int) -> void:
	score.text = str(value)


func set_highscore(value: int) -> void:
	highscore.text = str(value)


func hide_info() -> void:
	timer.stop()
	container_info.visible = false


func show_info() -> void:
	timer.start()
	container_info.visible = true


func _on_Timer_timeout() -> void:
	info.modulate.a = 0.0 if info.modulate.a != 0.0 else 1.0
