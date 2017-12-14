//
//  SelectPhotoViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 16/12/2.
//  Copyright © 2016年 DreamTouch. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import <Photos/Photos.h>
#import "SelectPhotoCollectionViewCell.h"

static NSString *kSelectPhotoCollectionViewCell = @"kSelectPhotoCollectionViewCell";

@interface SelectPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    BOOL isLoadAgain;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SelectPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
    _photoArr = [[NSMutableArray alloc] init];
    _selectArr = [[NSMutableArray alloc] init];
    [self loadImages];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = CustomLocalizedString(@"photoSelectTitle", nil);
}
-(void)prepareView{
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib: [UINib nibWithNibName:@"SelectPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kSelectPhotoCollectionViewCell];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (isLoadAgain == NO) {
        if(_photoArr.count != 0){
            isLoadAgain = YES;
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_photoArr.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        }
    }
    //滚动到指定位置
}

- (void)loadImages
{
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
        //        _assets = [self getAssetsInAssetCollection:collection ascending:YES];
        NSArray *arr = [self getAssetsInAssetCollection:collection ascending:YES];
        
        if(arr.count != 0){
            [_photoArr addObjectsFromArray:arr];
        }
    }];
    //    [_photoTableView reloadData];
    
}


#pragma mark - 获取指定相册内的所有图片
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    NSMutableArray<PHAsset *> *arr = [NSMutableArray array];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[PHAsset class]]) {
            [arr addObject:obj];//这个obj即PHAsset对象
        }
    }];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    PHCachingImageManager *cachingImage = [[PHCachingImageManager alloc] init];
    [cachingImage startCachingImagesForAssets:arr
                                   targetSize:PHImageManagerMaximumSize
                                  contentMode:PHImageContentModeDefault
                                      options:options];
    return arr;
}



#pragma mark -- UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake((SCREEN_WIDTH-4.0)/3.0, (SCREEN_WIDTH-4.0)/3.0);
    return itemSize;
}
//定义每个UICollectionView 的边距
-(UIEdgeInsets)collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  1.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  2.0f;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoArr.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectPhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSelectPhotoCollectionViewCell forIndexPath:indexPath];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = NO;
    CGSize size = CGSizeMake(180, 180);
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:_photoArr[indexPath.row] targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
        //设置BOOL判断，确定返回高清照片
        if (downloadFinined) {
            if (result != nil) {
                cell.bgImg.image = result;
            }
        }
    }];
    BOOL isSelect = NO;
    for (int i = 0; i<_selectArr.count; i++) {
        if ([self.photoArr[indexPath.row].localIdentifier isEqual:_selectArr[i].localIdentifier]) {
            isSelect = YES;
            break;
        }
    }
    if (isSelect == YES) {
        cell.isSelectImg.image = [UIImage imageNamed:@"photo_check"];
    }else{
        cell.isSelectImg.image = [UIImage imageNamed:@"photo_nocheck"];
    }
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    __block SelectPhotoCollectionViewCell *weakCell = cell;
    //    cell.selectBlock = ^{
    //
    //    };
    
    
    SelectPhotoCollectionViewCell *cell = (SelectPhotoCollectionViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    BOOL isSelect = NO;
    int number = 0;
    for (int i = 0; i<_selectArr.count; i++) {
        if ([_photoArr[indexPath.row].localIdentifier isEqual: _selectArr[i].localIdentifier]) {
            isSelect = YES;
            number = i;
            break;
        }
    }
    if (isSelect == YES) {
        cell.isSelectImg.image = [UIImage imageNamed:@"photo_nocheck"];
        [_selectArr removeObjectAtIndex:number];
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }else{
        if (_selectArr.count >= 9) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"最多上传9张照片" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertVC animated:YES completion:nil];
        }else{
            cell.isSelectImg.image = [UIImage imageNamed:@"photo_check"];
            [_selectArr addObject:self.photoArr[indexPath.row]];
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
    }
}


@end
