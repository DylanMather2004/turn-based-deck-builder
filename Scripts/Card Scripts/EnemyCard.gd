class_name EnemyCard
extends BaseCard
func use_failed():
	super.use_failed()
	owner_character.cannot_use.append(self)
	owner_character.hand.erase(self)
	position=reset_pos
