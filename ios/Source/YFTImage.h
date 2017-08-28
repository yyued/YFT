//
//  YFTImage.h
//  YFTSample
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTImage : UIImage

+ (UIImage *)imageNamed:(NSString *)name
             canvasSize:(CGSize)canvasSize
                andText:(NSString *)argText
            letterSpace:(CGFloat)letterSpace
          textAlignment:(NSTextAlignment)textAlignment;

+ (UIImage *)imageWithData:(NSData *)data
                canvasSize:(CGSize)canvasSize
                   andText:(NSString *)argText
               letterSpace:(CGFloat)letterSpace
             textAlignment:(NSTextAlignment)textAlignment;

@end
