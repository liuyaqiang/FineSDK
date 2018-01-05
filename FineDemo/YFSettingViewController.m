//
//  YFSettingViewController.m
//  yifanDemo
//
//  Created by liuyaqiang on 2017/4/18.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import "YFSettingViewController.h"
#import "MBProgressHUD+EV.h"
#import "YFCommonHeader.h"
#import "FineSDK/PluginHelperOC.h"

@interface YFSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *vungleMSwitch;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScollView;
@property (weak, nonatomic) IBOutlet UITextField *appKeyTextField;
@property (weak, nonatomic) IBOutlet UILabel *vungleModeLa;
@property (weak, nonatomic) IBOutlet UITextField *pageTextField;
@property (weak, nonatomic) IBOutlet UITextField *levelTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segLoc;
@property (weak, nonatomic) IBOutlet UILabel *locationLa;
@property (weak, nonatomic) IBOutlet UISwitch *logSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *deviceOrientationSeg;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSDictionary *choiceDic;
@property (nonatomic, strong) NSString *choiceKey;
@end

@implementation YFSettingViewController
- (IBAction)commitBu:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setValue:self.appKeyTextField.text forKey:NS_DEFAULT_APPKEY];
    [[NSUserDefaults standardUserDefaults] setValue:self.pageTextField.text forKey:NS_DEFAULT_PAGE];
    [[NSUserDefaults standardUserDefaults] setValue:self.levelTextField.text forKey:NS_DEFAULT_LEVEL];
    [[NSUserDefaults standardUserDefaults] setValue:@(self.segLoc.selectedSegmentIndex) forKey:NS_DEFAULT_VIEW_LOCATION];
    [[NSUserDefaults standardUserDefaults] setValue:@(self.deviceOrientationSeg.selectedSegmentIndex) forKey:NS_DEFAULT_DEVICE_ORIENTATION];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [PluginHelperOC setLevel:self.levelTextField.text];
    [self.view showHUDWithTitle:@"注意" detail:@"设置成功，请重启app" duration:3];
    
}
- (IBAction)refreshDefault:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:NS_DEFAULT_APPKEY];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:NS_DEFAULT_PAGE];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:NS_DEFAULT_LEVEL];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:NS_DEFAULT_VIEW_LOCATION];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:NS_DEFAULT_DEVICE_ORIENTATION];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view showHUDWithTitle:@"注意" detail:@"设置成功，请重启app" duration:3];
    [self refreshView];
}
- (IBAction)switchVungleMode:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:NS_DEFAULT_VUNGLE_MODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.vungleModeLa.text = sender.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";
    [self.view showHUDWithTitle:@"注意" detail:@"请重启app，从新加载数据，使vungle切换有效" duration:3];
}
- (IBAction)switchLog:(UISwitch *)sender {
    [PluginHelperOC setupLogDebug:sender.on];
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:NS_DEFAULT_LOG];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.view showHUDWithTitle:@"注意" detail:@"log状态改变，重启app，切换有效" duration:3];
}
- (IBAction)dismissCtl:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)segLocationClick:(UISegmentedControl *)sender {

}
- (IBAction)choiceAPPKey:(UIButton *)sender {
    self.choiceDic = @{@"世界很美好，空气很清晰":@"",@"有一次王家卫让演员翻译Iloveyou，演员翻译成我爱你。王说，怎么可以讲这样的话，应该是“我已经很久没有坐过摩托车了，也很久未试过这么接近一个人了，虽然我知道这条路不是很远。我知道不久我就会下车。可是，这一分钟，我觉得好暖":@"",@"你照镜子觉得自己美不美":@"",@"全世界都散发着恋爱的酸臭味，只有你散发着单身狗的清香":@"",@"我爱，祖国":@"",@"每一个不曾起舞的日子，都是对生命的辜负。":@"",@"单身久了吃个鸡爪都能感受到指尖的温柔":@"",@"看毛线":@"",@"温柔的对待每一个人":@"",@"以德服人":@"",@"有人住高楼，有人在深沟，有人光万丈，有人一身锈，世人万千种，浮云莫去求，斯人若彩虹，遇上方知有":@"",@"今天加班":@"",@"今天吃馒头":@"",@"对面的在说爱你":@"",@"没中":@""};
    
    self.choiceKey = self.choiceDic.allKeys[arc4random()%self.choiceDic.allKeys.count];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:self.choiceKey message:@"" delegate:self cancelButtonTitle:@"惊喜" otherButtonTitles:nil];
    alertView.delegate = self;
    if (arc4random()%4 == 0) {
        [alertView show];
    }else{
        [self showChoiceTableView];
    }
}
- (IBAction)deviceOrientationSegClick:(UISegmentedControl *)sender{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIApplication sharedApplication].keyWindow.frame.size.height > [UIApplication sharedApplication].keyWindow.frame.size.width ) {
        self.locationLa.hidden = NO;
        self.segLoc.hidden = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    //vungleSwitch
    [self.vungleMSwitch setOn:[[NSUserDefaults standardUserDefaults]boolForKey:NS_DEFAULT_VUNGLE_MODE]];
    self.vungleModeLa.text = self.vungleMSwitch.isOn ? @"isVungelInterstitialMode" : @"isVungleVideoMode";
    //logSwitch
    [self.logSwitch setOn:[[NSUserDefaults standardUserDefaults]boolForKey:NS_DEFAULT_LOG]];
    
    
    self.contentScollView.delegate = self;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit)];
    [self.contentScollView addGestureRecognizer:tap];
    
    [self refreshView];
}
- (void)refreshView
{
    //appKey
    self.appKeyTextField.text = AppKey;
    //page
    self.pageTextField.text = PAGE;
    //level
    self.levelTextField.text = LEVEL;
    //view_loaction
    self.segLoc.selectedSegmentIndex = VIEW_LOACTION;
    //device orientation
    self.deviceOrientationSeg.selectedSegmentIndex = DEVICE_ORIENTATION;
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)showChoiceTableView
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.5f;
    animation.timingFunction=UIViewAnimationCurveEaseInOut;
    NSArray *typeArr = @[@"rippleEffect",@"cube",@"suckEffect",@"oglFlip"];
    animation.type =  typeArr[arc4random()%typeArr.count];
    animation.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:animation forKey:@"animation"];
    [self.view addSubview:self.tableView];
    [self.view endEditing:YES];
 
}
- (void)endEdit
{
    [self.view endEditing:YES];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self showChoiceTableView];
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self endEdit];
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
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    [self customCellWithCell:cell IndexPath:indexPath];
    
    return cell;
}
//定制cell
- (void)customCellWithCell:(UITableViewCell *)cell IndexPath:(NSIndexPath *)indexPath
{
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    cell.textLabel.text = text;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectCellWithIndextPath:indexPath];
    
}
//选择cell
- (void)selectCellWithIndextPath:(NSIndexPath *)indexPath
{
    NSArray *rowArr = self.dataArr[indexPath.section];
    NSString *text = rowArr[indexPath.row];
    if (![text isEqualToString:@"关闭"]) {
        self.appKeyTextField.text = text;
    }
    [self.tableView removeFromSuperview];
}

#pragma mark - Get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    _tableView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];

    return _tableView;
}
- (NSArray *)dataArr
{
    if (!_dataArr) {

        _dataArr = @[@[@"关闭",@"a6ivlpeyjc0gg631siooaf5u",@"a6ivlpeywpns3e7agrowuprh",@"a6ivlpeygmmd6rlnsrdjjhpt",@"a6ivlpeysugcuarga4hhussn",@"a6ivlpey73whhjhmekthz3dp",@"a6ivlpeyb1ran8t1folmbmbs",@"a6ivlpeywvcsrzpufn5h1x5c",@"a6ivlpeyosngvcp9ocpo31jc",@"a6ivlpeyxomqeo3qzkdnpr2z",@"a6ivlpeymr8vrm6xycsz8sng",@"a6ivlpeyvocvcoiam9zjkeqh",@"a6ivlpeyli8rs6f0ebxzxw43",@"a6ivlpeygsmhggnuqzqanb0b",@"a6ivlpeyyxvcjamkkdtbwf0z", @"a6ivlpey0w8znoplqsub6stw",@"a6ivlpeytjduawrkyya4vxh9", @"a6ivlpeyev628qx5lzttko3g", @"a6ivlpeys26olnaptupw4yes"]];
    }
    return _dataArr;
}

@end
