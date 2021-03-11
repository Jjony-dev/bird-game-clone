extends Node2D

onready var player := $Player setget , get_player
onready var background := $Background setget , get_background
onready var obstacle := $Obstacle setget , get_obstacle


func get_player() -> Node:
	return player


func get_background() -> Node:
	return background


func get_obstacle() -> Node:
	return obstacle
