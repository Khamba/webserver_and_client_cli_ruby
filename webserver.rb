require 'socket'               # Get sockets from stdlib
require 'json'

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  request = client.gets
  request = request.chomp

  if request =~ /GET/
	file = request.split[1]

	f = File.new(file ,"r")

	if f
		response = "#{request.split[2]} 200 OK\r\n\r\n"
		response << "Content-length: #{File.size(f)}\r\n\r\n"
		response << f.read

	else
		response = "#{request.split[2]} 404 File not found\r\n\r\n"
	end
	client.puts response
  elsif request =~ /POST/
	data = client.gets
	data = data.chomp
	puts request

	name = data.match(/(?<=name\=)(.*)(?=\&)/) || data.match(/(?<=name\=)(.*)/)
	email = data.match(/(?<=email\=)(.*)(?=\&)/) || data.match(/(?<=email\=)(.*)/)

	data_hash = {:viking => {:name => name, :email => email} }
	puts "Viking name = #{data_hash[:viking][:name]}"
	puts "Viking email = #{data_hash[:viking][:email]}"

	client.puts "POST request received and processed."

  else
	client.puts "not a GET request"
  end

  client.puts "\n\n"
  client.puts(Time.now.ctime)  # Send the time to the client
  client.puts "Closing the connection. Bye!\n"
  client.close                 # Disconnect from the client
}