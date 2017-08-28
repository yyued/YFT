package com.yy.opensource.yft;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.RectF;
import android.os.Build;
import android.support.annotation.Nullable;
import android.support.annotation.RequiresApi;
import android.util.AttributeSet;
import android.view.View;

import java.util.List;

/**
 * Created by cuiminghui on 2017/8/28.
 */

public class YFTLabel extends View {

    public YFTLabel(Context context) {
        super(context);
    }

    public YFTLabel(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public YFTLabel(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public YFTLabel(Context context, @Nullable AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
    }

    private String mText;

    public void setText(String text) {
        mText = text;
        invalidate();
    }

    private YFTEntity mItem;
    public void setYFTEntity(YFTEntity item) {
        mItem = item;
        invalidate();
    }

    private int mTextAlignment = 0;
    // TextAlignment, 居左 = 0, 居中 = 1, 居右 = 2
    public void setYFTTextAlignment(int textAlignment) {
        mTextAlignment = textAlignment;
        invalidate();
    }

    private int mLetterSpace = 0;
    public void setLetterSpace(int value) {
        mLetterSpace = value;
        invalidate();
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (mText != null && mItem != null) {
            float scale = getResources().getDisplayMetrics().density;
            List<YFTPoint> charPositions = mItem.charPositions(canvas.getWidth() / scale, canvas.getHeight() / scale, mText, mLetterSpace, mTextAlignment);
            char[] chars = mText.toCharArray();
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            for (int i = 0; i < chars.length; i++) {
                String character = String.valueOf(chars[i]);
                if (null != mItem.getCharacters().get(character)) {
                    YFTCharacter characterItem = mItem.getCharacters().get(character);
                    canvas.drawBitmap(characterItem.mImage, null, new RectF(
                            charPositions.get(i).x * scale,
                            charPositions.get(i).y * scale,
                            charPositions.get(i).x * scale + characterItem.mWidth * scale,
                            charPositions.get(i).y * scale + characterItem.mHeight * scale
                    ), paint);
                }
            }
        }
    }
}
