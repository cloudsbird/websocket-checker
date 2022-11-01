# Websocket Monitoring for Kuma

What you need:
1. Kuma PUSH URL 
2. WS URL

Notes:
1. Make sure you have the latest version of Kuma installed
2. Make sure your Websocket is up and running at the first run

# Instalation

```bash
docker run -d -e KUMA_PUSH_URL=<KUMA_PUSH_URL> -e WS_URL=<WS_URL> cloudsbird/websocket-checker:latest
```
