//
//  SelectPhotoCollectionViewCell.h
//  photoDemo
//
//  Created by a on 16/9/19.
//  Copyright © 2016年 fdw. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SelectBtnClickBlock) (BOOL isSelect);

@interface SelectPhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *isSelectImg;

@end
