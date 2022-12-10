# usable_item.gd - Elijah Burke


# Item that can be used by characters
class_name UsableItem
extends Node


var _item: WorldItem
var _item_data
var _press_components: Array
var _release_components: Array


func _init(muzzle: Spatial, player) -> void:
    _item_data = {}
    _item_data["muzzle"] = muzzle
    _item_data["player"] = player
    _press_components = []
    _release_components = []


func _ready() -> void:
    get_parent().get_node("PlayerMovementComponent").connect("item_used", self, "use_behavior")
    get_parent().get_node("PlayerMovementComponent").connect("item_unused", self, "release_behavior")


func _enter_tree() -> void:
    var press = FullAutoUsePress.new(_item_data["muzzle"], _item_data["player"])
    self.add_component(press)
    self.add_component(FullAutoUseRelease.new(press))


func add_component(component: ItemBehaviorComponent) -> bool:
    if component is UsePressComponent:
        self.add_child(component)
        _press_components.push_back(component)
        return true
    elif component is UseReleaseComponent:
        self.add_child(component)
        _release_components.push_back(component)
        return true
    else:
        return false


func use_behavior() -> void:
    for behavior in _press_components:
        behavior.behavior()


func release_behavior() -> void:
    for behavior in _release_components:
        behavior.behavior()
