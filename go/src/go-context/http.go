package main

import (
  "context"
  "fmt"
  "net/http"
  "time"
)

func main() {
  ctx := context.Background()
  ctx, _ = context.WithTimeout(ctx, 100 * time.Millisecond)

  req, _ := http.NewRequest(http.MethodGet, "http://google.com", nil)
  req = req.WithContext(ctx)

  client := &http.Client{}
  res, err := client.Do(req)
  if err != nil {
    fmt.Println("Request failed:", err)
    return
  }
  fmt.Println("Request received, status code:", res.StatusCode)
}
