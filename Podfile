# for history reason, the Podfile for test target

inhibit_all_warnings!
use_frameworks!

workspace 'CocoaSwift'

#abstract_target 'Embedded CocoaSwift' do
#  # pod 'CocoaSwift' path
#  spec_path = File.expand_path('./', __dir__)
#  pod 'CocoaSwift', :path => spec_path
#  
# 
#end

pre_install do |installer|
  # Do something fancy!
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # config.build_settings['GCC_ENABLE_OBJC_GC'] = 'supported'
      config.build_settings['ENABLE_BITCODE'] = 'YES'
      config.build_settings['LD_GENERATE_MAP_FILE'] = 'YES'
    end
  end
end

