//
//  ConstraintTestViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/15.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "ConstraintTestViewController.h"

@interface ConstraintTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *longLbl;
@property (weak, nonatomic) IBOutlet UIButton *assignmentBtn;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *longLblRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shortLblTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shortLblTopL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shortLblLeft;

@end

@implementation ConstraintTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CustomLocalizedString(@"constraintTitle", nil);

    self.assignmentBtn.backgroundColor = THEME_COLOR;
    self.assignmentBtn.tintColor = [UIColor whiteColor];
    
    self.inputTextView.layer.borderWidth = 1.0f;
    self.inputTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)assignment:(id)sender {
    self.longLbl.text = self.inputTextView.text;
    
    CGSize boundSize = CGSizeMake(CGFLOAT_MAX, 27);
    NSDictionary *attribute = @{NSFontAttributeName: self.longLbl.font};
    CGSize requiredSize = [self.longLbl.text boundingRectWithSize:boundSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    if (requiredSize.width >= SCREEN_WIDTH-143) {
        self.shortLblTop.priority = 250;
        self.shortLblLeft.priority = 250;
        self.shortLblTopL.priority = 999;
        self.longLblRight.priority = 999;
    }else{
        self.shortLblTop.priority = 999;
        self.shortLblLeft.priority = 999;
        self.shortLblTopL.priority = 250;
        self.longLblRight.priority = 250;
    }
    NSLog(@"%f",requiredSize.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
