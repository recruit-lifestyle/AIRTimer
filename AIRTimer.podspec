Pod::Spec.new do |s|
  s.name = 'AIRTimer'
  s.version = '1.0.0'
  s.summary = 'Restartable NSTimer in Swift.'
  s.homepage = 'https://github.com/recruit-lifestyle/AIRTimer'
  s.platform = :ios, '8.0'
  s.author = { 'Yuki Nagai' => 'ynagai@r.recruit.co.jp' }
  s.license = 'Apache License, Version 2.0'
  s.source = { :git => 'https://github.com/recruit-lifestyle/AIRTimer.git', :tag => s.version }
  s.source_files = 'AIRTimer/*.swift'
  s.requires_arc = true
end
