tool
extends Node2D


export var sprite: Texture


func _ready() -> void:
	$Sprite.texture = sprite


func _get_configuration_warning() -> String:
	if not sprite:
		return "Must set sprite"
	else:
		return ""
