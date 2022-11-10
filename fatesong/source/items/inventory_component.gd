# inventory_component.gd - Elijah Burke


class_name InventoryComponent
extends Node


const MAX_ITEMS := 15

var _items: Array


func _init() -> void:
	_items = []


# Add item to inventory.
# Returns true on success, false otherwise.
func add_item(item: Item) -> bool:
	if _items.size() < MAX_ITEMS:
		_items.push_back(item)
		return true
	else:
		return false


# Remove specified item from inventory.
# Returns true on success, false otherwise.
func remove_item(item: Item) -> bool:
	if _items.has(item):
		_items.erase(item)
		return true
	else:
		return false


# Remove item at specified index from inventory.
# Returns true on success, false otherwise.
func remove_at(index: int) -> bool:
	if _items[index] != null:
		_items.remove(index)
		return true
	else:
		return false


# Returns true if another item can be added to the inventory, false otherwise.
func has_space() -> bool:
	if _items.size() == MAX_ITEMS:
		return false
	else:
		return true
