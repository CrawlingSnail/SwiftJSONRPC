Pod::Spec.new do |s|
  s.name             = "SwiftJSONRPC"
  s.version          = "0.2.2"
  s.summary          = "Swift JSON-RPC client based on Alamofire"
  s.homepage         = "https://github.com/kolyasev/SwiftJSONRPC"
  s.license          = 'MIT'
  s.author           = { "Denis Kolyasev" => "kolyasev@gmail.com" }
  s.source           = { :git => "https://github.com/kolyasev/SwiftJSONRPC.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*.swift', 'Libraries/**/*.swift'

  s.frameworks = 'Foundation'
  s.dependency 'Alamofire', '~> 4.4'
  s.dependency 'SwiftyJSON', '~> 3.1'

  # TODO: Convert to Swift 3.x
  # s.dependency 'Atomic', '~> 1.0'
end
