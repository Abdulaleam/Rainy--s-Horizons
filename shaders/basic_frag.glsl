 #version 460

/* DRAWBUFFERS :0 */
uniform sampler2D gtexture;
// so we use this to store like the color i want
    layout( location = 0) out vec4 outColor0;
 in vec2 texCoord;

void main(){
    vec4 outputColor0 = texture(gtexture,texCoord);
    if(outputColor0.a < 0.1) {
    discard;
    // this will fix the thing with grass like and glass yk i forgot the word transpent or smth like that 
    }
outColor0 = outputColor0;
}