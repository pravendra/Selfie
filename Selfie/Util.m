//
//  Util.m
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSString *)getAccessTokenFrom:(NSString *)responseString with:(NSString *)key
{
    NSMutableArray *substrings = [NSMutableArray new];
    NSScanner *scanner = [NSScanner scannerWithString:responseString];
    [scanner scanUpToString:key intoString:nil]; // Scan all characters before #
    while(![scanner isAtEnd]) {
        NSString *substring = nil;
        [scanner scanString:key intoString:nil]; // Scan the # character
        if([scanner scanUpToString:@" " intoString:&substring]) {
            // If the space immediately followed the #, this will be skipped
            [substrings addObject:substring];
        }
        [scanner scanUpToString:key intoString:nil]; // Scan all characters before next #
    }
    return [NSString stringWithFormat:@"%@",[substrings firstObject]];
}

@end
