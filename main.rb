require 'daemons'

Daemons.run('arcontrol.rb', :log_output => true)
