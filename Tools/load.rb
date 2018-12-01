#!/usr/bin/env ruby -wU

###################################################################
# build Enzian, install it, and start it
# installs to /Library/Extensions
# requires admin permissions and will ask for your password
###################################################################

#require 'open3'
require 'fileutils'
require 'pathname'
#require 'rexml/document'
#include REXML

# This finds our current directory, to generate an absolute path for the require
libdir = "."
Dir.chdir libdir        # change to libdir so that requires work

@svn_root = ".."

puts "  Unloading and removing existing Enzian.kext"
if File.exists?("/Library/Extensions/Enzian.kext")
  puts "    first unload (will often fail, but will cause Enzian's performAudioEngineStop to be called)"
  `sudo kextunload /Library/Extensions/Enzian.kext`
  puts "    second unload (this one should work)"
  `sudo kextunload /Library/Extensions/Enzian.kext`
  puts "    removing"
  puts `sudo rm -rf /Library/Extensions/Enzian.kext`
end

puts "  Copying to /Library/Extensions and loading kext"
`sudo cp -rv "#{@svn_root}/Build/InstallerRoot/Library/Extensions/Enzian.kext" /Library/Extensions`
`sudo kextload -tv /Library/Extensions/Enzian.kext`
`sudo touch /Library/Extensions`

puts "  Done."
puts ""
exit 0
