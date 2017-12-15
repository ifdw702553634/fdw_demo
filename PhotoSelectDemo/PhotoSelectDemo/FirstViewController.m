//
//  FirstViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 16/12/2.
//  Copyright © 2016年 DreamTouch. All rights reserved.
//

#import "FirstViewController.h"
#import "SelectPhotoViewController.h"
#import "MutableLanguageViewController.h"
#import "MutableSceneViewController.h"
#import "SpeechRecognitionViewController.h"
#import "SIDViewController.h"
#import "ConstraintTestViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIButton *mutableLanguageBtn;
@property (weak, nonatomic) IBOutlet UIButton *mutableSceneBtn;
@property (weak, nonatomic) IBOutlet UIButton *speechRecognitionBtn;
@property (weak, nonatomic) IBOutlet UIButton *SIDBtn;
@property (weak, nonatomic) IBOutlet UIButton *constraintBtn;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = CustomLocalizedString(@"homeTitle", nil);
    [_photoBtn setTitle:CustomLocalizedString(@"home_Photo", nil) forState:UIControlStateNormal];
    [_mutableLanguageBtn setTitle:CustomLocalizedString(@"home_MutableLanguage", nil) forState:UIControlStateNormal];
    [_mutableSceneBtn setTitle:CustomLocalizedString(@"home_MutableScene", nil) forState:UIControlStateNormal];
    [_speechRecognitionBtn setTitle:CustomLocalizedString(@"home_Speech", nil) forState:UIControlStateNormal];
    [_SIDBtn setTitle:CustomLocalizedString(@"home_SID", nil) forState:UIControlStateNormal];
    [_constraintBtn setTitle:CustomLocalizedString(@"home_constraint", nil) forState:UIControlStateNormal];
}
- (IBAction)selectPhoto:(id)sender {
    SelectPhotoViewController *vc = [[SelectPhotoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)mutableLanguage:(id)sender {
    MutableLanguageViewController *vc = [[MutableLanguageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)mutableScene:(id)sender {
    MutableSceneViewController *vc = [[MutableSceneViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)speechRecognition:(id)sender {
    SpeechRecognitionViewController *vc = [[SpeechRecognitionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)getSID:(id)sender {
    SIDViewController *vc = [[SIDViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)constraintTest:(id)sender {
    ConstraintTestViewController *vc = [[ConstraintTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
