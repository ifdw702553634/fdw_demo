//
//  AnButtonTableViewCell.h
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/27.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddCellBolck)();

@interface AnButtonTableViewCell : UITableViewCell

@property (nonatomic,copy)AddCellBolck addCellBolck;

@end
