package main

import (
    "fmt"
    "net/http"
    "os"
    "time"
)

func main() {
  http.ListenAndServe(":8000", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
    ctx := r.Context()
    fmt.Fprint(os.Stdout, "Processing request\n")
    select {
    case <-time.After(2 * time.Second):
      w.Write([]byte("Request processed"))
    case <-ctx.Done():
      fmt.Fprint(os.Stderr, "Request cancelled\n")
    }
  }))
}
