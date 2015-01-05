//
//  SelfieDataManager.m
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import "SelfieDataManager.h"

static SelfieDataManager *sharedInstance = nil;

@interface SelfieDataManager()

@end

@implementation SelfieDataManager


+ (SelfieDataManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _selfieDataDict = [[NSMutableDictionary alloc]initWithCapacity:0];
        _standard_Resolution_Dataset = [[NSMutableArray alloc]init];
        _low_Resolution_Dataset = [[NSMutableArray alloc]init];
        _thumbnail_Dataset = [[NSMutableArray alloc]init];
        _max_tag_id = nil;
        _accessToken = nil;
    }
    return self;
}

- (void)setSelfieDataDict:(NSMutableDictionary *)selfieDataDict
{
    _selfieDataDict = selfieDataDict;
}

- (void)setStandard_Resolution_Dataset:(NSMutableArray *)standard_Resolution_Dataset
{
    [_standard_Resolution_Dataset addObjectsFromArray:standard_Resolution_Dataset];
}

- (void)setLow_Resolution_Dataset:(NSMutableArray *)low_Resolution_Dataset
{
    [_low_Resolution_Dataset addObjectsFromArray:low_Resolution_Dataset];
}

- (void)setThumbnail_Dataset:(NSMutableArray *)thumbnail_Dataset
{
    [_thumbnail_Dataset addObjectsFromArray:thumbnail_Dataset];
}

- (void)setMax_tag_id:(NSString *)max_tag_id
{
    _max_tag_id = max_tag_id;
}

- (void)setAccessToken:(NSString *)accessToken
{
    _accessToken = accessToken;
}

@end
