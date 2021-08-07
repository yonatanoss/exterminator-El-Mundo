extends Node

var skills = {
	"_max_level": 20,
	"mining": {
		"_name": "Mining",
		"level": 1,
		"xp": 0
	},
	"wood": {
		"_name": "Wood",
		"level": 1,
		"xp": 0
	}
}

var tools = {
	"axe": {
		"name": "Bronze Axe",
		"hit_force": (100 / 3) + 1
	},
	"pickaxe": {
		"name": "Bronze Pickaxe",
		"hit_force": (100 / 3) + 1
	}
}

func _ready():
	#_push_to_inventory("ore_copper", 9)
	#_push_to_inventory("log_standard", 8)
	#_push_to_inventory("ore_copper", 7)
	pass


func get_level_xp_caps(skill_key: String):
	if self.skills.has(skill_key):
		if self.skills[skill_key].level < 1:
			self.skills[skill_key].level = 1
		return {
			"current": pow((self.skills[skill_key].level * 2), 3),
			"previous": pow(((self.skills[skill_key].level - 1) * 2), 3)
		}
	return null

func add_xp(skill_key: String, amount: int = 1):
	if self.skills.has(skill_key):
		
		if self.skills[skill_key].level < self.skills._max_level:
			self.skills[skill_key].xp += amount
			var xp_caps = get_level_xp_caps(skill_key)
			var runs = 0;
			
			if xp_caps != null:
				while self.skills[skill_key].xp >= xp_caps.current and runs <= self.skills._max_level:
					runs += 1
					if xp_caps != null:
							if self.skills[skill_key].xp >= xp_caps.current:
								self.skills[skill_key].level += 1
								xp_caps = get_level_xp_caps(skill_key)
								if self.skills[skill_key].level >= self.skills._max_level:
									self.skills[skill_key].xp = xp_caps.previous
