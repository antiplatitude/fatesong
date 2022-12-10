# world_item.gd - Elijah Burke


# Physical representation of an item in the world.
class_name WorldItem
extends Spatial


var _item: Item setget set_item, get_item
var _pickup_proximity: float

var _item_mesh: MeshInstance
var _pickup_area: Area


func _init(item := Item.new()) -> void:
    _item = item
    _pickup_proximity = 1.0

    _item_mesh = MeshInstance.new()
    _item_mesh.mesh = _item.get_mesh()
    _pickup_area = Area.new()
    _pickup_area.shape_owner_add_shape(
            _pickup_area.create_shape_owner(_pickup_area),
            SphereShape.new()
    )
    _pickup_area.collision_layer = 0b100 # Layer 3 (3rd LSB) = 2^(3 - 1) = 4
    _pickup_area.collision_mask = 0b10 # Layer 2 (2nd LSB) = 2^(2 - 1) = 2
    _pickup_area.connect("body_entered", self, "_on_PickupArea_body_entered")


# Set the item to be represented.
# Returns true on success, returns false and sets to default item on failure.
func set_item(item: Item) -> bool:
    if item != null:
        _item = item
        return true
    else:
        _item = Item.new()
        return false


# Returns the item this world item represents
func get_item() -> Item:
    return _item


# Called when some body is within pickup proximity.
func _on_PickupArea_body_entered(body) -> void:
    if body.has_method("pickup_item"):
        body.pickup_item(self)
