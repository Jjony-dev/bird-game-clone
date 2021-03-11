extends Node2D

signal passed

export var velocity_scroll: float = -50.0
export var range_offset_y: float = 200.0

onready var offset:= $PositionOffset


func start() -> void:
	set_physics_process(true)


func reset_position() -> void:
	offset.position.x = 0
	offset.position.y = rand_range(-range_offset_y, range_offset_y)


func _ready() -> void:
	randomize()
	set_physics_process(true)


func _physics_process(delta: float) -> void:
	offset.position.x += velocity_scroll * delta
	if $PositionOffset/Area2D.global_position.x < get_parent().position.x:
		reset_position()


func _on_Area2D_area_exited(_area: Area2D) -> void:
	emit_signal("passed")
