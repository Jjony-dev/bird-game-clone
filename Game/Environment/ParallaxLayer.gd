tool
extends Node2D

export var velocity_scroll: float = -100
export var preview: bool = false setget set_preview, is_preview
export(Texture) onready var texture_left setget set_texture_left
export(Texture) onready var texture_right setget set_texture_right

var sprite_left := "SpriteLeft"
var sprite_right := "SpriteRight"


func set_preview(_preview: bool) -> void:
	preview = _preview
	set_process(preview)
	if not preview and Engine.editor_hint:
		reset()


func is_preview() -> bool:
	return preview


func set_texture_left(_texture: Texture) -> void:
	texture_left = _texture
	if Engine.editor_hint and get_node_or_null(sprite_left):
		get_node(sprite_left).texture = texture_left


func set_texture_right(_texture: Texture) -> void:
	texture_right = _texture
	if Engine.editor_hint and get_node_or_null(sprite_right):
		get_node(sprite_right).texture = texture_right
		if get_node_or_null(sprite_left):
			reset()


func reset() -> void:
	$SpriteLeft.position = Vector2.ZERO
	$SpriteRight.position.x = $SpriteLeft.position.x \
			 + $SpriteLeft.texture.get_width() * $SpriteLeft.scale.x


func _ready() -> void:
	$SpriteLeft.texture = texture_left
	$SpriteRight.texture = texture_right
	reset()
	set_process(false)


func _process(delta: float) -> void:
	if not $SpriteLeft.texture or not $SpriteRight.texture:
		return
	scroll_layer(delta)


func scroll_layer(delta: float) -> void:
	var layer_1_l := get_child(0)
	var layer_1_r := get_child(1)
	layer_1_l.position.x += velocity_scroll * delta
	layer_1_r.position.x += velocity_scroll * delta
	
	if layer_1_l.position.x + layer_1_l.texture.get_width() * layer_1_l.scale.x < position.x:
		layer_1_l.position.x = layer_1_r.position.x + layer_1_r.texture.get_width() * layer_1_r.scale.x
	if layer_1_r.position.x + layer_1_r.texture.get_width() * layer_1_r.scale.x < position.x:
		layer_1_r.position.x = layer_1_l.position.x + layer_1_l.texture.get_width() * layer_1_l.scale.x


func start_scroll() -> void:
	set_process(true)


func stop_scroll() -> void:
	set_process(false)
