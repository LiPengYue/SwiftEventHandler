#
# Be sure to run `pod lib lint SwiftEventHandler.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftEventHandler'
  s.version          = '0.1.0'
  s.summary          = 'swift 多层数据逆传工具'

  s.description      = <<-DESC
swift 多层数据逆传工具
                       DESC

  s.homepage         = 'https://github.com/LiPengYue/SwiftEventHandler'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiPengYue' => 'yiersan@pengyue.li.net' }
  s.source           = { :git => 'https://github.com/LiPengYue/SwiftEventHandler.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftEventHandler/Classes/**/*'
  
  
end
