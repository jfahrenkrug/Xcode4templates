Xcode 4 Templates
=================

This is a tool to extract Xcode 4 application templates and convert them to be used with Xcode 5 to get options like "Use Storyboards" back.

You need to download a copy of Xcode **4**(!) from http://developer.apple.com/ios in order to run this tool. 
It will extract and convert the application templates contained in Xcode 4's .app bundle and copy them to your
`~/Library/Developer/Xcode/Templates/` folder and place them inside a new `Xcode 4` subfolder.

Usage
=====
1. Open `Terminal.app`
2. Change to the directory where you put `xcode4templates.rb`, for example `cd ~/Downloads`.
3. Run `ruby xcode4templates.rb` and follow the instructions.

Enjoy the new found freedom to opt-out of storyboards again!

