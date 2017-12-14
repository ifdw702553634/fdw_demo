//
//  TodayExtentionDemoViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 16/12/26.
//  Copyright © 2016年 DreamTouch. All rights reserved.
//

#import "TodayExtentionDemoViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TodayCollectionViewCell.h"


#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

static NSString *kTodayCollectionViewCell = @"kTodayCollectionViewCell";

@interface TodayExtentionDemoViewController ()<NCWidgetProviding,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *imgArr;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TodayExtentionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib: [UINib nibWithNibName:@"TodayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kTodayCollectionViewCell];
    imgArr = @[@"Avatar_group",@"home_news",@"home_notice",@"home_waithandle",@"ic_announcement",@"ic_news"];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置默认折叠状态
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)openURLContainingAPP:(NSInteger)tag{
    if (tag == 0) {
        //通过extensionContext借助host app调起app
        [self.extensionContext openURL:[NSURL URLWithString:@"todaywidget://home"] completionHandler:^(BOOL success) {
            NSLog(@"open url result:%d",success);
        }];
    }else{
        //通过extensionContext借助host app调起app
        [self.extensionContext openURL:[NSURL URLWithString:@"todaywidget://select"] completionHandler:^(BOOL success) {
            NSLog(@"open url result:%d",success);
        }];
    }
    
}

//- (IBAction)btnClick:(id)sender {
//    [self openURLContainingAPP:0];
//}
//- (IBAction)selectBtnClick:(id)sender {
//    [self openURLContainingAPP:1];
//}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    } else {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 220);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}



#pragma mark -- UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(100, 100);
    return itemSize;
}
//定义每个UICollectionView 的边距
-(UIEdgeInsets)collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake(5.0, (self.view.bounds.size.width-300)/4, 5.0, (self.view.bounds.size.width-300)/4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  (self.view.bounds.size.width-300)/4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  5.0f;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgArr.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TodayCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTodayCollectionViewCell forIndexPath:indexPath];
    
    cell.image.image = [UIImage imageNamed:imgArr[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self openURLContainingAPP:1];
}
@end
