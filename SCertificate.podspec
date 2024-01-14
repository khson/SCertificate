Pod::Spec.new do |s|
  s.name             = 'SCertificate'
  s.version          = '1.0.3'
  s.summary          = 'A short description of SCertificate.'
  s.description      = 'Certificate Utility'
  s.homepage         = 'https://github.com/khson/SCertificate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KyuHo.Son' => 'khson.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/khson/SCertificate.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.source_files = 'SCertificate/Classes/**/*'
end
