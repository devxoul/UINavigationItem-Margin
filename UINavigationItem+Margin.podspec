Pod::Spec.new do |s|
  s.name             = 'UINavigationItem+Margin'
  s.version          = '2.0.2'
  s.summary          = 'Margin for UINavigationItem.'
  s.homepage         = 'https://github.com/devxoul/UINavigationItem-Margin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Suyeol Jeon' => 'devxoul@gmail.com' }
  s.source           = { :git => 'https://github.com/devxoul/UINavigationItem-Margin.git', :tag => s.version.to_s }
  s.source_files     = 'UINavigationItem+Margin/*.{h,m}'
  s.frameworks       = 'UIKit'
  s.requires_arc     = true

  s.ios.deployment_target = '7.0'
end
