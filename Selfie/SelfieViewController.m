//
//  SelfieViewController.m
//  Selfie
//
//  Created by Pravendra Singh on 1/4/15.
//  Copyright (c) 2015 pravendrasingh. All rights reserved.
//

#import "SelfieViewController.h"
#import "ImageCollectionViewCell.h"
#import "ImageViewController.h"
#import "SelfieDataLoad.h"

@interface SelfieViewController ()
@property (nonatomic, strong) NSArray *standard_resolution_dataset;
@property (nonatomic, strong) NSArray *low_resolution_dataset;
@property (nonatomic, strong) NSArray *thumbnail_dataset;
@property (nonatomic, strong) NSOperationQueue *albumOperationQueue;
@end

@implementation SelfieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.albumOperationQueue = [[NSOperationQueue alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadSelfieData:)name:kDataNotification object:nil];
    [self registerCollectionNib];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadSelfieData:nil];
}

- (instancetype)registerCollectionNib
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ImageCollectionViewCell class]) bundle:[NSBundle mainBundle]];
    [_selfieCollectionView registerNib:nib forCellWithReuseIdentifier:kCellIdentifier];
    return self;
}

- (void)loadSelfieData:(NSNotification *)notification
{
    self.standard_resolution_dataset = [[[SelfieDataManager sharedInstance]selfieDataDict]objectForKey:STANDARD_RESOLUTION];
   // NSLog(@"%lu",(unsigned long)self.standard_resolution_dataset.count);
    self.low_resolution_dataset = [[[SelfieDataManager sharedInstance]selfieDataDict]objectForKey:LOW_RESOLUTION];
    self.thumbnail_dataset = [[[SelfieDataManager sharedInstance]selfieDataDict]objectForKey:THUMBNAIL];

    [self.selfieCollectionView reloadData];
    [self.activityView stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.low_resolution_dataset.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(ImageCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    __block UIImage *image = nil;
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        if (indexPath.row%3 == 0) {
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 170, 170);
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.low_resolution_dataset objectAtIndex:indexPath.row]]]];
        }else {
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 100, 100);
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.thumbnail_dataset objectAtIndex:indexPath.row]]]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.selfieCollectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[self.selfieCollectionView cellForItemAtIndexPath:indexPath];
                cell.imageView.image = image;
            }
        });
    }];
    [self.albumOperationQueue addOperation:operation];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewController *imageController = [[UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil]instantiateViewControllerWithIdentifier:IMAGE_VIEW_CONTROLLER];
    imageController.stringURL = [self.standard_resolution_dataset objectAtIndex:indexPath.row];
    [self presentViewController:imageController animated:YES completion:nil];
}

- (void)refershControlAction
{
    SelfieDataLoad *dataload = [[SelfieDataLoad alloc]init];
    [dataload fetchSelfieData:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (endScrolling >= scrollView.contentSize.height-100)
    {
        [self.activityView startAnimating];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self refershControlAction];
    }
}

@end
