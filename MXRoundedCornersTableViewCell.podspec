Pod::Spec.new do |s|
  s.name                  = "MXRoundedCornersTableViewCell"
  s.version               = "0.1"
  s.summary               = "The easiest way to make rounded corners table view cells"
  s.homepage              = "https://github.com/maxsokolov/CocoaKit"
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { "Username" => "Max Sokolov" }
  s.platform              = :ios, '7.0'
  s.source                = { :git => "https://github.com/maxsokolov/MXRoundedCornersTableViewCell.git", :tag => s.version.to_s }
  s.source_files          = 'MXRoundedCornersTableViewCell/*.{h,m}'
  s.requires_arc          = true
end