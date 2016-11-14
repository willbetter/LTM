#
#  Be sure to run `pod spec lint UKLFNetworking.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.name     = 'UKLFNetworking'
    s.version  = '1.0.2'
    s.license  = 'MIT'
    s.summary  = 'A delightful iOS utility class'
    s.homepage = 'https://github.com/wangxiaoxiang/LTM'
    s.authors  = { 'wangxiaoxiang' => 'wangxiaoxiang@youku.com' }
    s.source   = { :git => 'https://github.com/wangxiaoxiang/LTM.git', :tag => s.version, :submodules => true }
    s.requires_arc = true
    s.ios.deployment_target = '7.0'

    s.preserve_paths = 'releases/iOS/LTM.framework'
    s.vendored_frameworks = 'LTM.framework'
    s.frameworks = "SystemConfiguration", "Security"
    s.libraries = "sqlite3"
end
