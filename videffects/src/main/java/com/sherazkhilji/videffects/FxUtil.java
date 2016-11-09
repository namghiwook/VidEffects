package com.sherazkhilji.videffects;

import android.content.Context;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class FxUtil {

	public static String loadShader(Context context, int resourceId) throws IOException {
		StringBuffer fs = new StringBuffer();
		InputStream inputStream = context.getResources().openRawResource(resourceId);
		BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));

		String read = in.readLine();
		while (read != null) {
			fs.append(read + "\n");
			read = in.readLine();
		}
		fs.deleteCharAt(fs.length() - 1);
		return fs.toString();
	}
	
}
