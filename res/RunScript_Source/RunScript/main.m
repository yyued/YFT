//
//  main.m
//  RunScript
//
//  Created by 崔明辉 on 2017/8/28.
//  Copyright © 2017年 UED Center, YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
#ifdef DEBUG
        NSString *currentPath = @"/Users/cuiminghui/Documents/Works/OpenSource/YFT/res";
#else
        NSString *currentPath = [[[NSProcessInfo processInfo] environment][@"_"] stringByDeletingLastPathComponent];
#endif
        NSMutableArray *validFiles = [NSMutableArray array];
        for (NSString *fileName in [[NSFileManager defaultManager] enumeratorAtPath:currentPath]) {
            if ([fileName hasSuffix:@".png"]) {
                [validFiles addObject:fileName];
            }
        }
        NSMutableDictionary<NSString *, NSMutableDictionary *> *types = [NSMutableDictionary dictionary];
        for (NSString *file in [validFiles copy]) {
            NSString *typeName = [[file componentsSeparatedByString:@"/"] firstObject];
            NSString *letterName = [[[[file componentsSeparatedByString:@"/"] lastObject] stringByReplacingOccurrencesOfString:@"@2x.png" withString:@""] stringByReplacingOccurrencesOfString:@"@3x.png" withString:@""];
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", currentPath, file]];
            CGFloat scale = 1.0;
            if ([file containsString:@"@2x.png"]) {
                scale = 2.0;
            }
            else if ([file containsString:@"@3x.png"]) {
                scale = 3.0;
            }
            if (types[typeName] == nil) {
                [types setObject:[NSMutableDictionary dictionary] forKey:typeName];
            }
            [types[typeName] setObject:@{
                                         @"data": [[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", currentPath, file]]
                                                   base64EncodedStringWithOptions:kNilOptions],
                                         @"scale": @(scale),
                                         @"width": @(image.size.width),
                                         @"height": @(image.size.height),
                                         }
                                forKey:letterName];
        }
        for (NSString *typeName in [types copy]) {
            [[NSJSONSerialization dataWithJSONObject:types[typeName] options:kNilOptions error:NULL]
             writeToFile:[NSString stringWithFormat:@"%@/YFTs/%@.yft", currentPath, typeName]
             options:kNilOptions
             error:NULL];
        }
    }
    return 0;
}
