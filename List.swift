// Linked List implementation
class List<T> : CustomStringConvertible {
  var value: T
  var next: List<T>?

  init(item: T) {
    self.value = item
  }

  init!(items: Array<T>) {
    guard let first = items.first else { return nil }
    self.value = first

    var prev:List<T> = self
    for item in items[1..<items.count] {
      prev.next = List(item: item)
      prev = prev.next!
    }
  }

  func toArray() -> [T] {
    var arr = [T]()
    var current:List<T>? = self
    while let c = current {
      arr.append(c.value)
      current = c.next
    }
    return arr
  }

  var description: String {
    return String(self.toArray())
  }
}
