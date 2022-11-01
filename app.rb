require 'websocket-client-simple'
require 'httparty'
require 'dotenv/load'

ws = WebSocket::Client::Simple.connect( ENV['WS_URL'] )
kuma_status_url = ENV['KUMA_PUSH_URL']

ws.on :open do
  puts "Connected to #{ENV['WS_URL']}"
end

ws.on :message do |msg|
  puts "Received: #{msg.data}"
  HTTParty.get kuma_status_url, params: { status: "up", msg: "OK" }
end

# when the connection is closed reconnect 

ws.on :close do |e|
  puts e
  loop do 
    sleep 1
    puts "Reconnecting..."
    begin
      ws.connect ENV['WS_URL']
    rescue => e
      puts e
      sleep 10
    end
    break if ws.open?
  end
end

loop do
  ws.send "ping"
  if ENV["PING"] == "false"
    HTTParty.get kuma_status_url, params: { status: "up", msg: "OK" }
  end
  sleep 1
end