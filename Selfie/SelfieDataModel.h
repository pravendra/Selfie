//
//  SelfieDataModel.h
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfieDataModel : NSObject

@property (nonatomic, strong) NSString *standardResolutionURL;
@property (nonatomic, strong) NSString *lowdResolutionURL;
@property (nonatomic, strong) NSString *thumbnailURL;

@end
