/*
Film Grain post-process shader v1.1	
Martins Upitis (martinsh) devlog-martinsh.blogspot.com
2013

imported to Godot by spl!te 2017
updated to Godot 4.0 by JDX0 2023

--------------------------
This work is licensed under a Creative Commons Attribution 3.0 Unported License.
So you are free to share, modify and adapt it for your needs, and even use it for commercial use.
I would also love to hear about a project you are using it.

Have fun,
Martins
--------------------------

Perlin noise shader by toneburst:
http://machinesdontcare.wordpress.com/2009/06/25/3d-perlin-noise-sphere-vertex-shader-sourcecode/
*/
shader_type canvas_item;

uniform float amount;
uniform float strength = 16.0;
uniform float resolution = 0.1;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;



  //vec4 color = texture(TEXTURE, UV);
  //vec2 uvRandom = UV;
  //uvRandom.y *= random(vec2(uvRandom.y,amount));
  //color.rgb += random(uvRandom)*0.15;
  //COLOR = vec4( color );
void fragment()
{
	vec4 base = texture(SCREEN_TEXTURE, SCREEN_UV);
	float x = (SCREEN_UV.x + 4.0 ) * (SCREEN_UV.y + 4.0 ) * (TIME * 10.0);
	vec4 grain = vec4(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01)-0.005) * strength;
	// noise texture
	//vec4 blend = texture(TEXTURE, UV);
	
	COLOR = base-grain;
}