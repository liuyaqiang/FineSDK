//
//  ViewController.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/2/22.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "YFInterstitialDisplayViewController.h"
#import "FineSDK/PluginHelperOC.h"
#import "MBProgressHUD+EV.h"
#import "Masonry.h"
#import "YFCommonHeader.h"

#define BEFORE_SHOW_GAP @"前出"
#define AFTER_SHOW_GAP @"后出"
#define BEFORE_SHOW_NO_GAP @"前出(不受gap控制)"
#define AFTER_SHOW_NO_GAP @"后出(不受gap控制)"

@interface YFInterstitialDisplayViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *interstitial,*posIntAhead_noGap, *posIntAfter_noGap, *posIntAhead_gap, *posIntAfter_gap;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation YFInterstitialDisplayViewController
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.displayType) {
        case 0:
            self.title = @"default interstitial";
            break;
        case 1:
            self.title = @"ads interstitial";
            break;
        case 2:
            self.title = @"self interstital";
            break;
        default:
            break;
    }
    
    interstitial = @"正常出",posIntAhead_noGap = BEFORE_SHOW_NO_GAP, posIntAhead_gap = BEFORE_SHOW_GAP;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIButton *rightBu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    [rightBu setTitle:@"hidden" forState:UIControlStateNormal];
    [rightBu addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBu];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark -
#pragma mark UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowArr = self.dataArr[section];
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    cell.textLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    __block UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([text isEqualToString:interstitial]){
        [PluginHelperOC showInterstialWithDisplayType:self.displayType withPage:PAGE shownHandler:nil completionHandler:nil];
    }
    //    else if ([text isEqualToString:BEFORE_SHOW_NO_GAP]){
    //        posIntAhead_noGap = cell.textLabel.text = AFTER_SHOW_NO_GAP;
    //        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:1 withGapEnable:NO withPage:PAGE shownHandler:^{
    //        } completionHandler:^(BOOL completion) {
    //        }];
    //    }else if ([text isEqualToString:AFTER_SHOW_NO_GAP]){
    //        posIntAhead_noGap = cell.textLabel.text = BEFORE_SHOW_NO_GAP;
    //        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:2 withGapEnable:NO withPage:PAGE shownHandler:^{
    //        } completionHandler:^(BOOL completion) {
    //        }];
    //    }
    else if ([text isEqualToString:BEFORE_SHOW_GAP]){
        posIntAhead_gap = cell.textLabel.text = AFTER_SHOW_GAP;
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:1 withGapEnable:YES withPage:PAGE shownHandler:nil completionHandler:nil];
    }else if ([text isEqualToString:AFTER_SHOW_GAP]){
        posIntAhead_gap = cell.textLabel.text = BEFORE_SHOW_GAP;
        [PluginHelperOC showInterstitialWithDisplayType:self.displayType withPos:2 withGapEnable:YES withPage:PAGE shownHandler:nil completionHandler:nil];
    }
    
    
}

#pragma mark - response Event
- (void)hidden
{
    [PluginHelperOC hideBanner];
    [PluginHelperOC hideIcon];
    [PluginHelperOC hideNative];
}

#pragma mark - Get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
- (NSArray *)dataArr
{
    //if (!_dataArr) {
    
    _dataArr = @[@[ interstitial, posIntAhead_gap]];
    //}
    return _dataArr;
}

@end
