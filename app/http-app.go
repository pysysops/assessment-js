package main

import (
  "fmt"
  "net/http"
  "os"
  "io"
  "io/ioutil"
  "log"
)

var (
    Trace   *log.Logger
    Info    *log.Logger
    Warning *log.Logger
    Error   *log.Logger
)

func Init(
    traceHandle io.Writer,
    infoHandle io.Writer,
    warningHandle io.Writer,
    errorHandle io.Writer) {

    Trace = log.New(traceHandle,
        "TRACE: ",
        log.Ldate|log.Ltime|log.Lshortfile)

    Info = log.New(infoHandle,
        "INFO: ",
        log.Ldate|log.Ltime|log.Lshortfile)

    Warning = log.New(warningHandle,
        "WARNING: ",
        log.Ldate|log.Ltime|log.Lshortfile)

    Error = log.New(errorHandle,
        "ERROR: ",
        log.Ldate|log.Ltime|log.Lshortfile)
}

func handler(w http.ResponseWriter, r *http.Request) {
  // Create log line from request as will be used a number of times
  rlog := "Proxy: " + r.RemoteAddr + " RealIP: " + r.Header.Get("X-Real-Ip") +
          " Host: " + r.Host + " Method: " + r.Method + " Request: " + r.RequestURI +
          " User-Agent: " + r.Header.Get("User-Agent")

  //Really simple 404 / logging at ERROR level
  if r.URL.Path != "/" {
    http.NotFound(w, r)
    Error.Println(rlog)
    return
  }

  h, _ := os.Hostname()
  fmt.Fprintf(w, "Hi there, I'm served from %s!\n", h)
  Info.Println(rlog)
}

func main() {
  // Logging is good. Sending to stdout / stderr allows both Docker and
  // supervisord to deal with the logs.
  Init(ioutil.Discard, os.Stdout, os.Stdout, os.Stderr)

  // Make port configurable. This may change depending on where / how it is
  // deployed
  port := os.Getenv("PORT")
  if port == "" {
      port = "8484"
  }
  
  Warning.Println("Listening on port:", port)
  http.HandleFunc("/", handler)
  http.ListenAndServe(":" + port , nil)
}
