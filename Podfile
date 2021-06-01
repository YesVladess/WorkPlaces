# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Workplaces' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for workplaces
	pod 'SwiftLint'
	pod 'GoogleSignIn'
	pod 'VK-ios-sdk'
	pod 'FBSDKLoginKit'

  target 'WorkplacesTests' do
    inherit! :search_paths
    pod 'Apexy', :git => 'https://github.com/RedMadRobot/apexy-ios.git', :branch => 'master'
  end

  target 'WorkplacesAPI' do
    inherit! :search_paths
    pod 'Apexy', :git => 'https://github.com/RedMadRobot/apexy-ios.git', :branch => 'master'

    target 'WorkplacesAPITests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
   end
  end

end
