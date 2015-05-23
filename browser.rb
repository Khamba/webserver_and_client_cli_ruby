require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000                           # Default HTTP port
path = "index.html"                 # The file we want 

# This is the HTTP request we send to fetch a file
request = "POST HTTP/1.0\r\n\r\n"

socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
socket.print("name=Saurabh&email=saurabh@sikchi.com")
response = socket.read              # Read complete response
print response
# Split response at first blank line into headers and body
#headers,body = response.split("\r\n\r\n", 2) 
#print body                          # And display it