shader_type canvas_item;

uniform vec2 offset;
varying flat float pos;

const int num_colours = 3;

void vertex() {
	pos = VERTEX.x / float(-num_colours);
	VERTEX += offset;
}

uniform int time;

void fragment() {
	vec4 colours[num_colours] = {
		vec4(0.7, 0.1, 0.1, 1.0),
		vec4(0.1, 0.6, 0.1, 1.0),
		vec4(0.1, 0.1, 1.0, 1.0)
	};
	vec4 c = texture(TEXTURE, UV);
	float p = mod(pos, 1.0);
	COLOR = c * ((colours[time % num_colours] * (step(0, p) - step(0.33, p)))
	+ (colours[(time + 1) % num_colours] * (step(0.33, p) - step(0.66, p)))
	+ (colours[(time + 2) % num_colours] * (step(0.66, p) - step(1.0, p))));
}