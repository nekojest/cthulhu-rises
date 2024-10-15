extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var is_attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$CollisionShape2D.disabled = false	
	$CthulhuSprite.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor_only():
		print("should play")
		$CthulhuSprite.play("fly")
		velocity.y = JUMP_VELOCITY
		
	# Play short attack animation and enable hitbox	
	if Input.is_action_just_pressed("short_atk")  and is_on_floor():
		$CthulhuSprite.play("short_atk")
		$CthulhuSprite.set_speed_scale(3)
		is_attacking = true
		

	var direction = Input.get_axis("move_left", "move_right")
	if direction and !is_attacking :
		velocity.x = direction * SPEED
		if velocity.x < 0:
			$CthulhuSprite.flip_h = true
		else:
			$CthulhuSprite.flip_h = false
			
		if velocity.y == 0:
			$CthulhuSprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if !direction and !is_attacking and velocity.y == 0:
		$CthulhuSprite.play("idle")
		

	# Do not remove; allows the body to move
	move_and_slide()


func _on_cthulhu_sprite_animation_finished() -> void:
	var current_anim = $CthulhuSprite.get_animation()
	if current_anim == "short_atk":
		$CthulhuSprite.set_speed_scale(1.5)
		is_attacking = false
		$CthulhuSprite.play("idle")
