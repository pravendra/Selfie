//
//  SelfieDataLoad.h
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SelfieDataLoad : NSObject<UIAlertViewDelegate>

- (void)fetchSelfieData:(NSString *)accessToken;

@end
