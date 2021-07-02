Pod::Spec.new do |s|
  s.name                  = "Await"
  s.version               = "1.1.2"
  s.homepage              = 'https://github.com/tiny2n/Await.git'
  s.summary               = "Asynchronous Programming with async and await base protocol oriented programming"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "dean.w" => "dean.w@kakaocorp.com" }
	s.source                = { :git => "https://github.com/tiny2n/Await.git", :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.source_files          = "Sources/*.swift"
end
