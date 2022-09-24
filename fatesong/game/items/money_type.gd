extends ItemType


class_name MoneyType


var amount : int setget set_amount, get_amount

func _init():
	set_amount(0)


func set_amount(new_amount: int):
	if new_amount >= 0:
		amount = new_amount


func get_amount() -> int:
	return amount


func increment(change: int):
	amount += change


func decrement(change: int):
	amount -= change
