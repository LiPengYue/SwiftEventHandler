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
  

  s.ios.deployment_target = '9.1'

  s.source_files = 'SwiftEventHandler/Classes/**/*'
  
  
end
