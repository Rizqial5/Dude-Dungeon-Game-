extends Control


onready var parallax = $ParallaxBackground

#var x_pos = 0
##func _ready():
#
#
func _process(delta):
	parallax.scroll_offset.x -= 100 * delta
	
