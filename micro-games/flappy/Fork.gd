extends StaticBody2D

signal collision_detected

func _ready():
	$Area2D.connect("body_entered", self, "_on_collision_detected")

func _on_collision_detected(body):
    if body.get_name() == "Wizard":
        emit_signal("collision_detected")