package com.yy.opensource.yft;

import android.content.Context;

import org.json.JSONObject;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class YFTEntity {

    private Map<String, YFTCharacter> mCharacters;

    public static YFTEntity createWithNamed(Context context, String assetsName) throws Exception {
        return new YFTEntity(context.getAssets().open(assetsName + ".yft"));
    }

    public YFTEntity(InputStream is) throws Exception {
        HashMap<String, YFTCharacter> characters = new HashMap();
        byte[] bytes = new byte[is.available()];
        is.read(bytes);
        is.close();
        String JSONString = new String(bytes);
        JSONObject obj = new JSONObject(JSONString);
        Iterator<String> iterator = obj.keys();
        while (iterator.hasNext()) {
            String characterName = iterator.next();
            characters.put(characterName, new YFTCharacter(obj.getJSONObject(characterName)));
        }
        mCharacters = characters;
    }

    public Map<String, YFTCharacter> getCharacters() {
        return mCharacters;
    }

    public List<YFTPoint> charPositions(float canvasWidth, float canvasHeight, String text, float letterSpace, int textAlignment) {
        ArrayList<YFTPoint> positions = new ArrayList();
        YFTPoint lastPoint = new YFTPoint(0, 0);
        char[] chars = text.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            String character = String.valueOf(chars[i]);
            if (null != mCharacters.get(character)) {
                lastPoint.y = (canvasHeight - mCharacters.get(character).mHeight) / 2;
                positions.add(new YFTPoint(lastPoint.x, lastPoint.y));
                lastPoint.x += mCharacters.get(character).mWidth + letterSpace;
            }
            else {
                positions.add(new YFTPoint(lastPoint.x, lastPoint.y));
            }
        }
        float textWidth = lastPoint.x - letterSpace;
        if (textAlignment == 1) {
            float offsetX = (canvasWidth - textWidth) / 2;
            for (int i = 0; i < positions.size(); i++) {
                positions.get(i).x += offsetX;
            }
        }
        else if (textAlignment == 2) {
            float offsetX = canvasWidth - textWidth;
            for (int i = 0; i < positions.size(); i++) {
                positions.get(i).x += offsetX;
            }
        }
        return positions;
    }

    public YFTPoint maxPoint(String text, float letterSpace) {
        YFTPoint lastPoint = new YFTPoint(0, 0);
        char[] chars = text.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            String character = String.valueOf(chars[i]);
            if (null != mCharacters.get(character)) {
                lastPoint.x += mCharacters.get(character).mWidth + letterSpace;
                lastPoint.y = Math.max(lastPoint.y, mCharacters.get(character).mHeight);
            }
        }
        return new YFTPoint(lastPoint.x - letterSpace, lastPoint.y);
    }

}
