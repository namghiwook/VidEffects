package com.sherazkhilji.videffects;

import android.opengl.GLSurfaceView;

import com.sherazkhilji.videffects.interfaces.ShaderInterface;

import java.util.List;

/**
 * Created by Ghiwook on 2016-09-29.
 */
public class NormalEffect implements ShaderInterface {
    /**
     * Initialize Effect
     */
    public NormalEffect() {
    }

    @Override
    public List<Integer> getInputTextures() {
        return null;
    }

    @Override
    public String getShader(GLSurfaceView mGlSurfaceView) {

        String shader = "#extension GL_OES_EGL_image_external : require\n"
                + "precision mediump float;\n"
                + "varying vec2 vTextureCoord;\n"
                + "uniform samplerExternalOES sTexture;\n" + "void main() {\n"
                + "  gl_FragColor = texture2D(sTexture, vTextureCoord);"
                + "}\n";

        return shader;

    }
}
