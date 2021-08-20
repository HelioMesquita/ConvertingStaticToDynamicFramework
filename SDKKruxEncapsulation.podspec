Pod::Spec.new do |s|
  s.name             = 'SDKKruxEncapsulation'
  s.version          = '4.5.1'
  s.summary          = 'iOSKruxLibUniversal encapsulation.'
  s.description      = 'iOSKruxLibUniversal encapsulation'
  s.homepage         = 'https://github.com/HelioMesquita/StaticToDynamicFramework'
  s.author           = { 'Helio Mesquita' => 'helio.mesquitaios@gmail.com' }
  s.source           = { :git => 'https://github.com/HelioMesquita/StaticToDynamicFramework.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig     = { 'ONLY_ACTIVE_ARCH' => 'YES' }
  s.vendored_framework = 'SDKKruxEncapsulation.framework'
  s.frameworks = 'AdSupport', 'Foundation', 'SystemConfiguration', 'AppTrackingTransparency', 'UIKit'
end
