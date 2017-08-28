//
//  YFTLabel.h
//  YFTSample
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFTEntity.h"

@interface YFTLabel : UILabel

@property (nonatomic, strong) IBInspectable NSString *yftNamed;
@property (nonatomic, assign) IBInspectable CGFloat yftLetterSpace;
@property (nonatomic, strong) YFTEntity *yftItem;

@end
