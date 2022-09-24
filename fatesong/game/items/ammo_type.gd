extends ItemType


class_name AmmoType


var amount : int setget set_ammo, get_ammo


func set_ammo(new_amount: int):
	if new_amount > 0:
		amount = new_amount


func get_ammo() -> int:
	return amount


func increment(change: int):
	amount += change


func decrement(change: int):
	amount -= change
