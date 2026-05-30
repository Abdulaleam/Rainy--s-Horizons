#version 460 compatibility

out vec4 glcolor;
out vec4 starData;

void main() {
	gl_Position = ftransform();
	glcolor = gl_Color;
    // i think my guide is outdated , since the new thing for gl_color is just the one i used before which is vacolor, but i faced no errors so i guess it works? idk
    starData= vec4(gl_Color.rgb, float(gl_Color.r == gl_Color.g && gl_Color.g == gl_Color.b && gl_Color.r > 0.0));
     
}