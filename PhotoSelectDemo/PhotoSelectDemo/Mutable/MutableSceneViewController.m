//
//  MutableSceneViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 17/1/10.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "MutableSceneViewController.h"
#import "UINavigationBar+BackgroundColor.h"

@interface MutableSceneViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *colorArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MutableSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = CustomLocalizedString(@"mutableSceneTitle", nil);;
}
-(void)prepareView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    colorArr = @[@"#d3ebdc",@"#08bb08",@"#ffc502",@"#2782d7",@"#929292",@"#ebeace",@"#e2f8e6"];
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return colorArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [[DTMutableScene shareManager] colorWithHexString:colorArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *colorStr = [NSString stringWithFormat:@"backgroundColor_%ld",(long)indexPath.row];
    [[DTMutableScene shareManager] setBackgroundColorWithColor:LocalizedString(colorStr, nil)];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forBarMetrics:UIBarMetricsDefault];

}

//设置cell分割线做对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
