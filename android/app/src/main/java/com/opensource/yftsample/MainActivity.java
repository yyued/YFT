package com.opensource.yftsample;

import android.graphics.Bitmap;
import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.yy.opensource.yft.YFTEntity;
import com.yy.opensource.yft.YFTImage;
import com.yy.opensource.yft.YFTLabel;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        try {
            Bitmap bitmap = YFTImage.create(this, "pop_score_big", 300 * getResources().getDisplayMetrics().density, 66 * getResources().getDisplayMetrics().density, getResources().getDisplayMetrics().density, "123", -2, 1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        setContentView(R.layout.activity_main);
        resetLabel();
    }

    void resetLabel() {
        YFTLabel label = (YFTLabel) findViewById(R.id.testLabel);
        try {
            label.setYFTEntity(YFTEntity.createWithNamed(this, "pop_score_big"));
            label.setText("123");
            label.setYFTTextAlignment(1);
            label.setLetterSpace(-2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
