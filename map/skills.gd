extends Node2D

const Skills = preload("res://assets/ui/Skills.tscn")

func _ready():
	var skills_instance = Skills.instance()
	self.add_child(skills_instance)
