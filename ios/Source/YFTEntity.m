//
//  YFTEntity.m
//  YFTSample
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import "YFTEntity.h"

@interface YFTCharacter ()

@property (nonatomic, readwrite) UIImage * _Nonnull image;
@property (nonatomic, readwrite) CGFloat scale;
@property (nonatomic, readwrite) CGSize size;

@end

@implementation YFTCharacter

@end

@interface YFTEntity ()

@property (nonatomic, readwrite) NSDictionary<NSString *, YFTCharacter *> * _Nonnull characters;

@end

@implementation YFTEntity

+ (YFTEntity *)createWithNamed:(NSString *)named {
    NSString *yftPath = [[NSBundle mainBundle] pathForResource:named ofType:@"yft"];
    if (yftPath) {
        return [self createWithData:[NSData dataWithContentsOfFile:yftPath]];
    }
    else {
        return nil;
    }
}

+ (YFTEntity *)createWithData:(NSData *)data {
    NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        YFTEntity *yftItem = [[YFTEntity alloc] init];
        NSMutableDictionary<NSString *, YFTCharacter *> *characters = [NSMutableDictionary dictionary];
        for (NSString *characterName in obj) {
            if ([obj[characterName][@"data"] isKindOfClass:[NSString class]]) {
                NSData *imageData = [[NSData alloc] initWithBase64EncodedString:obj[characterName][@"data"] options:kNilOptions];
                if (imageData) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    if (image) {
                        YFTCharacter *character = [[YFTCharacter alloc] init];
                        character.image = image;
                        character.scale = [obj[characterName][@"scale"] floatValue];
                        character.size = CGSizeMake([obj[characterName][@"width"] floatValue], [obj[characterName][@"height"] floatValue]);
                        [characters setObject:character forKey:characterName];
                    }
                }
            }
        }
        yftItem.characters = [characters copy];
        return yftItem;
    }
    return nil;
}

- (NSArray *)charPositions:(CGSize)canvasSize andText:(NSString *)argText letterSpace:(CGFloat)letterSpace textAlignment:(NSTextAlignment)textAlignment {
    NSMutableArray *positions = [NSMutableArray array];
    CGPoint lastPoint = CGPointZero;
    for (NSInteger i = 0; i < argText.length; i++) {
        NSString *character = [argText substringWithRange:NSMakeRange(i, 1)];
        if (self.characters[character] != nil) {
            lastPoint.y = (canvasSize.height - self.characters[character].size.height) / 2.0;
            [positions addObject:[NSValue valueWithCGPoint:lastPoint]];
            lastPoint.x += self.characters[character].size.width + letterSpace;
        }
        else {
            [positions addObject:[NSValue valueWithCGPoint:lastPoint]];
        }
    }
    CGFloat textWidth = lastPoint.x - letterSpace;
    if (textAlignment == NSTextAlignmentCenter) {
        CGFloat offsetX = (canvasSize.width - textWidth) / 2.0;
        [[positions copy] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint point = [obj CGPointValue];
            point.x += offsetX;
            [positions setObject:[NSValue valueWithCGPoint:point] atIndexedSubscript:idx];
        }];
    }
    else if (textAlignment == NSTextAlignmentRight) {
        CGFloat offsetX = canvasSize.width - textWidth;
        [[positions copy] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint point = [obj CGPointValue];
            point.x += offsetX;
            [positions setObject:[NSValue valueWithCGPoint:point] atIndexedSubscript:idx];
        }];
    }
    return [positions copy];
}

- (CGSize)textBounds:(NSString *)argText
         letterSpace:(CGFloat)letterSpace {
    CGPoint lastPoint = CGPointZero;
    for (NSInteger i = 0; i < argText.length; i++) {
        NSString *character = [argText substringWithRange:NSMakeRange(i, 1)];
        if (self.characters[character] != nil) {
            lastPoint.y = MAX(lastPoint.y, self.characters[character].size.height);
            lastPoint.x += self.characters[character].size.width + letterSpace;
        }
    }
    return CGSizeMake(lastPoint.x - letterSpace, lastPoint.y);
}

@end
