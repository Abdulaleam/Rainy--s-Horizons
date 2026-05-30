#version 460

/* DRAWBUFFERS:0 */

uniform sampler2D gtexture;
uniform sampler2D lightmap;

layout(location = 0) out vec4 outColor0;

in vec2 texCoord;
in vec3 foliageColor;
in vec2 lightMapCoords;

void main() {

       vec3 lightColor = pow(texture(lightmap,lightMapCoords).rgb, vec3(2.2));
       // I Had to spent 30 mins to figure out an error turns out i typed m not M and for the M i did m

    // btw i wasted 20 mins , forgetting to turn this into a vac 3 and adding .rgb
    vec4 outputColorData = pow(texture(gtexture, texCoord), vec4(2.2));

    vec3 outputColor = outputColorData.rgb * pow(foliageColor, vec3(2.2)) * lightColor;
    float transparency = outputColorData.a;

    if (transparency < 0.1) {
        discard;
    }

    outColor0 = pow(vec4(outputColor, transparency),vec4(1.0/2.2));
}
