# iOS API接口文档 cocos2d

## 配置cocos2d工程
1. 将cocos2d helper文件夹拖入cocos2d工程中，在弹出的界面中勾选Copy items if needed。
2. 打开AppController.mm文件，导入头文件"PluginHelperCPP.h"
	```cpp
	#import "PluginHelperCPP.h"
	```
3. 初始化插件
在AppController.mm文件的 `- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`方法中，加入下面代码进行初始化。
`PluginHelperCPP::init()->initPlugin("appKey", "无特别说明这里留空", top, true, true)`;

## API使用
___注意___：下列涉及到使用page参数的方法，传递的page参数参考值为：`main`、`home`、`pause`、`switchin`、`success`、`fail`、`pause`，传空显示默认，传home显示启动页广告。
如需要实现后台对插屏展示的控制，page参数需要从对接人员处获得。

示例：
`PluginHelperCPP::init()->showInterstitial( "home", nullptr, nullptr);` //显示启动页广告（只能这样调用，其他写法均不能看到启动页广告的效果，添加于SDK初始化方法后）          
`PluginHelperCPP::init()->showInterstitial("switchin", nullptr, nullptr);` //从后台切回应用展示插屏，page参数要写switchin


### 初始化插件

```cpp
	/**
     * 初始化插件
     *在启动的时候 application  didFinishLaunchingWithOptions调用
     * @param appKey appKey.
     * @param pubId pubId（默认为空）.
     * @param showBannerLocation banner显示的位置（可选项：top、bottom、left、right）.
     * @param isShowPortrait 是否为竖屏.
     * @param isDebugMode 为true则输出日志.
     */
    void initPlugin(const char *appKey, const char *pubId, BannerPosition showBannerLocation, bool isShowPortrait, bool isDebugMode);
    /**
     * 初始化插件
     *
     * @param appKey appKey.
     * @param pubId pubId（默认为空）.
     * @param showBannerLocation banner显示的位置（可选项：top、bottom、left、right）.
     * @param isShowPortrait 是否为竖屏.
     * @param isDebugMode 为true则输出日志.
     * @param func 初始化完成的回调.
     */
    void initPlugin(const char *appKey, const char *pubId, BannerPosition showBannerLocation, bool isShowPortrait, bool isDebugMode, std::function<void()> func);

```
### Banner横幅广告

```cpp
	/**
     * 检查当前banner是否正在展示
     */
    bool getBannerShow();
    /**
     * 展示横幅广告 
     */
    void showBanner();
    /**
     * 隐藏横幅广告
     */
    void hideBanner();
    /**
     * 设置banner显示的位置
     * @param showBannerLocation banner显示的位置（可选项：top、bottom、left、right）.
     */
	void setBannerPosition(BannerPosition showBannerLocation);
	/**
     * 检查是否有banner可以展示
     */
	bool hasBanner();
```

### Interstitial插屏广告

```cpp
	/**
     * 检查当前插屏是否正在展示
     */
    bool getIsInterstitialShow();
    /**
     * 检查是否有插屏可以展示
     * @param page 将要显示广告的页面名称.
     */
	bool hasInterstitial(const char *page);
    /**
     * 展示插屏广告 
     * @param page 将要显示广告的页面名称. 
     * @param shown 返回插屏广告是否已经打开.
     * @param closed 返回插屏广告是否被关闭.
     */
    void showInterstitial(const char *page, std::function<void()> shown, std::function<void()> closed);
    /**
     * 展示插屏广告（立即出、前出、后出）
     *@param displayType 插屏的平台类型 0:默认 1:展示广告 2:展示自运营
     * @param position 0:立即出；1:前出；2:后出.
     * @param gapEnable 是否受gap参数控制.
     * @param page 将要显示广告的页面名称. 
     * @param shown 返回插屏广告是否已经打开.
     * @param closed 返回插屏广告是否被关闭.
     */
 	void showInterstitialWithTypeWithPos(int displayType,int position, bool gapEnable, const char *page, std::function<void()> shown, std::function<void()> closed);

```

### InterstitialGift礼物盒广告

```cpp
	/**
     * 检查是否有Gift插屏广告
     * @param page 将要显示广告的页面名称.
     */
    bool hasInterstitialGift(__String *page);
    /**
     * 展示Gift插屏广告
     * @param page 将要显示广告的页面名称. 
     * @param shown 返回Gift插屏广告是否已经打开.
     * @param closed 返回Gift插屏广告是否被关闭.
     */
	void showInterstitialGift(const char *page, std::function<void()> shown, std::function<void()> closed);
```

### Icon图标广告

```cpp
    /**
     * 检查有没有图标广告
     */
    bool hasIcon();
    /**
     * 展示图标广告
     * @param rect 图标广告的位置大小.
     */
    void showIcon(cocos2d::Rect rect);
    /**
     * 隐藏图标广告
     */
    void hideIcon();
    /**
     * 模拟icon点击
     */
    void iconClick();
    /**
     * 是否启用分辨率缩放适配（针对icon）
     */
    void setIconScaleEnable(bool enable);
```

### Native原生广告

```cpp
	/**
	* 检查有没有原生广告
	* @param page 广告展示的页面名称
     */
    bool hasNative(const char *page);
    /**
     * 展示原生广告
	* @param rect 原生广告的位置及大小，大小随意，建议500*500像素.
	* @param page 广告展示的页面名称
     */
    void showNative(cocos2d::Rect rect, const char *page);
    /**
     * 隐藏原生广告
     */
    void hideNative(); 
	/**
     * 是否启用分辨率缩放适配（针对native）
     */
    void setScaleEnable(bool enable);	
    /**
     * 是否显示native的背景色（测试用）
     * @param enable 是否显示native的背景色（测试用）
     */
    void setNativeBg(bool enable);

```

### Video视频广告

```cpp
	/**
     * 检查当前视频是否正在展示
     */
    bool getVideoShow();
    /**
	* 检查有没有视频广告
	* @param page 广告展示的页面名称
     */
    bool hasVideo(const char *page);
    /**
	* 展示视频广告
	* @param page 广告展示的页面名称
     * @param shown 返回视频是否已经打开.
     * @param closed 返回视频是否被完整播放.
     */
    void showVideo(const char *page, std::function<void()> shown, std::function<void(const EVedioResultType& type)> closed);
     /**
	* 检查是否有video或task 返回 "video" "task" 或 ""
	* @param page 广告展示的页面名称
     */
    const char * hasVideoOrTask(const char *page);
```

### More更多

```cpp
	/**
	* 检查有没有更多广告
	* @param page 广告展示的页面名称
    */
    bool hasMore(const char *page);
    /**
	* 展示更多广告
	* @param page 广告展示的页面名称
    */
    void showMore(const char *page);
```

### Offer积分墙

```cpp
	/**
	 * 检查有没有积分墙广告
     * @param taskType 任务类型，0:全部；1:安装类型；2:社交关注类型.
     * @param templateType 模板类型，0:显示积分；1:显示start文本.
	 */
    bool hasOffer(int taskType, int templateType);
    /**
	 * 展示积分墙广告
     * @param taskType 任务类型，0:全部；1:安装类型；2:社交关注类型.
     * @param templateType 模版类型，0:显示积分；1:显示start文本.
     * @func 积分奖励回调.
     */
    void showOffer(int taskType,  int templateType, std::function<void(const char *rewards)> func);
    /**
     * 积分墙:如果上一次用户未奖励到位的补充奖励
     *@param completionBlock 补充奖励的值
     */
	void exeActiveTaskReward (std::function<void(const char *rewards)> func);
    /**
	 * 展示单个任务
	 * @param page 广告展示的页面名称
     * @func 积分奖励回调.
     */
    void showTask(const char *page, std::function<void(const char *rewards)> func);
    /**
     * 设置积分墙积分单位
     * @param unit 积分单位，默认为coins.
     */
    void setCoinUnit(const char *unit);
    /**
     * 设置积分墙汇率
     * @param currency 积分墙汇率，默认为1.
     */
    void setCoinCurrency(const char *currency);

```

### Follow 社交平台关注

```cpp
	/**
     * 检查是否有社交平台的关注任务
     * @param feature 社交平台.
     */
    bool hasFollowTask();
    /**
     * 清空已关注的社交账号信息［该功能多在测试的情况下使用］
     */
    void clearFollow(); 
    /**
     * 检查是否有指定社交平台的关注任务
     * @param feature 社交平台（支持的社交平台有:facebook、twitter、wechat、instagram、vk、youtube）.
     */
    bool hasFollowTaskForFeature(const char *feature);
    /**
     * 跳转关注
     * @param feature 社交平台.
     * @param coins 设置奖励积分（－1表示使用后台配置的金币进行奖励，否则使用传入的值作为金币进行奖励）.
     * @param func 积分回调.
     */
    void clickFollowTaskForFeature(const char *feature, int coins, std::function<void(const char *rewards)> func);
```

### UmengAnalysis友盟

```cpp
	/**
     * 设置友盟appkey
     * @param umengKey 友盟key. 
     * @param type 友盟统计场景类型 0为应用，1为游戏，-1为关闭友盟统计，默认为1.
     */
    void setUmeng(const char *umengKey, int type = 1);
```

### FacebookAnalysis

```cpp
	/**
     * 设置Facebook追踪
     * @param appID Facebook应用ID.
     */
    void setFacebookTrack(const char *appId);

```

### HolaAnalysis

```cpp
	/**
     * 设置Hola统计
	 * @param productId 产品ID.
     * @param appId 应用ID
     */
    void setHolaAnalysis(const char *productId, const char *appId);

```

### Adjust

```cpp
	/**
     * 设置Adjust.
     * @param appToken Adjust提供的标记
     * @param enviconment 测试环境使用值ADJEnvironmentSandbox，发布前要设置为ADJEnvironmentProduction
     */
    void setAdjustWithApptoken(const char *appToken, const char *environment);
```

### 其他配置

```cpp
	/**
     * 获取在线参数
     * @param key 在线参数的key.
     */
    const char * getOnlineParam(const char *key);
    /**
     * 返回check_ctrl所在参数计算结果
     */
    bool getCheckCtrl();
    /**
     * 设置游戏关卡
     * @param level 关卡数.
     */
    void setLevel(const char *level);
    /**
     * 设置Unity视频奖励广告的zone，强制用户观看完整视频。。。
     * @param reward .
     */
    void setUnityZoneId(const char *zoneId);
    /**
     * 设置是否支持自动旋转（默认不需要设置）
     * @param autoRotateEnable 是否支持自动旋转.
     */
    void setAutoRotate(bool autoRotateEnable);
    /**
     * 设置横屏竖写的bannner和native方向（默认根据banner的方向）.
     * @param position 屏竖显的bannner和native方向.
     */
    void setPostionOfLandscapeInPortraitMode(BannerPosition position);
    /**
     * 获取地理位置信息（国家）
     */
    const char * getGeo();
    /**
     * 获取地区代码
     */
    const char * getAreaCode();
    /**
     * 是否启用push
     * @param enable 是否启用push
     */
    void setPushEnable(bool enable); 
    /**
     * 评价
     * @param appId 应用ID
     */
    void rate(const char *appId);
    /**
     * 判断能否分享到指定社交平台
     * @param socialType 社交平台（支持的社交平台：facebook、twitter、sinaweibo、tencentweibo、linkedin）
     */
    bool canShareTo(const char *socialType);
    /**
     * 分享到指定社交平台
     * @param socialType 社交平台（支持的社交平台：facebook、twitter、sinaweibo、tencentweibo、linkedin）
     * @param content 分享的内容
     * @param link 分享的链接
     * @param imagePath 分享的图片地址
     */
	void shareTo(const char *socialType, const char *content, const char *link, const char *imagePath, std::function<void(bool result)> func);
	/**
     * 恢复已购买的商品
     */
    void restoreIAP(std::function<void(bool result, const char *productIds)> func);
  
    /**
     * 购买某项商品
     * @param productId 商品ID
     */
	void buyItem(const char *productId, std::function<void(bool result, const char *productId)> func);

```

### 测试

```cpp
	/**
     * 设置admob广告测试id
     * @param testId 测试id（多个ID使用英文逗号分割）.
     */
    void setAdmobTestId(const char *testId); 
    /**
     * 设置facebook广告测试id
     * @param testId 测试id（多个ID使用英文逗号分割）.
     */
    void setFacebookTestId(const char *testId);
    /**
     * 清空本机已安装应用信息（测试用）.
     */
	void clearInstalledAppInfo();
	/**
     测试用 用于输出日志的查看和控件的位置
     在debug模式下调用
     */
    void debugHelperSetUp();
```