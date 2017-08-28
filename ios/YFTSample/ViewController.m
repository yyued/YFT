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
    [YFTImage imageNamed:@"pop_score_big" canvasSize:CGSizeMake(300, 66) andText:@"123" letterSpace:20 textAlignment:NSTextAlignmentCenter];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
