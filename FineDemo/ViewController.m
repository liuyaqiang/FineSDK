//
//  ViewController.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/2/22.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "ViewController.h"
#import "FineSDK/PluginHelperOC.h"
#import "MBProgressHUD+EV.h"
#import "Masonry.h"
#import "YFInterstitialDisplayViewController.h"
#import "AppDelegate.h"
#import "YFSettingViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "YFCommonHeader.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, YFCustomNativeAdDelegate>
{
    NSString *showNextControl,*setting,*banner, *hideBanner, *interstitial, *adsInterstital,*selfInterstial, *native, *hideNative, *video, *icon, *hideIcon, *more, *offer, *gift, *followTask,*videoTask, *clearFollow, *clearInstallAppInfo, *refreshGeo, *sendEmail, *iapTest, *showCustomNative, *hideCustomNative;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIView *customeView;
@property (nonatomic, strong) YFCustomNativeAd *native;

@end

@implementation ViewController

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        }else{
            make.edges.equalTo(self.view);
        }
    }];
    UIButton *rightBu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
    rightBu.backgroundColor = [UIColor blueColor];
    [rightBu setTitle:@"hidden" forState:UIControlStateNormal];
    [rightBu addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBu];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (BOOL)navigationShouldPopOnBackButton {
    [self hidden];
    return YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLa.adjustsFontSizeToFitWidth = YES;
    titleLa.text = [NSString stringWithFormat:@"appkey:%@",AppKey];
    titleLa.textColor = [UIColor blueColor];
    self.navigationItem.titleView = titleLa;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    cell.backgroundColor = [UIColor whiteColor];
    if ([text isEqualToString:setting] || [text isEqualToString:showNextControl]) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    if ([text isEqualToString:showNextControl]) {
        ViewController *ctl = [[ViewController alloc]init];
        ctl.index = self.index + 1;
        [self.navigationController pushViewController:ctl animated:YES];
        [self hidden];
    }
    else if ([text isEqualToString:setting]) {
        YFSettingViewController *setCtl = [[YFSettingViewController alloc]init];
        [self presentViewController:setCtl animated:YES completion:nil];
    }else if ([text isEqualToString:banner]) {
        //[PluginHelperOC showBannerWithPostion:Bottom];
        [PluginHelperOC showBanner];
        
    }else if ([text isEqualToString:hideBanner]){
        [PluginHelperOC hideBanner];
    }else if ([text isEqualToString:interstitial]){
        YFInterstitialDisplayViewController *ctl = [[YFInterstitialDisplayViewController alloc]init];
        ctl.displayType = 0;
        [self.navigationController pushViewController:ctl animated:YES];
    }else if([text isEqualToString:adsInterstital]){
        YFInterstitialDisplayViewController *ctl = [[YFInterstitialDisplayViewController alloc]init];
        ctl.displayType = 1;
        [self.navigationController pushViewController:ctl animated:YES];
    }else if([text isEqualToString:selfInterstial]){
        YFInterstitialDisplayViewController *ctl = [[YFInterstitialDisplayViewController alloc]init];
        ctl.displayType = 2;
        [self.navigationController pushViewController:ctl animated:YES];
    }else if ([text isEqualToString:native]){
        if ([PluginHelperOC hasNative:PAGE]) {
            [PluginHelperOC showNativeAdWithFrame:CGRectMake(0,0,500,500) withPage:PAGE];
        }else{
            [self.view showHUDWithTitle:@"no native"];
        }
    }else if ([text isEqualToString:hideNative]){
        [PluginHelperOC hideNative];
    }else if ([text isEqualToString:video]){
        if ([PluginHelperOC hasVideo:PAGE]) {
            
            [PluginHelperOC showVideo:PAGE
                                shown:^{
                                    NSLog(@"video show");
                                } withCompletion:^(BOOL completrion) {
                                    if (completrion) {
                                        [self.view showHUDWithTitle:@"kan wan"];
                                    }else{
                                        [self.view showHUDWithTitle:@"mei kan wan"];
                                    }
                                }];
        }else{
            [self.view showHUDWithTitle:@"no video"];
        }
    }else if ([text isEqualToString:icon]){
        if ([PluginHelperOC hasIcon]) {
            [PluginHelperOC showIconWithFrame:CGRectMake(100, 100, 100, 100)];
        }else{
            [self.view showHUDWithTitle:@"无Icon"];
        }
    }else if ([text isEqualToString:hideIcon]){
        [PluginHelperOC hideIcon];
    }else if ([text isEqualToString:more]){
        if ([PluginHelperOC hasMore]) {
            [PluginHelperOC showMore];
        }else{
            [self.view showHUDWithTitle:@"no more"];
        }
    }else if ([text isEqualToString:offer]){
        __block UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([PluginHelperOC hasOfferWithTaskType:0 withTemplateType:0]) {
            [PluginHelperOC showOfferWithTaskType:0 withTemplateType:0 completionHandler:^(NSString * str) {
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%ld",([cell.detailTextLabel.text integerValue] + [str integerValue])];
            }];
        }else{
            [self.view showHUDWithTitle:@"no offer"];
        }
    }else if ([text isEqualToString:gift]){
        if ([PluginHelperOC hasInterstitialGift:@"gift"]) {
            [PluginHelperOC showInterstitialGift:@"gift" shownHandler:^{
            } completionHandler:^(BOOL isClosed) {
            }];
        }else{
            [self.view showHUDWithTitle:@"no gift"];
        }
    }else if ([text isEqualToString:followTask]){
        if ([PluginHelperOC hasFollowTaskForFeature:@"facebook"]) {
            __block UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [PluginHelperOC clickFollowTaskForFeature:@"facebook" withCoins:-1 completionHandler:^(NSString *str) {
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%ld",([cell.detailTextLabel.text integerValue] + [str integerValue])];
            }];
        }else{
            [self.view showHUDWithTitle:@"no follow task for facebook"];
        }
    }else if ([text isEqualToString:clearFollow]){
        [PluginHelperOC clearFollow];
        
    }else if ([text isEqualToString:clearInstallAppInfo]){
        [PluginHelperOC clearInstallAppInfo];
    }else if ([text isEqualToString:videoTask]){
        NSString *vt = [PluginHelperOC hasVideoOrTask:PAGE];
        if ([vt isEqualToString:@"video"]) {
            [PluginHelperOC showVideo:PAGE
                                shown:^{
                                    //NSLog(@"video show");
                                } withCompletion:^(BOOL completrion) {
                                    if (completrion) {
                                        [self.view showHUDWithTitle:@"kan wan"];
                                    }else{
                                        [self.view showHUDWithTitle:@"mei kan wan"];
                                    }
                                }];
        } else if ([vt isEqualToString:@"task"]){
            __block UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [PluginHelperOC showTask:^(NSString * str) {
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%ld",([cell.detailTextLabel.text integerValue] + [str integerValue])];
            }];
        }
        else {
            [self.view showHUDWithTitle:@"no video no task"];
        }
    }else if ([text isEqualToString:refreshGeo]){
        [self.view showWaitHUD];
        [PluginHelperOC refreshGeoInfoComplete:^(NSDictionary *jsonResponse, NSError *error) {
            if (!error) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"geo_update_date"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[[NSUserDefaults standardUserDefaults] objectForKey: @"geo_info"] options:NSJSONWritingPrettyPrinted error:nil];
                [self.view showHUDWithTitle:@"geo info:" detail:[[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
            } else {
                [self.view hideHUD];
            }
        }];
    }else if ([text isEqualToString:sendEmail]){
        [PluginHelperOC sendEmailWithToRecipients:@[@"233@qq.com"] ccRecipients:nil bccRecipients:nil subject:nil body:@"1212"];
    } else if ([text isEqualToString:showCustomNative]) {
        if (self.customeView) {
            return;
        }
        self.native =  [PluginHelperOC getCustomAdData:PAGE];
        if (!self.native) {
            [self.view showHUDWithTitle:@"无数据"];
            return;
        }
        self.native.delegate = self;
        self.customeView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 300, 300)];
        self.customeView.backgroundColor = [UIColor grayColor];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        title.text = self.native.title;
        
        UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 300, 50)];
        desc.text = self.native.body;
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 50, 50)];
        [self.native loadIconAsyncWithBlock:^(UIImage * _Nullable image) {
            [icon setImage:image];
        }];
        
        UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150, 300, 100)];
        [self.native loadImageAsyncWithBlock:^(UIImage * _Nullable image) {
            [image1 setImage:image];
        }];
        
        UIButton *action = [[UIButton alloc]initWithFrame:CGRectMake(0, 250, 150, 50)];
        action.userInteractionEnabled = NO;
        [action setTitle:self.native.callToAction forState:UIControlStateNormal];
        
        [self.native registerViewForInteraction:self.customeView withViewController:self];
        [self.customeView addSubview:title];
        [self.customeView addSubview:desc];
        [self.customeView addSubview:icon];
        [self.customeView addSubview:image1];
        [self.customeView addSubview:action];
        [self.view addSubview:self.customeView];
    } else if ([text isEqualToString:hideCustomNative]) {
        if (self.customeView) {
            [self.native unRegisterView];
            [self.customeView removeFromSuperview];
            self.customeView = nil;
            [PluginHelperOC reloadCustomAdData];
        }
    }else if ([text isEqualToString:iapTest]){
        [self.view showWaitHUD];
        [PluginHelperOC buyItem:@"g7_cpar1711004.coin100.99" completionHandler:^(BOOL complete, NSString *productId) {
            NSLog(@"productId：%@，%@",productId,complete? @"内购完成" : @"内购失败");
            [self.view hideHUD];
            [self.view showHUDWithTitle:productId detail:complete? @"内购完成" : @"内购失败" duration:2];
        }];
    }else if ([text isEqualToString:@"level_info"]){
        [PluginHelperOC trackWithToken:@"level_info" param:@{@"_level":@"100",@"_state":@"1"}];
    }else if ([text isEqualToString:@"user_level"]){
        [PluginHelperOC trackWithToken:@"user_level" param:@{@"_user_level":@"1"}];
        
    }else if ([text isEqualToString:@"pay_info"]){
        [PluginHelperOC trackWithToken:@"pay_info" param:@{@"_product_id":@"153622",@"_transaction_id":@"153622",@"_price":@"9.9",@"_currency":@"CNY",@"_state":@"1"}];
        
    }
}
#pragma mark - response Event
- (void)hidden
{
    [PluginHelperOC hideNative];
    [PluginHelperOC hideBanner];
    [PluginHelperOC hideIcon];
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
    if (!_dataArr) {
        showNextControl = [NSString stringWithFormat:@"多界面test %d",self.index + 1], setting = @"setting" , banner = @"banner", hideBanner = @"hide banner", interstitial = @"interstitial",adsInterstital = @"adsInterstial",selfInterstial = @"selfInterstial",native = @"native", hideNative = @"hide native", video = @"video", icon = @"icon", hideIcon = @"hide icon", more = @"more", offer = @"offer", gift = @"gift", followTask = @"followTask", clearFollow = @"clearFollow", clearInstallAppInfo = @"clearInstallAppInfo",videoTask = @"videoTask", refreshGeo = @"refreshGeo", sendEmail = @"sendEmail", iapTest = @"iapTest", showCustomNative = @"展示原生透传", hideCustomNative = @"隐藏原生透传";
        _dataArr = @[@[showNextControl,setting ,banner, hideBanner, interstitial, adsInterstital,selfInterstial,native, hideNative, video, icon, hideIcon, more, offer, gift, followTask, clearFollow, clearInstallAppInfo,videoTask, refreshGeo,sendEmail,iapTest, showCustomNative, hideCustomNative,@"level_info",@"user_level",@"pay_info"]];
    }
    return _dataArr;
}


@end

