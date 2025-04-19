extends BaseCard
func use_failed():
	owner_character.cannot_use.append(self)
	owner_character.hand.erase(self)
	queue_free()
