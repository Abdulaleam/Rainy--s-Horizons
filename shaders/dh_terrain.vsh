#version 460 compatibility

// wow it has every texture i guess that is for light in mc
// alr im starting to understand STUFF!!!

uniform mat4 dhprojection;

// time to add textures , as everything 's white rn

out vec4 blockColor;
out vec2 lightMapCoords;
out vec3 viewSpacePosition;
out vec3 geoNormal;

// btw texcoord stands for texture coordinate if any1 reading my project  wanna learn shaders i guess


void main(){
        geoNormal = gl_NormalMatrix * gl_Normal;
        
        blockColor = gl_Color;

        lightMapCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord1).xy;

        viewSpacePosition = (gl_ModelViewMatrix * gl_Vertex).xyz;

        gl_Position = ftransform();
        

   

}