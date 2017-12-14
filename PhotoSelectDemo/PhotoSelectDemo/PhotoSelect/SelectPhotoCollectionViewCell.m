//
//  SelectPhotoCollectionViewCell.m
//  photoDemo
//
//  Created by a on 16/9/19.
//  Copyright © 2016年 fdw. All rights reserved.
//

#import "SelectPhotoCollectionViewCell.h"

@implementation SelectPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgImg setContentMode:UIViewContentModeScaleAspectFill];
    self.bgImg.userInteractionEnabled = YES;
}


@end
