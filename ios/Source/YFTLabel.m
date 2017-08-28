//
//  YFTLabel.m
//  YFTSample
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import "YFTLabel.h"
#import "YFTEntity.h"

@implementation YFTLabel

- (void)setYftNamed:(NSString *)yftNamed {
    _yftNamed = yftNamed;
    self.yftItem = [YFTEntity createWithNamed:yftNamed];
}

- (void)setYftLetterSpace:(CGFloat)yftLetterSpace {
    _yftLetterSpace = yftLetterSpace;
    [self setNeedsDisplay];
}

- (void)setYftItem:(YFTEntity *)yftItem {
    _yftItem = yftItem;
    [self setNeedsDisplay];
}

- (void)drawTextInRect:(CGRect)rect {
    if (self.text != nil && self.yftItem != nil) {
        NSArray *charPosition = [self.yftItem charPositions:self.bounds.size andText:self.text letterSpace:self.yftLetterSpace textAlignment:self.textAlignment];;
        for (NSInteger i = 0; i < self.text.length; i++) {
            NSString *character = [self.text substringWithRange:NSMakeRange(i, 1)];
            if (self.yftItem.characters[character] != nil) {
                YFTCharacter *characterItem = self.yftItem.characters[character];
                [characterItem.image drawInRect:CGRectMake([charPosition[i] CGPointValue].x,
                                                           [charPosition[i] CGPointValue].y,
                                                           characterItem.size.width, characterItem.size.height)];
            }
        }
    }
}

@end
