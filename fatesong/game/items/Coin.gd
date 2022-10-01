extends Area2D


class_name Coin


func _on_Coin_body_entered(body):
	body.call("add_coin")
	queue_free()
