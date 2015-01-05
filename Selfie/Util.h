//
//  Util.h
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (NSString *)getAccessTokenFrom:(NSString *)responseString with:(NSString *)key;

@end
