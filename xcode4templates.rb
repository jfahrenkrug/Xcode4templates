# Xcode 4 Templates
# 2013, Johannes Fahrenkrug, http://springenwerk.com
# Licence: MIT.

require 'fileutils'

if ARGV.size < 1
  puts "This tool copies and converts Xcode 4's application templates to Xcode 5."
  puts "You need a copy of the Xcode 4 app (Xcode.app) somewhere on your disk."
  puts "Usage: ruby xcode4templates.rb /path/to/Xcode4.app"
else
	xcode4_templates_path = File.expand_path("#{ARGV[0]}/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates")
	destination_path = File.expand_path("~/Library/Developer/Xcode/Templates/Xcode 4")

	# Create the Templates path in case it doesn't exist
	FileUtils.mkdir_p destination_path

	templates = [{:package => "iOS Reference Counting.xctemplate"},
		{:path => "Application/", :package => "Master-Detail Application.xctemplate", :original_id => "com.apple.dt.unit.masterDetailApplication", :new_id => "com.springenwerk.dt.unit.masterDetailApplication"},
		{:path => "Application/", :package => "OpenGL Game.xctemplate", :original_id => "com.apple.dt.unit.openGLGame", :new_id => "com.springenwerk.dt.unit.openGLGame"},
		{:path => "Application/", :package => "Page-Based Application.xctemplate", :original_id => "com.apple.dt.unit.pageBasedApplication", :new_id => "com.springenwerk.dt.unit.pageBasedApplication"},
		{:path => "Application/", :package => "Single View Application.xctemplate", :original_id => "com.apple.dt.unit.singleViewApplication", :new_id => "com.springenwerk.dt.unit.singleViewApplication"},
		{:path => "Application/", :package => "Storyboard Application.xctemplate"},
		{:path => "Application/", :package => "Tabbed Application.xctemplate", :original_id => "com.apple.dt.unit.tabbedApplication", :new_id => "com.springenwerk.dt.unit.tabbedApplication"},
		{:path => "Application/", :package => "Utility Application.xctemplate", :original_id => "com.apple.dt.unit.utilityApplication", :new_id => "com.springenwerk.dt.unit.utilityApplication"}
	]

	templates.each do |template|
	    puts "Copying #{template[:package]}..."
		FileUtils.cp_r("#{xcode4_templates_path}/#{template[:path]}#{template[:package]}", destination_path)
		file_name = "#{destination_path}/#{template[:package]}/TemplateInfo.plist"
		puts "Fixing #{file_name}..."
		# post-process the template file
		text = File.read(file_name)
		
		# All the occurances of the storyboardApplication ID must be replaced in order for the the Xcode 4 copy to by used.
		replace = text.gsub!("com.apple.dt.unit.storyboardApplication", "com.springenwerk.dt.unit.storyboardApplication")
		
		if	template[:original_id] && template[:new_id]
			replace = text.gsub!(template[:original_id], template[:new_id])
		end
		
		File.open(file_name, "w") { |file| file.puts replace }
	end

	puts "Done."
end
