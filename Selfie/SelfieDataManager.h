//
//  SelfieDataManager.h
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfieDataManager : NSObject

+ (SelfieDataManager *)sharedInstance;

@property (nonatomic, strong) NSMutableDictionary *selfieDataDict;
@property (nonatomic, strong) NSString *max_tag_id;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSMutableArray *standard_Resolution_Dataset;
@property (nonatomic, strong) NSMutableArray *low_Resolution_Dataset;
@property (nonatomic, strong) NSMutableArray *thumbnail_Dataset;

@end
