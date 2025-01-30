extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CultistSprite.set_speed_scale(2)
	$CultistSprite.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# $CultistSprite.position.x -= 1.2
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("Cthulhu entered")
