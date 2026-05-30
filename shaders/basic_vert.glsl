#version 460

in vec3 vaPosition;
  in vec2 vaUV0;
 in vec4 vaColor;
 in ivec2 vaUV2;
 // wow it has every texture i guess that is for light in mc
 // alr im starting to understand STUFF!!!

uniform vec3 chunkOffset;
// used to render terrain
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelViewinverse;
// time to add textures , as everything 's white rn

out vec2 texCoord;

out vec3 foliageColor;

out vec2 lightMapCoords;

// btw texcoord stands for texture coordinate if any1 reading my project  wanna learn shaders i guess


void main(){

    // so this () is supposed to be for input as i know , BUT HERE IT DONT ACTUALLY EXPECT input? confusing wth
 texCoord = vaUV0;
     foliageColor = vaColor.rgb;
      lightMapCoords = vaUV2 * (1.0 / 256.0) + (1.0 / 32.0);


          gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition+chunkOffset,1);
 
     // please load????
}