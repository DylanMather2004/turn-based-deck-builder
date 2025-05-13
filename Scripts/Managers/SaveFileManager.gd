class_name SaveManager
extends Node

func _save_deck(deck:Array,path:String):
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_var(deck)
	file.close()
func _load_deck(path:String):
	var deck:Array
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path,FileAccess.READ)
		for i in file.get_var():
			deck.append(load(i))
		file.close()
		return deck 
