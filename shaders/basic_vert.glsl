#version 460



in vec3 vaPosition;
in vec2 vaUV0;
in vec4 vaColor;
in ivec2 vaUV2;
in vec3 vaNormal;
in vec4 at_tangent;

// wow it has every texture i guess that is for light in mc
// alr im starting to understand STUFF!!!

uniform vec3 chunkOffset;
// used to render terrain
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelViewinverse;
uniform mat3 normalMatrix;
// time to add textures , as everything 's white rn

out vec2 texCoord;
out vec3 foliageColor;
out vec2 lightMapCoords;
out vec3 viewSpacePosition;
out vec3 geoNormal;
out vec4 tangent;


// btw texcoord stands for texture coordinate if any1 reading my project  wanna learn shaders i guess

void main(){


    tangent = vec4(normalize(normalMatrix * at_tangent.xyz), at_tangent.a);

    geoNormal = normalize(normalMatrix * vaNormal);

    texCoord = vaUV0;

    foliageColor = vaColor.rgb;

    lightMapCoords = vaUV2 * (1.0/256.0) + (1.0 /32.0);

    vec4 viewSpacePositionVec4 = modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);
    viewSpacePosition = viewSpacePositionVec4.xyz;


    gl_Position = projectionMatrix * viewSpacePositionVec4;

     // please load????
}