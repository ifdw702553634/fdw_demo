//
//  SelectPhotoViewController.h
//  PhotoSelectDemo
//
//  Created by mude on 16/12/2.
//  Copyright © 2016年 DreamTouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface SelectPhotoViewController : UIViewController

@property NSMutableArray<PHAsset *> *photoArr;

@property NSMutableArray<PHAsset *> *selectArr;

@end
