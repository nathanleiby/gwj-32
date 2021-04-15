extends Control

# func _ready():
#     var button = Button.new()
#     button.text = "Click me"
#     button.connect("pressed", self, "_button_pressed")
#     add_child(button)

# func _on_Button_pressed(extra_arg_0: String) -> void:
#     print(extra_arg_0)


func _on_Button_pressed(zone):
	var params = {
		'zone': zone,
	}
	Game.change_scene("res://scenes/gameplay/gameplay.tscn", params)
