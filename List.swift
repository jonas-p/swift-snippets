// Linked List implementation

private class Node<T> {
  var value: T
  var next: Node?

  init(_ item: T) {
    self.value = item
  }
}

class LinkedList<T> {
  private var head: Node<T>?

  var isEmpty: Bool {
    return head == nil
  }

  convenience init(_ items: T...) {
    self.init(fromArray: Array(items))
  }

  init(fromArray items: [T]) {
    if items.count > 0 {
      head = Node(items.first!)

      var current = head!
      for item in items[1..<items.count] {
        current.next = Node(item)
        current = current.next!
      }
    }
  }

  func reverse() {
    var prev:Node<T>? = nil
    while let current = head {
      head = current.next
      current.next = prev
      prev = current
    }
    head = prev
  }
}

extension LinkedList: CustomStringConvertible {
  var description: String {
    var str = ""
    var current = head
    while let node = current {
      str += "\(node.value)"
      current = node.next
      if current != nil { str += ", " }
    }
    return "[" + str + "]"
  }
}
