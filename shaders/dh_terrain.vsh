#version 460 compatibility

// wow it has every texture i guess that is for light in mc
// alr im starting to understand STUFF!!!

uniform mat4 dhprojection;

// time to add textures , as everything 's white rn

out vec4 blockColor;
out vec2 lightMapCoords;
out vec3 viewSpacePosition;
// btw texcoord stands for texture coordinate if any1 reading my project  wanna learn shaders i guess


void main(){

    // so this () is supposed to be for input as i know , BUT HERE IT DONT ACTUALLY EXPECT input? confusing wth
     blockColor = gl_Color;
     lightMapCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

    

          gl_Position = ftransform();

 
     // please load????
     
}