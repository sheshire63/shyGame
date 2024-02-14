# Author: Sheshire | MIT Licensed.
extends Node2D
class_name WeaponHandler


# Signals

# enums

# Constants

# Node References
@onready var animation := $AnimationPlayer#todo we need to make this via tween
@onready var shape := $Area2D/CollisionShape2D
@onready var texture := $Area2D/Sprite2D

# Exported Variables
@export var weapon: Weapon:
	set(new):
		weapon = new
		if shape:
			if weapon:
				shape.position = weapon.hitbox_offset
				shape.shape.size = weapon.hitbox_size
				texture.texture = weapon.texture if weapon.texture else weapon.icon
			else:#todo use a template empty weapon for this
				shape.position = Vector2.ZERO
				shape.shape.size = Vector2(4,4)
				texture.texture = null

# Properties


# Public Functions
func swing() -> void:
	#todo lock player_rotation
	if animation.is_playing():
		return
	animation.play("Swing", -1, weapon.speed if weapon else 1.0)


# Logic
func _ready() -> void:
	weapon = weapon


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_attack"):
		swing()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticObject:
		body.damage(3.0)

# ==================================
# Private Section
# ==================================




