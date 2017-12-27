//
//  AnButtonTableViewCell.m
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/27.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "AnButtonTableViewCell.h"

@implementation AnButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)btnClick:(id)sender {
    self.addCellBolck();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
