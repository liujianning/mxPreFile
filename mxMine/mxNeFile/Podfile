# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'MXNetwork' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MXNetwork
  pod 'AFNetworking' , '~> 4.0.0'
  pod 'HCDeviceInfo'
  pod 'BasicClass', :path => 'mxBase'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end

end
