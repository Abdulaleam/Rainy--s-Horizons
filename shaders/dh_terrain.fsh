#version 460 compatibility

/* DRAWBUFFERS:0 */


uniform sampler2D lightmap;
uniform float viewWidth;
uniform float viewHeight;
uniform sampler2D depthtex0;
uniform vec3 fogColor;

layout(location = 0) out vec4 outColor0;

in vec4 blockColor;
in vec2 lightMapCoords;
in vec3 viewSpacePosition;

void main() {

       vec3 lightColor = pow(texture(lightmap,lightMapCoords).rgb, vec3(2.2));
       // I Had to spent 30 mins to figure out an error turns out i typed m not M and for the M i did m

    // btw i wasted 20 mins , forgetting to turn this into a vac 3 and adding .rgb
    vec4 outputColorData = blockColor;
    
    vec3 outputColor = outputColorData.rgb * lightColor;
    float transparency = outputColorData.a;

    if (transparency < 0.1) {
        discard;
    }
   vec2 texCoord = gl_FragCoord.xy / vec2(viewWidth, viewHeight);
   float depth = texture(depthtex0, texCoord).r;

   if(depth != 1.0) {
    discard;
   }
   float distanceFromCamera = distance(vec3(0),viewSpacePosition);
   
   float maxfogDistance = 4000;
   float minFogDistance = 2500;


   float fogBlendValue = clamp((distanceFromCamera - minFogDistance) / (maxfogDistance - minFogDistance),0,1);

   outputColor = mix(outputColor, fogColor,fogBlendValue);

    outColor0 = pow(vec4(outputColor, transparency),vec4(1/2.2));
}
