shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform float speed = 1.0;
uniform vec4 smokeColor : source_color;
uniform float energyFactor = 0.5;
uniform float alphaFactor = 30.0;

void fragment() {
	vec2 uv1 = vec2(UV.x + TIME * speed, UV.y);
	vec2 uv2 = vec2(UV.x - TIME * speed, UV.y);
	vec2 uv3 = vec2(UV.x, UV.y + TIME * speed);
	
	float noise_r = texture(noise, uv1).r;
	float noise_g = texture(noise, uv2).g;
	float noise_b = texture(noise, uv3).b;
	
	float energy = noise_r * noise_g * noise_b - (1.0 - UV.y) * energyFactor;
	
	float resultant_alpha = clamp(energy * alphaFactor * texture(TEXTURE, UV).a, 0.0, 1.0);
	vec3 resultant_smoke_color = smokeColor.rgb;
	
	COLOR.rgb = resultant_smoke_color;
	COLOR.a = resultant_alpha;
}

