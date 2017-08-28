//
//  YFTImage.m
//  YFTSample
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import "YFTImage.h"
#import "YFTEntity.h"

@implementation YFTImage

+ (UIImage *)imageNamed:(NSString *)name
             canvasSize:(CGSize)canvasSize
                andText:(NSString *)argText
            letterSpace:(CGFloat)letterSpace
          textAlignment:(NSTextAlignment)textAlignment {
    YFTEntity *item = [YFTEntity createWithNamed:name];
    NSArray *charPosition = [item charPositions:canvasSize andText:argText letterSpace:letterSpace textAlignment:textAlignment];
    UIGraphicsBeginImageContextWithOptions(canvasSize, NO, [UIScreen mainScreen].scale);
    for (NSInteger i = 0; i < argText.length; i++) {
        NSString *character = [argText substringWithRange:NSMakeRange(i, 1)];
        if (item.characters[character] != nil) {
            YFTCharacter *characterItem = item.characters[character];
            [characterItem.image drawInRect:CGRectMake([charPosition[i] CGPointValue].x, [charPosition[i] CGPointValue].y, characterItem.size.width, characterItem.size.height)];
        }
    }
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

+ (UIImage *)imageWithData:(NSData *)data
                canvasSize:(CGSize)canvasSize
                   andText:(NSString *)argText
               letterSpace:(CGFloat)letterSpace
             textAlignment:(NSTextAlignment)textAlignment {
    YFTEntity *item = [YFTEntity createWithData:data];
    NSArray *charPosition = [item charPositions:canvasSize andText:argText letterSpace:letterSpace textAlignment:textAlignment];
    UIGraphicsBeginImageContextWithOptions(canvasSize, NO, [UIScreen mainScreen].scale);
    for (NSInteger i = 0; i < argText.length; i++) {
        NSString *character = [argText substringWithRange:NSMakeRange(i, 1)];
        if (item.characters[character] != nil) {
            YFTCharacter *characterItem = item.characters[character];
            [characterItem.image drawInRect:CGRectMake([charPosition[i] CGPointValue].x, [charPosition[i] CGPointValue].y, characterItem.size.width, characterItem.size.height)];
        }
    }
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

@end
