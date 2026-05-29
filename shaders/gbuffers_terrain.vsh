#version 460
  in vec3 vaPosition;
  in vec2 vaUV0;
 in vec4 vaColor;
uniform vec3 chunkOffset;
// used to render terrain
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelViewinverse;
// time to add textures , as everything 's white rn

out vec2 texCoord;

out vec3 foliageColor;
// btw texcoord stands for texture coordinate if any1 reading my project  wanna learn shaders i guess


void main(){

    // so this () is supposed to be for input as i know , BUT HERE IT DONT ACTUALLY EXPECT input? confusing wth
 texCoord = vaUV0;
     foliageColor = vaColor.rgb;
          gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition+chunkOffset,1);
 
     // please load????
}