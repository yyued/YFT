//
//  YFTEntity.h
//  YFTSample
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTCharacter : NSObject

@property (nonatomic, readonly) UIImage * _Nonnull image;
@property (nonatomic, readonly) CGFloat scale;
@property (nonatomic, readonly) CGSize size;

@end

@interface YFTEntity : NSObject

+ (nullable YFTEntity *)createWithNamed:(nonnull NSString *)named;
+ (nullable YFTEntity *)createWithData:(nonnull NSData *)data;

@property (nonatomic, readonly) NSDictionary<NSString *, YFTCharacter *> * _Nonnull characters;

- (nonnull NSArray *)charPositions:(CGSize)canvasSize
                           andText:(nonnull NSString *)argText
                       letterSpace:(CGFloat)letterSpace
                     textAlignment:(NSTextAlignment)textAlignment;

@end
