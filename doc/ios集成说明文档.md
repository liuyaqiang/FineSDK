# IOS-SDK 集成说明文档

重要提示：
SDK中的友盟统计，Adjust统计和Facebook追踪统计**`默认是不启用`**的。
使用友盟统计，Adjust统计和Facebook追踪统计需要在初始化SDK后调用以下3个方法：
setFacebookTrack：设置Facebook追踪统计
setUmeng：设置友盟统计
setAdjustWithApptoken：设置Adjust统计

	技术支持 QQ: 344257448、495145872、875252169、359623941

## 集成步骤

### 一、获取AppKey
在集成SDK之前，需要相关负责人在管理后台添加新应用，并获得AppKey。

### 二、解压
针对此SDK的所有操作(包括解压缩)都需要在Mac OS上进行（**`请勿在Windows上进行相关操作`**）

### 三、导入SDK
* 将`FineSDK.framework`和`PluginSDKResources.bundle`这两个主库文件拖入Xcode工程目录结构中，在弹出的界面中勾选**Copy items into destination group's folder(if needed)**，如下图示。
  
  ![copy items](https://coding.net/u/yeahyf/p/SDKGuide_iOS/git/raw/master/doc/doc_pic/copy_items.png)

 在General\>Embedded Binaries加入`FineSDK.framework` （如果用到adjust,此处也要加入`AdjustSDK.framework`）
 
  ![embedded finesdk.framework](https://coding.net/u/yeahyf/p/SDKGuide_iOS/git/raw/master/doc/doc_pic/embedded.jpg)

* 将所需广告SDK（Libs文件夹中），按照您的需要拖入Xcode工程目录结构中，在弹出的界面中勾选**Copy items into destination group's folder(if needed)**，

	AdMob广告需要添加的库为`GoogleMobileAds.framework`；

	Facebook广告需要添加的的库为`Bolts.framework`、`FBAudienceNetwork.framework`、`FBSDKCoreKit.framework`；

	Vungle视频广告需要添加的库为`VungleSDK.framework`；

	Unity视频广告需要添加的库为`UnityAds.framework`；

	AppLovin广告需要添加的库为`AppLovinSDK.framework`；

	Adjust需要添加的库有2个，分别为`AdjustSdk.framework`、`AjustPurchaseSdk.framework`；

	Umeng需要添加的库为`UMMobClick.framework`；

	Avocarrot需要添加的库有6个，分别为`AvocarrotCore.framework`、`AvocarrotInterstitial.framework`、`AvocarrotNativeAssets.framework`、`AvocarrotNativeView.framework`、`Mraid.framework`、`Vast.framework`；

	AdColony需要添加的库为`AdColony.framework`；

	有米广告需要添加的库为`AdxmiMergeSDK.framework`；

	百度广告需要添加的库为`DUModuleSDK.framework`；

	IronSource需要添加的库为`IronSource.framework`；

	Mobvista需要添加的库为`MVSDK.framework`、`MVSDKInterstitial.framework`、`MVSDKReward.framework`；

	BatMobi需要添加的库为`ZZAdSDK.framework`、`zzAdImage.bundle`(注:这个bundle仅插屏广告需要)；

	Appnext需要添加`libAppnextLib.a`、`libAppnextNativeAdsSDK.a`、`libAppnextSDKCore.a`；

	Tapjoy广告需要添加的库为`Tapjoy.embeddedframework`；
	
	AvidlyAds 需要添加的库为 `AvidlyAds.framework`；

	Inneractive 需要添加的库为 `IASDKCore.framework`、 `IASDKMRAID.framework`、`IASDKResources.bundle`；

	Centrixlink 需要添加的库为 `Centrixlink.framework`；

	___注意___：有米跟Avocarrot这两个库一起用会有冲突，所以只能使用选择使用其中一个。

	集成正确的库在xcode工程中看起来应该如下图示：

	![libs](https://coding.net/u/yeahyf/p/SDKGuide_iOS/git/raw/master/doc/doc_pic/libs.png)


### 四、在Info.plist文件中增加字段

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>LSApplicationQueriesSchemes</key>
    <array>
<string>fb</string>
<string>twitter</string>
<string>vk</string>
<string>youtube</string>
<string>instagram</string>
<string>tumblr</string>
<string>fbapi</string>
<string>fb-messenger-api</string>
<string>fbauth2</string>
<string>fbshareextension</string>
<string>itmsapps</string>
<string>itmss</string>
<string>itms</string>
    </array>
<key>NSBluetoothPeripheralUsageDescription</key>
    <string>Advertisement would like to use bluetooth.</string>
<key>NSCalendarsUsageDescription</key>
<string>Advertisement would like to create a calendar event.</string>
<key>NSPhotoLibraryUsageDescription</key>
    <string>Advertisement would like to store a photo.</string>
<key>NSCameraUsageDescription</key>
<string>Some ad content may access camera to take picture.</string>
<key>NSMotionUsageDescription</key>
<string>Some ad content may require access to accelerometer for interactive ad experience.</string>

```

___注意___：如果需要使用AppLovin广告，需要在info.plist中添加如下两行字段

```xml
<key>AppLovin_Key</key>
<string>这里替换你们自己的AppLovin的key</string>
```

### 五、在Build Phases——Link Binary With Libraries 中添加如下图示的所有库文件：

  ![link_binary_00](https://coding.net/u/yeahyf/p/SDKGuide_iOS/git/raw/master/doc/doc_pic/link_binary.png)

  ___注意___：如果报GCControl的错误，还需要添加`GameController.framework`

  ___注意___：如果xcode版本是9.0以上，这些依赖的库需要手动加上。以及在Build Phases - Copy Bundle Resources手动加上所用的bundle文件，如下图

  ![copy_bundle](https://coding.net/u/yeahyf/p/SDKGuide_iOS/git/raw/master/doc/doc_pic/copy_bundle.png)


### 六、在Build Settings中设置
* Enable Modules为Yes
 
  ![enable_modules](https://coding.net/u/yeahyf/p/SDKGuide_iOS/git/raw/master/doc/doc_pic/enable_modules.png)

* Other Linker Flags为-ObjC和-lxml2
 
  ![other_linker](https://coding.net/u/yeahyf/p/SDKGuide_iOS/git/raw/master/doc/doc_pic/other_linker.png)












