//
//  ViewController.m
//  YFTSample
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import "ViewController.h"
#import "YFTImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *textImage = [YFTImage imageNamed:@"pop_score_big"
                                   canvasSize:CGSizeMake(300, 100)
                                        scale:2
                                      andText:@"123"
                                  letterSpace:-2
                                textAlignment:NSTextAlignmentCenter];
    NSLog(@"%@", textImage);
}

@end
