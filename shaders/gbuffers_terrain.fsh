 #version 460
uniform sampler2D gtexture;

/* DRAWBUFFERS :0 */
// so we use this to store like the color i want
layout( location = 0) out vec4 outColor0;

in vec2 texCoord;
void main(){
    outColor0= texture(gtexture,texCoord);

    // i will try to make it 1 so its white , old comments


}