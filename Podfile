# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git' # 使用清华大学的镜像源

platform :ios, '13.0'
install! 'cocoapods', :disable_input_output_paths => true
inhibit_all_warnings!
use_modular_headers!

target 'iOS_OpenEye' do

  # Pods for iOS_OpenEye
  pod 'Kingfisher',             '6.3.1'   #图片加载
  pod 'URLNavigator',           '2.5.1'   #路由跳转
  pod 'MJRefresh',              '3.7.9'   #下拉刷新
  pod 'FSPagerView',           :git => 'https://github.com/WinWang/FSPagerView.git', :branch => 'master' #Banner组件  pod导入修改最低兼容版本12
  pod 'BMPlayer',               :git => 'https://github.com/BrikerMan/BMPlayer.git'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.0'
        end
    end
end
