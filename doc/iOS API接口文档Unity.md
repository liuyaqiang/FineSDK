# iOS API接口文档Unity

## 配置 Xcode工程
1. 将unity helper文件夹拖入xcode工程中，在弹出的界面中勾选Copy items if needed
2. 打开UnityAppController.mm文件导入头文件
	```cpp
	#include "iOSPluginHelper.h"
	#include "MetaUnity.h"
	```
3. 初始化插件
	在UnityAppController.mm 文件的`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`方法中，加入下面代码进行初始化并配置相关信息。
`MetaUnity::getInstance()->invokeMeta(YF_INIT_PLUGIN, "{\"appkey\":\"appKey\",\"pubId\":\"pubId无特别说明这里留空\",\"bannerLocation\":\"Bottom\",\"isPortrait\":\"true\",\"isDebug\":\"true\"}")`; 

## API使用

__注意__：下列涉及到使用page参数的方法，传递的page参数参考值为：`main`、`home`、`pause`、`switchin`、`success`、`fail`、`pause`，传空显示默认，传home显示启动页广告。
如需要实现后台对插屏展示的控制，page参数需要从对接人员处获得。

示例：
```cpp
MetaUnity::getInstance()->invokeMeta(YF_SHOW_INTERSTITIAL_COMMON, "{\"page\":\"home\"}");//显示启动页广告（只能这样调用，其他写法均不能看到启动页广告的效果，添加于SDK初始化方法后）展示插屏广告
MetaUnity::getInstance()->invokeMeta(YF_SHOW_INTERSTITIAL_COMMON, "{\"page\":\"switchin\"}"); //从后台切回应用展示插屏，page参数要写switchin
```

### 初始化插件

```cpp
	/**
     * 初始化插件
     *在启动的时候 application  didFinishLaunchingWithOptions调用
     * @param appKey appKey.
     * @param pubId pubId（默认为空）.
     * @param showBannerLocation banner显示的位置（可选项：Top、Bottom、Left、Right）.
     * @param isShowPortrait 是否为竖屏.
     * @param isDebugMode 为true则输出日志.
     */
	MetaUnity::getInstance()->invokeMeta(YF_INIT_PLUGIN, "{\"appkey\":\"替换appKey\",\"pubId\":\"pubId默认为空\",\"bannerLocation\":\"Bottom\",\"isPortrait\":\"true\",\"isDebug\":\"true\"}");

```

### Banner横幅广告

```cpp
/**
*设置banner位置
*@param showBannerPosition banner位置. （可选项：Top、Bottom、Left、Right）
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_BANNER_POSITION, "{\"bannerLocation \":\"Bottom\"}");
/**
*展示banner广告
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_BANNER, "");
/**
*隐藏banner广告
*/
MetaUnity::getInstance()->invokeMeta(YF_HIDE_BANNER, "");
/**
*检查是否有banner可以展示
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_BANNER, "");
/**
*检查当前banner是否正在展示
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_IS_BANNER_SHOW, "");
```

### Interstitial插屏广告

```cpp
/**
*获取当前插屏是否正在展示 
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_IS_INTERSTITIAL_SHOW, ""); /**
/*展示插屏广告
*@param page 将要显示广告的页面名称【如果是启动插屏，page的值必须是home】. 
*@param entry 广告入口点，可为空
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_INTERSTITIAL_COMMON, "{\"page\":\"main\"}");
/**
*展示插屏广告（立即出、前出、后出）
*@param position 0:立即出；1:前出；2:后出.
*@param gapEnable 是否受gap参数控制.
*@param page 将要显示广告的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_INTERSTITIAL_SPECIAL, "{\"page\":\"main\",\"position\":\"0\",\"gapEnable\":\"false\"}");
/**
* 展示插屏广告
*@param displayType 插屏的平台类型 0:默认 1:展示广告 2:展示自运营
* @param page 将要显示广告的页面名称.
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_TYPE_INTERSTITIAL, "{\"page\":\"main\",\"displayType\":\"1\"}");
/**
* 展示插屏广告（立即出、前出、后出）
*@param displayType 插屏的平台类型 0:默认 1:展示广告 2:展示自运营
* @param position 0:立即出；1:前出；2:后出.
* @param gapEnable 是否受gap参数控制.
* @param page 将要显示广告的页面名称.
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_TYPE_INTERSTITIAL_SPECIAL, "{\"page\":\"main\",\"displayType\":\"1\",\"position\":\"0\",\"gapEnable\":\"false\"}");

```

### InterstitialGift礼物盒广告

```cpp
/**
*检查是否有Gift插屏. 
*@param page 将要展示Gift插屏的页面名称. 
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_INTERSTITIAL_GIFT, "{\"page\":\"gift\"}");
/**
*展示Gift插屏
*@param page 将要展示Gift插屏的页面名称. 
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_INTERSTITIAL_GIFT, "{\"page\":\"gift\"}");


```

### Icon图标广告

```cpp
/**
*检查有没有图标广告
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_ICON, "");
/**
*展示图标广告
*@param x 图标广告的左下角坐标的x值.
*@param y 图标广告的左下角坐标的y值
*@param width 图标广告的宽（单位像素）
*@param height 图标广告的高（单位像素）
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_ICON, "{\"x\":\"80\", \"y\":\"281\",\"width\":\"96\", \"height\":\"96\"}");
/**
*隐藏图标广告
*/
MetaUnity::getInstance()->invokeMeta(YF_HIDE_ICON, "")
/**
*模拟icon点击
*/
MetaUnity::getInstance()->invokeMeta(YF_ICON_CLICK, "");
/**
*是否启用分辨率缩放适配（针对icon）
*@param enable 是否启用缩放适配.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_ICON_SCALE_ENABLE, "{\"enable\":\"false\"}");

```

### Native原生广告

```cpp
/**
*检查有没有原生广告
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_NATIVE, "{\"page\":\"main\"}");
/**
*展示原生广告
*@param x 原生广告的左下角坐标的x值.
*@param y 原生广告的左下角坐标的y值
*@param width 原生广告的宽（单位像素）
*@param height 原生广告的高（单位像素）. 
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_NATIVE, "{\"x\":\"80\", \"y\":\"281\",\"width\":\"96\", \"height\":\"96\", \"page\":\"main\"}");
/**
*隐藏原生广告
*/
MetaUnity::getInstance()->invokeMeta(YF_HIDE_NATIVE, "");
/**
*获取自运营的原生广告数据
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_NATIVE_DATA, "");
/**
*自运营的原生广告点击
*/
MetaUnity::getInstance()->invokeMeta(YF_SELF_NATIVE_CLICK, "");
/**
*获取配置文件中的compaign数据
*@param size 条数.
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_NATIVE_DATAS, "{\"size\":\"10\"}");
/**
*配置文件中的compaign数据广告点击
*@param appId 应用id.
*/
MetaUnity::getInstance()->invokeMeta(YF_NATIVE_CLICK, "{\"appId\":\"appId\"}");
/**
*是否启用分辨率缩放适配（针对native）
*@param enable 是否启用缩放适配.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_SCALE_ENABLE, "{\"enable\":\"false\"}");
/**
*设置是否显示native背景色（测试用）
*@param enable 是否显示native背景色.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_NATIVE_BG_ENABLE, "{\"enable\":\"true\"}");

```

### Video视频广告

```cpp
/**
*获取当前视频是否正在展示）
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_IS_VIDEO_SHOW, ""); 
/**
*检查有没有视频广告
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_VIDEO, "{\"page\":\"main\"}"); 
/**
*展示视频广告
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_VIDEO, "{\"page\":\"main\"}");
/**
*检查是否有video或task(返回 "video" "task" 或 "")
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_VIDEO_OR_TASK, "{\"page\":\"main\"}");
/**
*设置Unity视频奖励广告的zone，强制用户观看完整视频。。。
*@param zoneId zone值.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_UNITY_ZONE_ID, "{\"zoneId\":\"\"}");

```

### More更多

```cpp
/**
*检查有没有更多广告
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_MORE, "{\"page\":\"main\"}");
/**
*展示更多广告
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_MORE, "{\"page\":\"main\"}");

```

### Offer积分墙

```cpp
/**
*检查有没有积分墙广告
      *@param taskType 任务类型，0:全部；1:安装类型；2:社交关注类型. 
      *@param templateType 模板类型，0:显示积分；1:显示start文本.
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_OFFER, "{\"templateType\":\"1\", \"taskType\":\"1\"}");
/**
*展示积分墙广告
      *@param taskType 任务类型，0:全部；1:安装类型；2:社交关注类型. 
      *@param templateType 模板类型，0:显示积分；1:显示start文本.
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_OFFER, "{\" templateType\":\"1\", \"taskType\":\"1\"}}"); 
/**
*积分墙:如果上一次用户未奖励到位的补充奖励
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_EXE_TASK_REWARD, "");
/**
*展示单个任务
*@param page 展示的页面名称
*/
MetaUnity::getInstance()->invokeMeta(YF_SHOW_TASK, "{\"page\":\"main\"}"); 
/**
*设置积分墙积分单位
*@param unit 积分单位，默认为coins.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_COIN_UNIT, "{\"unit\":\"coins\"}"); 
/**
*设置积分墙汇率
*@param currency 积分墙汇率，默认为1.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_COIN_CURRENCY, "{\"currency\":\"1\"}");

```

### Follow 社交平台关注

```cpp
/**
*清空已关注的社交账号信息［该功能多在测试的情况下使用］
*/
MetaUnity::getInstance()->invokeMeta(YF_CLEAR_FOLLOW, "");
/**
*检查是否有社交平台的关注任务
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_FOLLOW_TASK, "");
/**
*检查是否有指定社交平台的关注任务
*@param feature 社交平台（支持的社交平台有:facebook、twitter、wechat、instagram、vk、youtube）
*/
MetaUnity::getInstance()->invokeMeta(YF_HAS_FOLLOW_TASK_FOR_FEATURE, "{\"feature\":\"facebook\"}");
/**
*跳转关注
*@param feature 社交平台.
*@param coins 设置奖励积分（-1表示使用后台配置，否则使用传入的值作为金币进行奖励）.
*/
MetaUnity::getInstance()->invokeMeta(YF_CLICK_FOLLOW_TASK_FOR_FEATURE, "{\"feature\":\"facebook\",\"coins\":\"100\"}");

```

### UmengAnalysis友盟

```cpp
/**
*设置友盟appkey
*@param umengKey 友盟key.
*@param type 友盟统计场景类型 0为应用，1为游戏，-1为关闭友盟统计，默认为1.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_UMENG, "{\"umengKey\":\"umengKey\",\"type\":\"1\"}");

```

### FacebookAnalysis

```cpp
/**
*设置Facebook追踪
*@param appID Facebook应用ID.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_FACEBOOK_TRACK_APPID, "{\"appID\":\"1735697793347253\"}");

```

### HolaAnalysis

```cpp
/**
*设置Hola统计
*@param productId 产品ID.
*@param appID 应用ID.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_HOLA_ANALYSIS, "{\"productId\":\"1735697793347253\",\"appID\":\"1735697793347253\"}");


```

### Adjust

```cpp
/**
*设置Adjust.
*@param appToken Adjust提供的标记
*@param enviconment 测试环境使用值ADJEnvironmentSandbox，发布前要设置 
为ADJEnvironmentProduction
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_ADJUST_WITH_APPTOKEN, "{\"appToken\":\"appToken\",\"environment\":\"environment\"}");

```

### 其他配置

```cpp
/**
*获取在线参数.
*@param key 在线参数的key
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_ONLINE_PARAM, "{\"key\":\"mykey\"}");
/**
*返回check_ctrl所在参数计算结果
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_CHECK_CTRL, "");
/**
*设置游戏关卡
*@param level 关卡数.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_LEVEL, "{\"level\":\"3\"}");
/**
*设置是否支持自动旋转（默认不要设置）
*@param enable 是否支持自动旋转. 
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_AUTO_ROTATE_ENABLE, "{\"enable\":\"false\"}");
/**
*设置横屏竖写的banner和native方向（默认根据banner的方向）
*@param position 横屏竖写的banner和native方向.
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_POSITION_OF_L_P, "{\"bannerLocation\":\"Top\"}"); 
/**
*获取地区代码
*/
MetaUnity::getInstance()->invokeMeta(YF_GET_AREA_CODE, "");
/**
*设置是否启用push
*@param enable 是否启用push. 
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_PUSH_ENABLE, "{\"enable\":\"true\"}");
/**
*评价
* @param appId 应用ID
*/
MetaUnity::getInstance()->invokeMeta(YF_RATE, "{\"appId\":\"appId\"}");
/**
*判断能否分享到指定社交平台
* @param socialType 社交平台（支持的社交平台：facebook、twitter、sinaweibo、tencentweibo、linkedin）
*/
MetaUnity::getInstance()->invokeMeta(YF_CAN_SHARE_TO, "{\"socialType\":\"facebook\"}");
/**
* 分享到指定社交平台 
* @param socialType 社交平台（支持的社交平台：facebook、twitter、sinaweibo、tencentweibo、linkedin）
* @param content 分享的内容
* @param link 分享的链接
* @param imagePath 分享的图片地址
*/
MetaUnity::getInstance()->invokeMeta(YF_SHARE_TO, "{\"socialType\":\"facebook\",\"content\":\"content\",\"link\":\"link\",\"imagePath\":\"imagePath\"}");
/**
* 恢复已购买的商品
*/
MetaUnity::getInstance()->invokeMeta(YF_IAP_RESTORE,"");
/**
 * 购买某项商品
* @param productId 商品ID
 */
MetaUnity::getInstance()->invokeMeta(YF_IAP_BUY_ITEM, "{\"productId\":\"productId\"}");

```

### 测试

```cpp
/**
*使用admob的测试广告
*@param testId admob的测试id. （多个id要用逗号分割）
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_ADMOB_TEST_ID, "{\"testId\":\"132456\"}");
/**
*使用facebook的测试广告
*@param testId facebook的测试id. （多个id要用逗号分割）
*/
MetaUnity::getInstance()->invokeMeta(YF_SET_FACEBOOK_TEST_ID, "{\"testId\":\"123456\"}");
/**
*清空已安装应用信息（仅测试用）
*/
MetaUnity::getInstance()->invokeMeta(YF_CLEAR_INSTALLED_APP, "");
/**
*测试用 用于输出日志的查看和控件的位置 在debug模式下调用
*/
MetaUnity::getInstance()->invokeMeta(YF_CLEAR_DEBUG_HELPER,"");

```