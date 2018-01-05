//
//  YFCommonHeader.h
//  yifanDemo
//
//  Created by liuyaqiang on 2017/4/19.
//  Copyright © 2017年 yifan. All rights reserved.
//

#ifndef YFCommonHeader_h
#define YFCommonHeader_h

//#define YF_AppKey @"a6ivlpeyyxvcjamkkdtbwf0z"
//#define YF_AppKey @"a6ivlpeytjduawrkyya4vxh9"
//#define YF_AppKey  @"a6ivlpey0w8znoplqsub6stw"
//#define YF_AppKey  @"a6ivlpey60kwj8bvaunkgytk"
//#define YF_AppKey  @"a6ivlpeygsmhggnuqzqanb0b"
//#define YF_AppKey @"a6ivlpeys26olnaptupw4yes"
//#define YF_AppKey @"a6ivlpeyli8rs6f0ebxzxw43"
#define YF_AppKey @"a6ivlpeyxomqeo3qzkdnpr2z"
//#define YF_AppKey @"a6ivlpeyev628qx5lzttko3g"
//#define YF_AppKey @"a6ivlpeys26olnaptupw4yes"
//#define YF_AppKey @"bcyqlc66cfkhuwkwikdb2e2q"
//#define YF_AppKey @"bjlu5rqdcov5aarvsz22itpo"

#define AppKey [[NSUserDefaults standardUserDefaults]stringForKey:@"default_appkey"].length ?[[NSUserDefaults standardUserDefaults]stringForKey:@"default_appkey"]  : YF_AppKey

#define YF_PAGE @"main"

#define PAGE [[NSUserDefaults standardUserDefaults]stringForKey:@"default_page"].length ?[[NSUserDefaults standardUserDefaults]stringForKey:@"default_page"]  : YF_PAGE

#define YF_LEVEL @"0"

#define LEVEL [[NSUserDefaults standardUserDefaults]stringForKey:@"default_level"].length ?[[NSUserDefaults standardUserDefaults]stringForKey:@"default_level"]  : YF_LEVEL

#define VIEW_LOACTION ([[NSUserDefaults standardUserDefaults]valueForKey:NS_DEFAULT_VIEW_LOCATION] ? [[[NSUserDefaults standardUserDefaults]valueForKey:NS_DEFAULT_VIEW_LOCATION]  intValue]: 1)

#define DEVICE_ORIENTATION ([[NSUserDefaults standardUserDefaults]stringForKey:NS_DEFAULT_DEVICE_ORIENTATION] ?  [[[NSUserDefaults standardUserDefaults] stringForKey:NS_DEFAULT_DEVICE_ORIENTATION] intValue]: 0)

#define NS_DEFAULT_VUNGLE_MODE  @"default_vungleMode"
#define NS_DEFAULT_LOG  @"config_log_debug"
#define NS_DEFAULT_APPKEY @"default_appkey"
#define NS_DEFAULT_PAGE @"default_page"
#define NS_DEFAULT_LEVEL @"default_level"
#define NS_DEFAULT_VIEW_LOCATION  @"default_view_loaction"
#define NS_DEFAULT_DEVICE_ORIENTATION  @"default_device_orientataion"

#endif /* YFCommonHeader_h */
