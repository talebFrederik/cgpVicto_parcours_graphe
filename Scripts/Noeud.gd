extends Node2D

export(bool) var visite = false
export(Color) var couleur
onready var case = $Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	case.color = couleur

func _reset_color():
	case.color = couleur
	
func _visite():
	case.color = Color("69c47b")
