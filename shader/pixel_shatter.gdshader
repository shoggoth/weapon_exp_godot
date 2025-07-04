shader_type canvas_item;

uniform vec2 explode_amount;

void vertex() {
	VERTEX *= explode_amount;
}

uniform vec2 number_of_splits;

void fragment() {
	vec2 ef = explode_amount;										// Explode scale factor.
    vec2 ns = number_of_splits;										// Number of splits.

    vec2 tc = UV * ef;
    vec2 tw = vec2(1.0 / (ns.x + 1.0), 1.0 / (ns.y + 1.0));		// Textured band width.
    vec2 sw = vec2((ef.x - 1.0) / ns.x, (ef.y - 1.0) / ns.y);		// Spacing band width.

    // Calculate the modulo m and discard pixels that are in the spacing band.
    vec2 m = vec2(mod(tc.x, tw.x + sw.x), mod(tc.y, tw.y + sw.y));
    if (m.x > tw.x || m.y > tw.y) discard;

    // Calculate the texture offset d for the band.
    vec2 d = vec2(floor(tc.x / (tw.x + sw.x)) * (1.0 / (ns.x + 1.0)), floor(tc.y / (tw.y + sw.y)) * (1.0 / (ns.y + 1.0)));

    COLOR = vec4(texture(TEXTURE, vec2(m.x + d.x, m.y + d.y)).rgb, COLOR.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
