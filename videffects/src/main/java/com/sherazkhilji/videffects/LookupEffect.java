package com.sherazkhilji.videffects;

import android.content.Context;
import android.opengl.GLSurfaceView;

import com.sherazkhilji.videffects.interfaces.ShaderInterface;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ghiwook on 2016-09-29.
 */
public class LookupEffect extends NormalEffect {

    private List<Integer> mResIds = new ArrayList<Integer>();

    private String fragmentShader;

    public LookupEffect(Context context, int lookupResId) {

        try {
            fragmentShader = FxUtil.loadShader(context, R.raw.lookup);
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (!Float.isNaN(lookupResId)) {
            mResIds.add(lookupResId);
        }
    }

    @Override
    public List<Integer> getInputTextures() {
        return mResIds;
    }

    @Override
    public String getShader(GLSurfaceView mGlSurfaceView) {

        return fragmentShader;

    }
}
