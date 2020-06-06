Pod::Spec.new do |s|
  s.name = "ZYBaseUtils"
  s.version = "0.1.1"
  s.summary = "\u{81ea}\u{5df1}\u{5c01}\u{88c5}\u{7684}\u{57fa}\u{7840}\u{7c7b}\u{5e93}\u{8c03}\u{7528}"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"xufengbj"=>"xfncwu@163.com"}
  s.homepage = "https://github.com/xufengbj/ZYBaseUtils"
  s.description = "\u{81ea}\u{5df1}\u{5c01}\u{88c5}\u{7684}\u{57fa}\u{7840}\u{7c7b}\u{5e93}\u{8c03}\u{7528}\u{ff0c}\u{57fa}\u{7840}\u{7c7b}\u{65b9}\u{6cd5}"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/ZYBaseUtils.framework'
end
