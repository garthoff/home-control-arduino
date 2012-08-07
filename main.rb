require 'daemons'

dir = File.dirname(File.expand_path(__FILE__))
Dir.chdir(dir)
Daemons.run('arcontrol.rb', :log_output => true, :dir_mode => :system)
