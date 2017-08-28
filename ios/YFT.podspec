Pod::Spec.new do |s|

  s.name         = "YFT"
  s.version      = "0.0.2"
  s.summary      = "create Image and Label from Character-Bitmap."
  s.description  = <<-DESC
                   create Image and Label from Character-Bitmap.
                   on mac, use res/RunScript generate yft files.
                   DESC
  s.homepage     = "https://github.com/yyued/YFT"
  s.license      = "MIT"
  s.author             = { "PonyCui" => "cuis@vip.qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/yyued/YFT.git" }
  s.source_files  = "ios/Source", "ios/Source/*.{h,m}"
  s.requires_arc = true

end
