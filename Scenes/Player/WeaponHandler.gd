# Author: Sheshire | MIT Licensed.
extends Node2D
class_name WeaponHandler


# Signals

# enums
enum ANIMATIONS {Swing}

# Constants

# Node References
var area := Area2D.new()
var shape := CollisionShape2D.new()
var texture := Sprite2D.new()

# Exported Variables
@export var weapon: Weapon:
	set(new):
		weapon = new
		if shape.shape:
			if !weapon:
				weapon = Weapon.new()
			shape.position = weapon.hitbox_offset
			shape.shape.size = weapon.hitbox_size
			texture.texture = weapon.texture if weapon.texture else weapon.icon
@export var auto := false: ## auto attacks with a delay
	set(new):
		auto = new
		if !is_attacking and auto:
			attack()

# Properties
var is_attacking := false:
	set(new):
		is_attacking = new
		visible = new
		area.monitorable = new
		area.monitoring = new
var tween: Tween


# Public Functions
func attack() -> void:
	#todo lock player_rotation
	if is_attacking:
		return
	is_attacking = true
	if tween:
		tween.stop()
	tween = create_tween()
	tween.finished.connect(_on_animation_finished)
	tween.set_speed_scale(weapon.speed)

	match weapon.animation:
		ANIMATIONS.Swing:
			area.rotation = -PI /2
			tween.tween_property(self, "modulate", Color.WHITE, 0.2)
			tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 0.8).set_delay(0.2)
			tween.parallel().tween_property(area, "rotation", PI /2, 1.0)



# Logic
func _ready() -> void:
	_setup()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_attack"):
		attack()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == owner:
		return
	if body is StaticObject or body is Entity:
		body.damage(weapon.damage)


func _on_animation_finished() -> void:
	is_attacking = false
	if auto:
		await get_tree().create_timer(1).timeout
		attack()

# ==================================
# Private Section
# ==================================


func _setup() -> void:
	shape.shape = RectangleShape2D.new()
	area.collision_layer = 32
	area.collision_mask = 32
	area.body_entered.connect(_on_area_2d_body_entered)
	area.add_child(shape)
	area.add_child(texture)
	add_child(area)

	modulate = Color.TRANSPARENT
	weapon = weapon
	is_attacking = false
