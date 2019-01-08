source 'https://github.com/CocoaPods/Specs.git'

platform:ios,'10.0'
use_frameworks!
inhibit_all_warnings!

target 'Statistics' do

  pod 'NSObject+Rx'
  pod 'Aspects'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxSwift'
  pod 'RxViewController'
  pod 'SwifterSwift'

end


post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        if config.name == 'Release'
            config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
        end
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
