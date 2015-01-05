//
//  LoginViewController.m
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import "LoginViewController.h"
#import "SelfieViewController.h"
#import "SelfieDataLoad.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:[AUTHENTICATION_URL stringByAppendingString:[NSString stringWithFormat:@"?client_id=%@&redirect_uri=%@&response_type=%@",CLIENT_ID,API_URL,REQUEST_TYPE]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [request setHTTPMethod:POST_METHOD];
    [request setHTTPShouldHandleCookies:YES];
    
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
    if (![[[SelfieDataManager sharedInstance]accessToken]  isEqual: NULL_RESPONSE]) {
        SelfieDataLoad *dataLoad = [[SelfieDataLoad alloc]init];
        [dataLoad fetchSelfieData];
        
        SelfieViewController *selfieViewController = [[UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil]instantiateViewControllerWithIdentifier:SELFIE_VIEW_CONTROLLER];
        [self presentViewController:selfieViewController animated:NO completion:nil];
        
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [NSURLConnection connectionWithRequest:request delegate:self];
    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityView stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.activityView stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    [[SelfieDataManager sharedInstance]setAccessToken:[Util getAccessTokenFrom:[response.URL absoluteString] with:@"#"]];
    [connection cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
