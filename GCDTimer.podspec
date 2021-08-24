Pod::Spec.new do |s|
    s.name         = "GCDTimer"
    s.version      = "0.0.1"
    s.ios.deployment_target = '7.0'
    s.summary      = "GCDTimer"
    s.homepage     = "https://github.com/GengJunjie/GCDTimer.git"
    s.license = { :type => 'MIT', :file => 'MIT-LICENSE.txt' }

    s.author             = "gengjunjie"
    #s.social_media_url   = "http://twitter.com/dingpuyu"
    s.source       = { :git => "https://github.com/GengJunjie/GCDTimer.git", :tag => s.version }
    s.source_files  = "GCDTimer/GJJTimer.{h,m}"
    s.requires_arc = true
end
