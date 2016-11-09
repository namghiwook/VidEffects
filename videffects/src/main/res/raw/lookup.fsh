//T_Lookup filter

#extension GL_OES_EGL_image_external : require
precision highp float;

varying highp vec2 vTextureCoord;
uniform samplerExternalOES sTexture;
uniform sampler2D inputImageTexture2;

void main() {

    // http://stackoverflow.com/questions/17984874/weird-glsl-float-color-value-in-fragment-shader-on-ios
    //INTEGER INDEX:   0: FP:         0.0 ->  TEXCOORD: 0.0 + 1.0/(2.0 *n)
    //INTEGER INDEX: n-1: FP: (n-1)/255.0 ->  TEXCOORD: 1.0 - 1.0/(2.0 *n)

    // lut png size : 512 * 512
    // pixel_lut_num : 64
    // 63.0 = pixel_lut_num - 1;
    // 8.0 = 512 / 64
    // 0.125 = 1.0 / 8.0

    highp vec4 textureColor = texture2D(sTexture, vTextureCoord);

    float intensity = 1.0;
    float lut_size = 512.0;  // original value : 512
    float pixel_lut_num = 64.0;
    float lut_xy_num = 8.0;
    float scale = 0.125;  // 1.0 / lut_xy_num;
    float offset = 0.5/lut_size;    // 1/(2.0*lut_size)

    highp float blueColor = textureColor.b * (pixel_lut_num - 1.0);

    highp vec2 quad1;
    quad1.y = floor(floor(blueColor) / lut_xy_num);
    quad1.x = floor(blueColor) - (quad1.y * lut_xy_num);

    highp vec2 quad2;
    quad2.y = floor(ceil(blueColor) / lut_xy_num);
    quad2.x = ceil(blueColor) - (quad2.y * lut_xy_num);

    highp vec2 texPos1;
    texPos1.x = (quad1.x * scale) + offset + ((scale - 1.0/lut_size) * textureColor.r);
    texPos1.y = (quad1.y * scale) + offset + ((scale - 1.0/lut_size) * textureColor.g);

    highp vec2 texPos2;
    texPos2.x = (quad2.x * scale) + offset + ((scale - 1.0/lut_size) * textureColor.r);
    texPos2.y = (quad2.y * scale) + offset + ((scale - 1.0/lut_size) * textureColor.g);

    lowp vec4 newColor1 = texture2D(inputImageTexture2, texPos1);
    lowp vec4 newColor2 = texture2D(inputImageTexture2, texPos2);

    lowp vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    gl_FragColor = mix(textureColor, vec4(newColor.rgb, textureColor.w), intensity);


}
