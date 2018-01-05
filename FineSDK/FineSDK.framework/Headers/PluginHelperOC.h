
/*                   _ooOoo_
 *                  o8888888o
 *                  88" . "88
 *                  (| -_- |)
 *                  O\  =  /O
 *               ____/`---'\____
 *             .'  \\|     |//  `.
 *            /  \\|||  :  |||//  \
 *           /  _||||| -:- |||||-  \
 *           |   | \\\  -  /// |   |
 *           | \_|  ''\---/''  |_/ |
 *           \  .-\__  '-'  ___/-. /
 *          __'. .'  /--.--\  `. .' __
 *      ."" '<  `.___\_<|>_/___.'  >'"".
 *     | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *     \  \ `-.   \_ __\ /__ _/   .-` /  /
 *======`-.____`-.___\_____/___.-`____.-'======
 *                   `=---='
 * ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *                佛祖保佑       永无BUG */


#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "FineSDK/YFNativeAdData.h"
#import "FineSDK/YFCustomNativeAd.h"
#import <StoreKit/StoreKit.h>

@interface PluginHelperOC : NSObject

#pragma mark - init
+(PluginHelperOC *)getInstance;
/**
 * 初始化插件
 * 在启动的时候 application  didFinishLaunchingWithOptions 中调用
 * @param appKey appKey.
 * @param pubId pubId.
 * @param showBannerLocation banner显示的位置（可选项：0：top、1：bottom、2：left、3：right）.
 * @param isShowPortrait 是否为竖屏.
 * @param isDebugMode 为true则输出日志.
 */

+(void)InitPluginWithAppKey:(NSString *)appKey withPubId:(NSString *)pubId bannerLocation:(int)showBannerLocation isPortrait:(BOOL)isShowPortrait isDebug:(BOOL)isDebugMode ;
+(void)InitPluginWithAppKey:(NSString *)appKey withPubId:(NSString *)pubId bannerLocation:(int)showBannerLocation isPortrait:(BOOL)isShowPortrait isDebug:(BOOL)isDebugMode completionHandler:(void (^)(BOOL success))completionBlock;


#pragma mark - banner
/**
 判断当前banner是否正在展示
 */
+(BOOL)getIsBannerShow;
+(void)setBannerPostion:(int)position ;
+(void)showBanner;
+(void)hideBanner;
+(void)showBannerWithPostion:(int)position;
+(BOOL)hasBanner;
+(void)setBannerScale:(CGFloat)scale;

#pragma mark - interstitial
/**
 判断当前插屏是否正在展示
 */
+(BOOL)getIsInterstitialShow;
+(BOOL)hasInterstitial:(NSString *)page;
+(void)showInterstitialWithPage:(NSString *)page withEntry:(NSString *)entry shownHandler:(void (^)())shownBlock completionHandler:(void (^)(BOOL))completionBlock;
+(void)showInterstitialWithPos:(int)position withGapEnable:(BOOL)gapEnable withPage:(NSString *)page shownHandler:(void (^)())shownBlock completionHandler:(void (^)(BOOL))completionBlock;

/**
 展示插屏广告
 @param adsDisplayType 插屏广告类型 0:默认 1：展示广告 2：展示自运营
 @param page page
 @param completionBlock 完成回调
 */
+ (void)showInterstialWithDisplayType:(int)adsDisplayType withPage:(NSString *)page shownHandler:(void (^)())shownBlock completionHandler:(void (^)(BOOL isCompletion))completionBlock;

/**
 展示插屏广告
 @param adsDisplayType 插屏广告类型 0:默认 1：展示广告 2：展示自运营
 @param position 0:立即出 1:前出 2:后出
 @param gapEnable gap
 @param page page
 @param completionBlock 完成回调
 */
+(void)showInterstitialWithDisplayType:(int)adsDisplayType withPos:(int)position withGapEnable:(BOOL)gapEnable withPage:(NSString *)page shownHandler:(void (^)())shownBlock completionHandler:(void (^)(BOOL completion))completionBlock;


#pragma mark - InterstitialGift
+(BOOL)hasInterstitialGift:(NSString *)page;
+(void)showInterstitialGift:(NSString *)page shownHandler:(void (^)())shownBlock completionHandler:(void (^)(BOOL))completionBlock;

#pragma mark - icon
+(BOOL)hasIcon;
+(void)showIconWithFrame:(CGRect)rect;
+(void)clickIcon;
+(void)hideIcon;

/**
 设置游戏的分辨率适配（针对icon显示不正常的设置）
 */
+(void)setIconScaleEnable:(BOOL)enableScale;

#pragma mark - native
+(BOOL)hasNative:(NSString *)page;
+(void)hideNative;
+(void)showNativeAdWithFrame:(CGRect)rect withPage:(NSString *)page;
+(void)enableNativeColor:(BOOL)enable;
/**
 *获取指定页面的推广数据（根目录下的compaign节点）
 *@param page page
 *@param size 个数
 */
+(NSArray<YFNativeAdData *> *)getNativeAdData:(NSString *)page withSize:(NSInteger)size;
/**
 *获取应用内部的推广数据（cfg下的compaign节点）
 *@param entry 等价于adtype
 *@param size 个数
 */
+(NSArray<YFNativeAdData *> *)getSelfNativeAdData:(NSString *)entry withSize:(NSInteger)size;
/**
 *创建一个原生广告view
 *@param size 大小
 *@param page page
 *@param type 模板：1为原生；2为banner
 */
+(UIView *)getNativeViewWithSize:(CGSize)size withPage:(NSString *)page withType:(NSInteger)type;
/**
 *是否有原生广告
 *@param page page
 *@param type 模板：1为原生；2为banner
 */
+(BOOL)hasNative:(NSString *)page withType:(NSInteger)type;
/**
 *获取广告平台的原生数据(目前仅提供batmobi和facebook的原生数据)
 *@param page page
 */
+(YFCustomNativeAd *)getCustomAdData:(NSString *)page;
+(void)reloadCustomAdData;

#pragma mark - video
/**
 判断当前视频是否正在展示
 */
+(BOOL)getIsVideoShow;
+(BOOL)hasVideo:(NSString *)page;
+(void)showVideo:(NSString *)page shown:(void (^)())shownBlock withCompletion:(void (^)(BOOL))completionBlock;
/**
 * 检查是否有video或task
 * @author lihongxing
 * 返回 "video" "task" 或 ""
 */
+ (NSString *)hasVideoOrTask:(NSString *)page;

#pragma mark - More
+(BOOL)hasMore;
+(void)showMore;


#pragma mark - offer  task
/**
 检查有没有积分墙广告
 * @param taskType 任务类型，0:全部；1:安装类型；2:社交关注类型.          
 */
+(BOOL)hasOfferWithTaskType:(int)taskType withTemplateType:(int)templateType;
+(void)showOfferWithTaskType:(int)taskType withTemplateType:(int)templateType completionHandler:(void (^)(NSString *))completionBlock;
/**
 积分墙:如果上一次用户未奖励到位的补充奖励
 @param completionBlock 补充奖励的值
 */
+ (void)exeActiveTaskReward:(void (^)(NSString * rewards))completionBlock;


/**
 * 展示单个任务
 * @author lihongxing
 * @param completionBlock page
 */
+ (void)showTask:(void (^)(NSString * rewards))completionBlock;

#pragma mark - coin
+(void)setCoinUnit:(NSString *)coinUnit;
+(void)setCoinCurrency:(NSString *)coinCurrency;

#pragma mark - follow
+(BOOL)hasFollowTask;
+(BOOL)hasFollowTaskForFeature:(NSString *)feature;
+(void)clickFollowTaskForFeature:(NSString *)feature withCoins:(int)coins completionHandler:(void (^)(NSString *))completionBlock;
+(void)clearFollow;
#pragma mark - 统计
/**
 跟踪事件
 @param token token 后台申请
 @param param param
 */
+ (void)trackWithToken:(NSString *)token param:(NSDictionary *)param;
#pragma mark - UmengAnalysis
/*
 * 设置友盟统计
 * @param umengKey 友盟key
 * @param type 设置友盟统计场景类型，0为应用，1为游戏，-1为关闭友盟统计，默认为1
 */
+(void)setUmeng:(NSString *)umengKey withAnalyticsType:(int)type;

#pragma mark - FacebookAnalysis
+(void)setFacebookTrack:(NSString *)appId;

#pragma mark - 配置
+(void)setDebug:(BOOL)isDebug;//默认debug是开启的
+(void)setLevel:(NSString *)level;
+(void)setUnityAdRewardKey:(NSString *)rewardKey;

/**
 设置Adjust.
 @param appToken Adjust提供的标记
 @param environment 测试环境使用值ADJEnvironmentSandbox，发布前要设置为ADJEnvironmentProduction
 */
+(void)setAdjustWithApptoken:(NSString *)appToken withEnvironment:(NSString *)environment;
/**
 Adjust收入验证.
 @param receipt 内购凭证
 @param transaction 内购交易
 @param product 内购的产品
 */
+(void)verifyPurchaseWithReceipt:(NSData *)receipt withTransaction:(SKPaymentTransaction *)transaction withProduct:(SKProduct *)product;

/** 设置是否支持自动旋转（默认不支持）.
 @param autoRotateEnable 是否支持自动旋转.
 */
+(void)setAutoRotate:(BOOL)autoRotateEnable;
/** 设置横屏竖显的bannner和native方向（默认根据banner的方向）.
 @param position 屏竖显的bannner和native方向.
 */
+(void)setPostionOfLandscapeInPortraitMode:(int)position;

+(void)setPushEnable:(BOOL)enable;
/**
 设置游戏的分辨率适配（针对native显示不正常的设置）
 */
+(void)setScaleEnable:(BOOL)enableScale;

-(void)getNewReg;

+(void)sdkLog:(NSString *)msg;
/**
 原生缩放适配（针对Libgdx的项目）
 */
+(void)isScaleForLibgdx:(BOOL)enableScale;
//物理像素比
+ (void)isScreenNativeScale:(BOOL)isScreenNativeScale;
#pragma mark - Get
+(NSString *)getConfigParam:(NSString *)key;

+(BOOL)getCheckCtrl;

+(NSString *)getAreaCode;
//默认开启适配iPhone X（banner、native）
+ (void)setiPhoneXAjustEnable:(BOOL)enable;

#pragma mark - utils
/** 评价
 @param appId 应用ID.
 */
+(void)rate:(NSString *)appId;
/** 判断能否分享到指定的社交平台
 @param socialType 社交平台（支持的平台：facebook、twitter、sinaweibo、tencentweibo、linkedin）.
 */
+(BOOL)canShareTo:(NSString *)socialType;
/** 分享信息到指定的社交平台
 @param socialType 社交平台（支持的平台：facebook、twiiter、sinaweibo、tencentweibo、linkedin）.
 @param content 分享的内容.
 @param link 分享的链接.
 @param imagePath 分享的图片路径.
 */
+(void)shareTo:(NSString *)socialType withContent:(NSString *)content withLink:(NSString *)link withImage:(NSString *)imagePath completionHandler:(void (^)(BOOL))completionBlock;
/**
 发邮件
 
 @param toRecipients 收件人数组 如@["123@qq.com","234@qq.com"]
 @param ccRecipients 抄送人数组 如@["123@qq.com","234@qq.com"]
 @param bccRecipients 密送人数组 如@["123@qq.com","234@qq.com"]
 @param subject 主题
 @param body 邮件内容
 */
+ (void)sendEmailWithToRecipients:(NSArray *)toRecipients ccRecipients:(NSArray *)ccRecipients bccRecipients:(NSArray *)bccRecipients subject:(NSString *)subject body:(NSString *)body;

#pragma mark - IAP

/** 恢复内购
 */
+(void)restoreIAP:(void (^)(BOOL, NSArray<NSString *> *))completionBlock;

/** 购买某个商品
 @param key 屏商品ID.
 */
+(void)buyItem:(NSString *)key completionHandler:(void (^)(BOOL, NSString*))completionBlock;

#pragma mark - 测试用 -------------------
+(void)setAdmobTestId:(NSArray *)testIds;
+(void)setFacebookTestId:(NSArray *)testIds;
/** 清空本机已安装应用信息（测试用）.
 */
+(void)clearInstallAppInfo;
+ (void)refreshGeoInfoComplete:(void (^)(NSDictionary *jsonResponse, NSError * error))completionBlock;
/**
 测试用 用于输出日志的查看和控件的位置
 */
+ (void)debugHelperSetUp;
+ (void)startLog;
+ (void)setupViewDebug:(BOOL)viewDebug;
+ (void)setupLogDebug:(BOOL)logDebug;
@end
