func doSomeRequest(callback: (() -> Void)?) {
  print("Do some request")

  if let callback = callback {
    callback()
  }
}

doSomeRequest(nil)

doSomeRequest({ () -> Void in
  print("Done 1")
})

doSomeRequest({
  print("Done 2")
})

doSomeRequest() {
  print("Done 3")
}

