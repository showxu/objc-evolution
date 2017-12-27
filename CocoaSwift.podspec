Pod::Spec.new do |s|
  s.name         = 'CocoaSwift'
  s.version      = '0.1.0'
  s.license      = 'MIT'
  s.summary      = 'A swifty extension for Cocoa Framework.'
  s.homepage     = 'https://github.com/0xxd0/CocoaSwift'
  s.authors      = { '0xxd0' => '10173746+0xxd0@users.noreply.github.com' }
  s.source       = { :git => 'https://github.com/0xxd0/Cocoa.Swift.git', :tag => "#{s.version}" }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'CocoaSwift/Swift/Source/*.{h,c,hpp,cpp,m,mm,swift}'
  s.prefix_header_file = 'CocoaSwift/Swift/Public Headers/swift.h'
  s.pod_target_xcconfig = {
    'GCC_PREFIX_HEADER' => 'CocoaSwift/Swift/Public Headers/swift.h',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17'
  }
end
