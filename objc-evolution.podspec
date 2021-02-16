Pod::Spec.new do |s|
  fmwk_name = 'ObjcEvolution'
  prefix_header_path = 'Sources/swift.h'
  public_header_path = 'Sources/*.{h,hpp}'
  src_file_path = 'Sources/*.{h,c,hpp,cpp,m,mm,swift}}'
  
  repo_git_host = 'https://github.com/'
  repo_author = 'Xudong Xu'
  repo_author_mail = '10173746+0xxd0@users.noreply.github.com'
  repo_page = repo_git_host + repo_author + '/' + fmwk_name
  repo_git = repo_page + '.git'
  repo_ver = '0.1.0'
  
  s.name         = fmwk_name
  s.version      = repo_ver
  s.license      = 'MIT'
  s.summary      = 'An extension for Foundation to make Objective-C more swift style.'
  s.homepage     = repo_page
  s.authors      = { repo_author => repo_author_mail }
  s.source       = { :git => repo_git, :tag => "#{s.version}" }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  
  s.prefix_header_file = prefix_header_path
  s.public_header_files = public_header_path
  s.source_files = src_file_path
  s.exclude_files = prefix_header_path

  s.pod_target_xcconfig = {
    'GCC_PREFIX_HEADER' => prefix_header_path,
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17'
  }
end
