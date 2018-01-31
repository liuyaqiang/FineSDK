Pod::Spec.new do |s|
  s.name         = "ZZAdSDK"
  s.version      = "106"
  s.summary      = "Ad aggregation sdk"
  s.description  = "Ad aggregation sdk contains ad sdk and statistics sdk.ad sdk contain:admob,facebook,vungle,unity,appnext and many more.statistics sdk contain:adjust,UM"
  s.homepage     = "https://github.com/liuyaqiang/FineSDK.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "liuyaqiang" => "344257448@qq.com" }
    s.source       = { :git => "https://github.com/liuyaqiang/FineSDK.git", :tag =>s.version }
  s.resource     = 'BatMobi/zzAdImage.bundle'
  s.platform = :ios,'8.0'
 s.vendored_frameworks = 'BatMobi/ZZAdSD.framework'
 s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  #s.source_files = 'BatMobi/ZZAdSDK.framework/Headers/*.{h}' 
  #s.public_header_files = 'BatMobi/ZZAdSDK.framework/Headers/**/*.{h}'
  s.frameworks = 'UIKit', 'AVFoundation', 'Foundation', 'CoreMedia', 'CoreLocation',   'CoreTelephony', 'SystemConfiguration', 'StoreKit', 'MediaPlayer', 'CFNetwork',  'AdSupport', 'ImageIO'
 s.libraries = 'z', 'stdc++', 'sqlite3'

 end
