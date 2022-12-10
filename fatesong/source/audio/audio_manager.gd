# audio_manager.gd - Elijah Burke


# AutoLoad AudioManager
extends Node


const _footstep := preload("res://fatesong/resources/audio/players/footstep.wav")
const _aggro := preload("res://fatesong/resources/audio/enemies/Goblin_Aggro.wav")
const _death := preload("res://fatesong/resources/audio/enemies/Goblin_Death.wav")
const _button := preload("res://fatesong/resources/audio/menus/Button.wav")
const _laser := preload("res://fatesong/resources/audio/projectiles/Laser.wav")
const _song := preload("res://fatesong/resources/audio/music/globs_of_goop.wav")
var footstep_stream: AudioStreamPlayer
var aggro_stream: AudioStreamPlayer
var death_stream: AudioStreamPlayer
var button_stream: AudioStreamPlayer
var laser_stream: AudioStreamPlayer
var song_stream: AudioStreamPlayer


func _init() -> void:
    footstep_stream = AudioStreamPlayer.new()
    aggro_stream = AudioStreamPlayer.new()
    death_stream = AudioStreamPlayer.new()
    button_stream = AudioStreamPlayer.new()
    laser_stream = AudioStreamPlayer.new()
    song_stream = AudioStreamPlayer.new()
    self.add_child(footstep_stream)
    self.add_child(aggro_stream)
    self.add_child(death_stream)
    self.add_child(button_stream)
    self.add_child(laser_stream)
    self.add_child(song_stream)
    footstep_stream.stream = _footstep
    aggro_stream.stream = _aggro
    death_stream.stream = _death
    button_stream.stream = _button
    laser_stream.stream = _laser
    song_stream.stream = _song


func footstep() -> void:
    if not footstep_stream.is_playing():
        footstep_stream.play()


func stop_footstep() -> void:
    footstep_stream.stop()


func aggro() -> void:
    if not aggro_stream.is_playing():
        aggro_stream.play()


func death() -> void:
    if not death_stream.is_playing():
        death_stream.play()


func button() -> void:
    if not button_stream.is_playing():
        button_stream.play()


func laser() -> void:
    var stream = AudioStreamPlayer.new()
    stream.stream = _laser
    self.add_child(stream)
    stream.play()
    if not stream.is_playing():
        self.remove_child(stream)


func song() -> void:
    if not song_stream.is_playing():
        song_stream.play()
