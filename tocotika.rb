require 'rubygems'
gem 'serialport','>=1.0.4'
require 'serialport'

LOW = 0
HIGH = 1

$s = SerialPort.new('/dev/tty.usbserial-AHXMUX35',115200)

def digitalWrite(pin,value)
  cmd = ':788001'
	if pin == 1 then
		if value == HIGH then
			cmd = cmd + '0101'+'FFFFFFFFFFFFFFFF'
		elsif value == LOW then
			cmd = cmd + '0001'+'FFFFFFFFFFFFFFFF'
    end
	elsif pin == 2 then
		if value == HIGH then
			cmd = cmd + '0202'+'FFFFFFFFFFFFFFFF'
		elsif value == LOW then
			cmd = cmd + '0002'+'FFFFFFFFFFFFFFFF'
    end
	elsif pin == 3 then
		if value == HIGH then
			cmd = cmd + '0404'+'FFFFFFFFFFFFFFFF'
		elsif value == LOW then
			cmd = cmd + '0004'+'FFFFFFFFFFFFFFFF'
    end
	elsif pin == 4 then
		if value == HIGH then
			cmd = cmd + '0808'+'FFFFFFFFFFFFFFFF'
		elsif value == LOW then
			cmd = cmd + '0008'+'FFFFFFFFFFFFFFFF'
    end
  end
	cmd = cmd + 'XX\r\n'
	$s.puts cmd
	return cmd
end

def analogWrite(pin,value)
  cmd = ':7880010000'
	if pin == 1 then
		cmd = cmd + ''+hex4(value)+'FFFFFFFFFFFF'
	elsif pin == 2 then
		cmd = cmd + 'FFFF'+hex4(value)+'FFFFFFFF'
	elsif pin == 3 then
		cmd = cmd + 'FFFFFFFF'+hex4(value)+'FFFF'
	elsif pin == 4 then
		cmd = cmd + 'FFFFFFFFFFFF'+hex4(value)+''
  end
	cmd = cmd + 'XX\r\n'
	$s.puts cmd
end

def hex4(value)
  return sprintf("%04x",value)
end

def wait(t)
  sleep 1
end

if __FILE__ == $0

  while true do
    digitalWrite(1,HIGH)
    wait(1)
    digitalWrite(1,LOW)
    wait(1)
  end
end
