Pod::Spec.new do |s|
  s.name         = "AdjustPurchase"
  s.version      = "3116"
  s.summary      = "Ad aggregation sdk"
  s.description  = "Ad aggregation sdk contains ad sdk and statistics sdk.ad sdk contain:admob,facebook,vungle,unity,appnext and many more.statistics sdk contain:adjust,UM"
  s.homepage     = "https://github.com/liuyaqiang/FineSDK.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "qiang" => "344257448@qq.com" }
  s.source       = { :git => "https://github.com/liuyaqiang/FineSDK.git", :tag =>s.version }
  s.platform = :ios,'8.0'
 # s.vendored_frameworks = 'AdjustPurchase/AdjustPurchaseSDK.framework'
  s.source_files = 'AdjustPurchase/AdjustPurchaseSDK.framework/Headers/*.{h}' 
  s.public_header_files = 'AdjustPurchase/AdjustPurchaseSDK.framework/Headers/**/*.{h}'
end
