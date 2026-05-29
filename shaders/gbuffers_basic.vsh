#version 460
  in vec3 vaPostion;
  in vec2 vaUV0;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
// time to add textures , as everything 's white rn

out vec2 texCoord;
// btw texcoord stands for texture coordinate if any1 reading my project  wanna learn shaders i guess


void main(){

    // so this () is supposed to be for input as i know , BUT HERE IT DONT ACTUALLY EXPECT input? confusing wth
texCoord = vaUV0;

    gl_Position = projectionMatrix *modelViewMatrix * vec4(vaPostion,1);
}