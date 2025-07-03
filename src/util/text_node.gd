@tool class_name TextNode extends Node2D

const DEFAULT_SIZE = 5
const DEFAULT_FONT: Font = preload("res://gfx/font/TextNodeFont.png")
const DEFAULT_SHADER = preload("res://shader/text_node_font.gdshader")

@export var text: String
@export var cycle_speed := 1.0

var _time: float

func _ready():
	var mat = ShaderMaterial.new()
	mat.shader = DEFAULT_SHADER
	material = mat

func _process(delta):
	_time += delta * cycle_speed
	material.set_shader_parameter("time", int(_time))

func _draw(font = DEFAULT_FONT, font_size = DEFAULT_SIZE):
	material.set_shader_parameter("offset", Vector2(text.length() * font_size * -0.5, 0))
	draw_string(font, Vector2.ZERO, text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size)
