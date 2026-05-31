#version 460

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform sampler2D normals;

uniform mat4 gbufferModelViewinverse;
uniform mat4 modelViewMatrixinverse;

uniform float far;
uniform float dhNearPlane;

uniform vec3 shadowLightPosition;

in vec2 texCoord;
in vec3 foliageColor;
in vec2 lightMapCoords;
in vec3 viewSpacePosition;
in vec3 geoNormal;
in vec4 tangent;


/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 outColor0;


 mat3 tbnNormalTangent(vec3 normal, vec3 tangent) {
   vec3 bitangent = cross(tangent, normal);
   return mat3(tangent, bitangent, normal);

}

void main() {
     vec4 outputColorData = texture(gtexture, texCoord);

    vec3 outputColor =  pow(outputColorData.rgb, vec3(2.2))  * pow(foliageColor, vec3(2.2));

    float transparency = outputColorData.a;
        if (transparency < 0.1) {
            discard;
        }
  
   vec3 shadowLightDirection = normalize(mat3(gbufferModelViewinverse) * shadowLightPosition);

    vec3 worldGeoNormal = mat3(gbufferModelViewinverse) * geoNormal;

    vec3 worldTangent = mat3(modelViewMatrixinverse) * tangent.xyz;

    vec4 normalData = texture(normals, texCoord)*2-1.0;

    vec3 normalNormalSpace = vec3(normalData.xy, sqrt(1.0 - dot(normalData.xy, normalData.xy)));
     
     mat3 TBN = tbnNormalTangent(worldGeoNormal, worldTangent);
     
     vec3 normalWorldSpace = TBN * normalNormalSpace;

     float lightBrightness = clamp(dot(shadowLightDirection, normalWorldSpace),0.1,1.5);

    vec3 lightColor =pow(texture(lightmap,lightMapCoords).rgb,vec3(2.2));
    // I Had to spent 30 mins to figure out an error turns out i typed m not M and for the M i did m
    
    // btw i wasted 20 mins , forgetting to turn this into a vac 3 and adding .rgb
    outputColor *= lightBrightness * lightColor;
   
    float distanceFromCamera = distance(viewSpacePosition, vec3(0));

    float dhBlend =smoothstep(far-.5 *far, far,distanceFromCamera );


    transparency = mix(0.0,transparency,pow((1.0 - dhBlend),0.6));
    outputColor *= lightBrightness* lightColor;
    outColor0 =vec4(pow(outputColor, vec3(2.2)), transparency);}
    