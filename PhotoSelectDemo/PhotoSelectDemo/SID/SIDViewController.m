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
    
    NSString *strHTML = @"<p style=\"text-indent: 32px;\"><span style=\"font-family:宋体;font-size:16px\">.</span><span style=\";font-family:宋体;font-size:16px\"><span style=\"font-family:宋体\">一、入住登记及离店手续：</span> <span style=\"font-family:宋体\">入住酒店时请出示您的会员卡号，并以您在预订时所登记的姓名办理相关手续，填写入住登记表格后缴纳房牌钥匙押金（该押金将在办理完退房手续后退还给您），即可入住酒店。</span> <span style=\"font-family:宋体\">退房前请提前通知酒店客房中心或总台，待酒店查房完毕，结清除房费之外的其他费用，酒店退还您的房牌钥匙押金后，即可离店。</span></span><span style=\";font-family:宋体;font-size:16px\"><br/></span><span style=\";font-family:宋体;font-size:16px\"><br/></span><span style=\";font-family:宋体;font-size:16px\"><span style=\"font-family:宋体\">二、预定变更：</span> <span style=\"font-family:宋体\">所有的预定变更，包括延期抵达、提前离店、房间类型，定房数量等，请提前</span>24小时通知我们订单的修改或取消，以便我们能为您及时地调整，避免空房而造成的损失。</span><span style=\";font-family:宋体;font-size:16px\"><br/></span><span style=\";font-family:宋体;font-size:16px\"><br/></span><span style=\";font-family:宋体;font-size:16px\"><span style=\"font-family:宋体\">三、预定取消：</span> <span style=\"font-family:宋体\">如果您在入住酒店的前</span>24小时通知我们取消预定，我们将不收取任何费用，如果在此时间之后通知我们取消预定，我们将照常扣除相应点数间次。</span></p>";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y+100+100, SCREEN_WIDTH, SCREEN_HEIGHT-(btn.frame.origin.y+100+100))];
    [self.view addSubview:webView];
    
    [webView loadHTMLString:strHTML baseURL:nil];
    
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
