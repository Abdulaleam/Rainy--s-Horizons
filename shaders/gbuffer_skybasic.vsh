#version 460 compatibility

out vec4 starData; 

// soooo we need stars AND PIXELS????

void main() {
	gl_Position = ftransform();
    // not sure if my guide 's outdated or not , prob is.......
	starData = vec4(gl_Color.rgb, float(gl_Color.r == gl_Color.g && gl_Color.g == gl_Color.b && gl_Color.r > 0.0));
}