Pod::Spec.new do |s|
  s.name         = "FineSDK"
  s.version      = "3115"
  s.summary      = "Ad aggregation sdk"
  s.description  = "Ad aggregation sdk contains ad sdk and statistics sdk.ad sdk contain:admob,facebook,vungle,unity,appnext and many more.statistics sdk contain:adjust,UM"
  s.homepage     = "https://github.com/liuyaqiang/FineSDK.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "qiang" => "344257448@qq.com" }
  s.source       = { :git => "https://github.com/liuyaqiang/FineSDK.git", :tag =>s.version }
  s.resource     = 'FineSDK/PluginSDKResources.bundle'
  s.platform = :ios,'8.0'
 s.vendored_frameworks = 'FineSDK/FineSDK.framework'
  s.source_files = 'FineSDK/FineSDK.framework/Headers/*.{h}' 
  s.public_header_files = 'FineSDK/FineSDK.framework/Headers/**/*.{h}'
  s.frameworks   = 'UIKit','Foundation'
end
