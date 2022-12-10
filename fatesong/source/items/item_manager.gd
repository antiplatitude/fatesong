# item_manager.gd - Elijah Burke


# AutoLoad ItemManager
extends Node


var _item_registry = {}


func _ready() -> void:
    # Register Items
    register(Item.new("test_item", CylinderMesh.new(), ImageTexture.new()))


func get_item(name: String) -> Item:
    return _item_registry[name]


func register(item: Item) -> void:
    _item_registry[item.get_name()] = item


func spawn_item(name: String, location: Vector3) -> void:
    var world_item := WorldItem.new(ItemManager.get_item(name))
    get_tree().root.add_child(world_item)
    world_item.global_translation = location
