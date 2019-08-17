Pod::Spec.new do |s|
  s.name             = 'SCertificate'
  s.version          = '0.9.0'
  s.summary          = 'A short description of SCertificate.'
  s.description      = 'Certificate Utility'
  s.homepage         = 'https://github.com/khson/SCertificate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'khson' => 'email.khson@gmail.com' }
  s.source           = { :git => 'https://github.com/khson/SCertificate.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'SCertificate/Classes/**/*'
end
