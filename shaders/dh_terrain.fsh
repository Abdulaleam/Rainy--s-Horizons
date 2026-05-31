#version 460 compatibility


uniform sampler2D lightmap;
uniform sampler2D depthtex0;
uniform sampler2D dhDepthTex0;
uniform float viewHeight;
uniform float viewWidth;
uniform float far;
uniform float near;
uniform float dhNearPlane;
uniform float dhFarPlane;
uniform vec3 fogColor;
uniform mat4 gbufferModelViewinverse;

uniform vec3 shadowLightPosition;

in vec4 blockColor;
in vec2 texCoord;
in vec3 foliageColor;
in vec2 lightMapCoords;
in vec3 viewSpacePosition;
in vec3 geoNormal;


/* DRAWBUFFERS:0 */

 layout(location = 0) out vec4 outColor0;



float linearizeDepth(float depth, float near, float far) {
     return ( near * far ) / ( depth * ( near - far) + far );
}

void main() {


 vec4 outputColorData = blockColor;
   vec3 outputColor = pow(outputColorData.rgb, vec3(2.2));
  float transparency = outputColorData.a;
        if (transparency < 0.1) {

         discard;
        }

   vec3 shadowLightDirection = normalize(shadowLightPosition);

   vec3 worldGeoNormal = mat3(gbufferModelViewinverse) * geoNormal;

   float lightBrightness = clamp(dot(shadowLightDirection, worldGeoNormal), 0.1, 1.0);

   vec3 lightColor =pow(texture(lightmap,lightMapCoords).rgb,vec3(2.2));
     
      outputColor *= lightColor;



    vec2 texCoord = gl_FragCoord.xy / vec2(viewWidth, viewHeight);
    float depth = texture(depthtex0, texCoord).r;
    float dhDepth = gl_FragCoord.z;
      float depthLinear = linearizeDepth(depth, near, far*4);
      float dhDepthLinear = linearizeDepth(dhDepth, dhNearPlane, dhFarPlane);

      if (depthLinear > dhDepthLinear && depth != 1.0) {
          discard;
      }

      float distanceFromCamera = distance(viewSpacePosition, vec3(0.0));
            float dhBlend = pow(smoothstep(dhFarPlane-.5 *dhFarPlane, dhFarPlane, dhDepthLinear), 0.6);
            transparency = mix(transparency, 0.0, dhBlend);
            float fogBlendValue = smoothstep(.9,1.0,dhDepth);
            outColor0 = vec4(mix(outputColor, fogColor, fogBlendValue), transparency);
}

