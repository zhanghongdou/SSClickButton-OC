

Pod::Spec.new do |s|


  s.name         = "SSClickButton"
  s.version      = "0.0.1"
  s.summary      = "set the number of controls when simulating shopping - OC."

  s.description  = <<-DESC 
Encapsulates a small function : set the number of controls when simulating shopping - OC
                   DESC

  s.homepage     = "https://github.com/zhanghongdou/SSClickButton-OC"


  s.license      = "MIT"


  s.author             = { "HONG DOU ZHANG" => "1914144764@qq.com" }

  s.platform     = :ios, "8.0"


  s.source       = { :git => "https://github.com/zhanghongdou/SSClickButton-OC.git", :tag => s.version.to_s }



  s.source_files  = "SSClickButton", "SSClickButton/**/*.{h,m}"


  s.requires_arc = true

end
