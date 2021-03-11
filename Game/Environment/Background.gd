extends Node2D

export var velocity_scroll: float = -100

onready var layer_0 := $ParallaxLayer
onready var layer_1 := $ParallaxLayer2
onready var layer_2 := $ParallaxLayer3


func _ready() -> void:
	layer_0.start_scroll()
	layer_1.start_scroll()
	layer_2.start_scroll()

func stop_scroll() -> void:
	layer_0.stop_scroll()
	layer_1.stop_scroll()
	layer_2.stop_scroll()
