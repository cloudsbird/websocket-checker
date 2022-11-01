require 'websocket-client-simple'
require 'httparty'

ws = WebSocket::Client::Simple.connect 'wss://www.jomcharge.com/cable'
kuma_status = "https://status.jomcharge.com/api/push/msOGaBNUBS"

ws.on :open do
  HTTParty.get kuma_status, params: { status: "up", msg: "OK" }
end

ws.on :close do |e|
  p e
  HTTParty.get kuma_status, params: { status: "down", msg: e }
end

ws.on :error do |e|
  p e
  HTTParty.get kuma_status, params: { status: "down", msg: e }
end

loop do 
  sleep 1
  HTTParty.get kuma_status, params: { status: "up", msg: "OK" } if ws.open?
end