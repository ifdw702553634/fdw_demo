//
//  ViewController.m
//  wifiDemo
//
//  Created by mude on 16/10/26.
//  Copyright © 2016年 mude. All rights reserved.
//

#import "SIDViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface SIDViewController ()

@property (nonatomic,strong) UILabel *testLbl;

@end

@implementation SIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 55)];
    [btn setTitle:@"SIDTEST" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:THEME_COLOR];
    [btn addTarget:self action:@selector(getSID) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _testLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y+100, SCREEN_WIDTH, 100)];
    _testLbl.text = @"BSSID:\n\nSSID:";
    _testLbl.numberOfLines = 0;
    _testLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_testLbl];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = CustomLocalizedString(@"SIDTitle", nil);
    self.view.backgroundColor = BG_COLOR;
}

- (void)getSID{
    NSDictionary *dic = [self fetchSSIDInfo];
    _testLbl.text = [NSString stringWithFormat:@"BSSID:%@\n\nSSID:%@",dic[@"BSSID"],dic[@"SSID"]];
}

-(id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    } 
    return info; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
