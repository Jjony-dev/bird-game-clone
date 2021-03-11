extends PopupDialog

signal retry
#signal quit

onready var score := $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Score
onready var best := $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Best
onready var new_record_message := $NinePatchRect/MarginContainer/VBoxContainer/NewRecord
onready var button_retry := $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer2/Retry
onready var button_quit := $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer2/Quit
onready var timer := $Timer
onready var tween := $Tween
onready var new_record_sfx := $NewRecordSFX

var disable = true

func set_best(value: int) -> void:
	best.text = str(value)


func set_score(value: int) -> void:
	score.text = str(value)


func new_record(value: int) -> void:
	set_score(value)
	set_best(value)
	new_record_sfx.play()
	timer.start()


func popup(rect2: Rect2 = Rect2( 0, 0, 250, 250) ) -> void:
	var temp : = rect_position
	.popup(rect2)
	rect_position = temp
	tween.interpolate_property(self, "rect_scale", Vector2(0.0, 0.0), Vector2(1.0, 1.0), 0.5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()


func _on_Timer_timeout() -> void:
	new_record_message.modulate.a = 0.0 if new_record_message.modulate.a != 0.0 else 1.0


func _on_Retry_pressed() -> void:
	if disable:
		return
	emit_signal("retry")


func _on_Quit_pressed() -> void:
	if disable:
		return
	get_tree().quit()


func _on_Tween_tween_all_completed() -> void:
	disable = false
