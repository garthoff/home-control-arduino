require 'serialport'
require 'logger'

class ARControl
    def initialize
	sleep(10)
        @log = Logger.new(STDOUT)
        @log.info 'Opening arduino serial interface'
        @arduino = SerialPort.new '/dev/ttyACM0', 115200
        sleep(2)
        if @arduino
            @log.info 'Arduino interface opened successfully'
        else
            @log.error 'Could not open arduino'
            exit
        end
    end


    def update_time
        time = Time.now
        @log.info "Time broadcast at #{time}"
        time = [time.year, time.month, time.day, time.hour, time.min, time.sec]
        @arduino.write("T#{time.pack('nC*')}")
        data = @arduino.readline
    end

    def update_processor_status
        @arduino.write("A")
        data = @arduino.readline
        open('/tmp/processor.status', 'w') {|f| f << data }
    end
end

c = ARControl.new

counter = 10000

loop {
    counter += 1
    if counter > 3600 # Broadcast signal every hour
        c.update_time
        counter = 0
    end
    c.update_processor_status
    sleep(1)
}


