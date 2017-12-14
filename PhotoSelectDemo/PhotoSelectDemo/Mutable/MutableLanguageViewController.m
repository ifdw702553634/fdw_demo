//
//  MutableLanguageViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 17/1/10.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "MutableLanguageViewController.h"
#import "AppDelegate.h"

@interface MutableLanguageViewController ()
@property (strong,nonatomic) NSString *stringPath;

@property (weak, nonatomic) IBOutlet UIButton *simpleChinese;
@property (weak, nonatomic) IBOutlet UIButton *english;
@property (weak, nonatomic) IBOutlet UIButton *tChinese;
@property (strong,nonatomic) AppDelegate * appDelegate;

@end

@implementation MutableLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = CustomLocalizedString(@"mutableLanguageTitle", nil);
    if ([[DTMutableLanguage shareInstance] isEnglishLanguage]) {
        [_simpleChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_english setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_tChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _english.enabled = NO;
        _simpleChinese.enabled = YES;
        _tChinese.enabled = YES;
    }else if ([[DTMutableLanguage shareInstance] isChineseTraditionalLanguage]){
        [_simpleChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_english setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_tChinese setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _english.enabled = YES;
        _simpleChinese.enabled = YES;
        _tChinese.enabled = NO;
    }else{
        [_simpleChinese setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_english setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_tChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _english.enabled = YES;
        _simpleChinese.enabled = NO;
        _tChinese.enabled = YES;
    }
}

- (IBAction)chineseSimpleBtn:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否设置为简体中文？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nullable action){
        [[DTMutableLanguage shareInstance] setChineseSimpleLanguage];
        [_simpleChinese setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_english setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_tChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _english.enabled = YES;
        _simpleChinese.enabled = NO;
        _tChinese.enabled = YES;
        self.title = CustomLocalizedString(@"mutableLanguageTitle", nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)englishBtn:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Whether set to English?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nullable action){
        [[DTMutableLanguage shareInstance] setEnglishLanguage];
        [_simpleChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_english setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_tChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _english.enabled = NO;
        _simpleChinese.enabled = YES;
        _tChinese.enabled = YES;
        self.title = CustomLocalizedString(@"mutableLanguageTitle", nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)chineseT:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否設置為繁體中文" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nullable action){
        [[DTMutableLanguage shareInstance] setChineseTraditionalLanguage];
        [_simpleChinese setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_english setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_tChinese setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _english.enabled = YES;
        _simpleChinese.enabled = YES;
        _tChinese.enabled = NO;
        self.title = CustomLocalizedString(@"mutableLanguageTitle", nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
