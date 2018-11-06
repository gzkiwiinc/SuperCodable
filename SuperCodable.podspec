Pod::Spec.new do |s|
  
  s.name         = 'SuperCodable'
  s.version      = '0.8.3'
  s.summary      = 'give Codable super power'

  s.description  = 'give Codable super power.'
  
  s.homepage     = 'https://github.com/gzkiwiinc/SuperCodable'
  s.license      = { :type => 'MIT' }
  s.author       = { 'lacklock' => 'lacklock@gmail.com' }  
  s.swift_version = '4.2'

  s.source       = { :git => 'https://github.com/gzkiwiinc/SuperCodable.git', :tag => "#{s.version}" }
  s.source_files = 'SuperCodable/*.swift'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.default_subspec  = 'Codable'

  s.subspec 'Codable' do |sp|
    sp.source_files = 'SuperCodable/*.swift'
    s.ios.deployment_target = '8.0'
  end

  s.subspec 'Rx' do |sp|
    sp.source_files = 'SuperCodable/Rx/*.swift'
    sp.dependency 'RxSwift', '~> 4.0'
  end

  s.subspec 'RealmCache' do |sp|
    sp.source_files = 'SuperCodable/Realm/*.swift'
    sp.dependency 'RealmSwift'
    sp.dependency 'SuperCodable/Codable'
  end

end
