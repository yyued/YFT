package com.yy.opensource.yft;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;

import java.io.InputStream;
import java.util.List;

/**
 * Created by cuiminghui on 2017/8/28.
 */

public class YFTImage {

    // TextAlignment, 居左 = 0, 居中 = 1, 居右 = 2
    public static Bitmap create(Context context, String assetsName, float canvasWidth, float canvasHeight, float scale, String text, float letterSpace, int textAlignment) throws Exception {
        return YFTImage.create(context.getAssets().open(assetsName + ".yft"), canvasWidth, canvasHeight, scale, text, letterSpace, textAlignment);
    }

    public static Bitmap create(InputStream is, float canvasWidth, float canvasHeight, float scale, String text, float letterSpace, int textAlignment) throws Exception {
        YFTEntity yftItem = new YFTEntity(is);
        List<YFTPoint> charPositions = yftItem.charPositions(canvasWidth / scale, canvasHeight / scale, text, letterSpace, textAlignment);
        Bitmap drawingBitmap = Bitmap.createBitmap((int)canvasWidth, (int)canvasHeight, Bitmap.Config.ARGB_8888);
        Canvas drawingCanvas = new Canvas(drawingBitmap);
        char[] chars = text.toCharArray();
        Paint paint = new Paint();
        paint.setAntiAlias(true);
        for (int i = 0; i < chars.length; i++) {
            String character = String.valueOf(chars[i]);
            if (null != yftItem.getCharacters().get(character)) {
                YFTCharacter characterItem = yftItem.getCharacters().get(character);
                drawingCanvas.drawBitmap(characterItem.mImage, null, new RectF(
                        charPositions.get(i).x * scale,
                        charPositions.get(i).y * scale,
                        charPositions.get(i).x * scale + characterItem.mWidth * scale,
                        charPositions.get(i).y * scale + characterItem.mHeight * scale
                ), paint);
            }
        }
        return drawingBitmap;
    }

}
