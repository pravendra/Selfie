//
//  Constant.m
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import "Constant.h"

@implementation Constant

NSString *const API_URL = @"https://api.instagram.com/v1";
NSString *const TOKEN_URL = @"https://api.instagram.com/oauth/access_token";
NSString *const AUTHENTICATION_URL = @"https://api.instagram.com/oauth/authorize/";
NSString *const SELFIE_IMAGE_URL = @"https://api.instagram.com/v1/tags/selfie/media/recent?access_token=";
NSString *const CLIENT_ID = @"ca8b07a474ca4cf48d6e581c0cb8559a";
NSString *const CLIENT_SECRET = @"9c1aebc2a5e04e15a3d29f1ec51ed742";

NSString *const kCellIdentifier = @"CellIdentifier";
NSString *const kDataNotification = @"selfieDataNotification";
NSString *const REQUEST_TYPE = @"token";
NSString *const POST_METHOD = @"POST";
NSString *const GET_METHOD = @"GET";
NSString *const NULL_RESPONSE = @"(null)";
NSString *const MAIN_STORYBOARD = @"Main";
NSString *const SELFIE_VIEW_CONTROLLER = @"selfieViewController";
NSString *const IMAGE_VIEW_CONTROLLER = @"imageViewController";

NSString *const STANDARD_RESOLUTION = @"standard_resolution";
NSString *const LOW_RESOLUTION = @"low_resolution";
NSString *const THUMBNAIL = @"thumbnail";

int STATUS_CODE = 200;

@end
