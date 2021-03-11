extends Node2D

signal dead

const VELOCITY_JUMP := -600.0
const GRAVITY := 1500.0

onready var body := $BodyHitbox
onready var anim_sprite := $BodyHitbox/AnimatedSprite
onready var sounds := $Sounds

var velocity: Vector2 = Vector2.ZERO
var dead:bool = false

func die() -> void:
	dead = true
	sounds.get_node("HitSFX").play()
	emit_signal("dead")
	anim_sprite.play("Hit")
	get_tree().paused = true

func jump() -> void:
	velocity.y = VELOCITY_JUMP
	anim_sprite.frame = 0
	anim_sprite.play("Jump")
	sounds.get_node("JumpSFX").play()


func _ready() -> void:
	anim_sprite.play("Wait")


# warning-ignore:unused_argument
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and not dead:
		jump()


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	body.position += velocity * delta
	if anim_sprite.animation != "Fall" and velocity.y > 0:
		anim_sprite.play("Fall")


func _on_BodyHitbox_body_entered(_body: Node) -> void:
	die()
