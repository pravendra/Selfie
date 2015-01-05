//
//  SelfieDataLoad.m
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import "SelfieDataLoad.h"
#import "SelfieDataModel.h"

@interface SelfieDataLoad()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableArray *standard_Resolution_Dataset;
@property (nonatomic, strong) NSMutableArray *low_Resolution_Dataset;
@property (nonatomic, strong) NSMutableArray *thumbnail_Dataset;

@end


@implementation SelfieDataLoad

- (id)init
{
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc]init];
        self.standard_Resolution_Dataset = [[NSMutableArray alloc]initWithCapacity:0];
        self.low_Resolution_Dataset = [[NSMutableArray alloc]initWithCapacity:0];
        self.thumbnail_Dataset = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)fetchSelfieData
{
    NSURL *url = [NSURL URLWithString:[[SELFIE_IMAGE_URL stringByAppendingString:[Util getAccessTokenFrom:[[SelfieDataManager sharedInstance]accessToken] with:@"="]]stringByAppendingString:[NSString stringWithFormat:@"&max_tag_id=%@",[[SelfieDataManager sharedInstance]max_tag_id]]]];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]init];
    [urlRequest setHTTPMethod:GET_METHOD];
    [urlRequest setURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    
    __block NSError *error = nil;
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:self.queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil && connectionError == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if ([[[jsonDict objectForKey:@"meta"]objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:STATUS_CODE]]) {
                [[SelfieDataManager sharedInstance]setMax_tag_id:[[jsonDict objectForKey:@"pagination"]objectForKey:@"next_max_id"]];
                for (NSDictionary *dic in [jsonDict objectForKey:@"data"]){
                    SelfieDataModel *dataItem = [[SelfieDataModel alloc]init];
                    dataItem.standardResolutionURL = [[[dic objectForKey:@"images"]objectForKey:STANDARD_RESOLUTION]objectForKey:@"url"];
                    [self.standard_Resolution_Dataset addObject:dataItem.standardResolutionURL];
                    dataItem.lowdResolutionURL = [[[dic objectForKey:@"images"]objectForKey:LOW_RESOLUTION]objectForKey:@"url"];
                    [self.low_Resolution_Dataset addObject:dataItem.lowdResolutionURL];
                    dataItem.thumbnailURL = [[[dic objectForKey:@"images"]objectForKey:THUMBNAIL]objectForKey:@"url"];
                    [self.thumbnail_Dataset addObject:dataItem.thumbnailURL];
                }
            }else if (![[[jsonDict objectForKey:@"meta"]objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:STATUS_CODE]])
            {
                [self showAlertViewWithTitle:@"Error" andMessage:[[jsonDict objectForKey:@"meta"]objectForKey:@"error_message"]];
            }
        }else{
            if (connectionError != nil) {
                [self showAlertViewWithTitle:@"Error" andMessage:connectionError.localizedDescription];
            }else if (data == nil){
                [self showAlertViewWithTitle:@"Error" andMessage:@"No data available"];
            }
        }
        [[SelfieDataManager sharedInstance]setStandard_Resolution_Dataset:self.standard_Resolution_Dataset];
        [[SelfieDataManager sharedInstance]setLow_Resolution_Dataset:self.low_Resolution_Dataset];
        [[SelfieDataManager sharedInstance]setThumbnail_Dataset:self.thumbnail_Dataset];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SelfieDataManager sharedInstance]setSelfieDataDict:[NSMutableDictionary dictionaryWithObjects:@[[[SelfieDataManager sharedInstance]standard_Resolution_Dataset],[[SelfieDataManager sharedInstance]low_Resolution_Dataset],[[SelfieDataManager sharedInstance]thumbnail_Dataset]] forKeys:@[STANDARD_RESOLUTION,LOW_RESOLUTION,THUMBNAIL]]];
            [[NSNotificationCenter defaultCenter]postNotificationName:kDataNotification object:nil];
        });
    }];
}

#pragma mark
#pragma mark Alert View

- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    });
}

@end
