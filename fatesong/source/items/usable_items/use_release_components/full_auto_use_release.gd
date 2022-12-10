# full_auto_use_release.gd - Elijah Burke


class_name FullAutoUseRelease
extends UseReleaseComponent


var _counterpart: FullAutoUsePress


func _init(counterpart: FullAutoUsePress) -> void:
    _counterpart = counterpart


func behavior() -> void:
    _counterpart.unused()
