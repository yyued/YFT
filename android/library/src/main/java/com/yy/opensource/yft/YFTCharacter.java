package com.yy.opensource.yft;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import org.json.JSONObject;

/**
 * Created by cuiminghui on 2017/8/28.
 */

class YFTCharacter {

    Bitmap mImage;
    float mScale;
    float mWidth;
    float mHeight;

    YFTCharacter(JSONObject obj) throws Exception {
        String data = obj.optString("data");
        if (data instanceof String) {
            byte[] bytes = Base64.decode(data, 0);
            mImage = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
        }
        mScale = obj.optInt("scale", 1);
        mWidth = (float) obj.optDouble("width", 1.0);
        mHeight = (float) obj.optDouble("height", 1.0);
    }

}
