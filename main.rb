require 'daemons'

dir = File.dirname(File.expand_path(__FILE__))
Dir.chdir(dir)
sleep(10)
Daemons.run('arcontrol.rb', :log_output => true)
