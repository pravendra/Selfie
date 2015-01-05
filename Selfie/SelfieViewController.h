//
//  SelfieViewController.h
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfieViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *selfieCollectionView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityView;

@end
