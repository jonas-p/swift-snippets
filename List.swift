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

  // Find the last element in the list.
  var last: T? {
    var last = head
    while let node = last?.next {
      last = node
    }
    return last?.value
  }

  // Find the last but one element in the list.
  var pennultimate: T? {
    if head?.next == nil { return nil }

    var pen = head
    while pen?.next?.next != nil {
      pen = pen?.next
    }
    return pen?.value
  }

  // Number of elements contained in the list.
  var length: Int {
    var length = 0
    var current = head
    while let node = current {
      current = node.next
      length += 1
    }
    return length
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

  // Reverses the list
  func reverse() {
    var prev:Node<T>? = nil
    while let current = head {
      head = current.next
      current.next = prev
      prev = current
    }
    head = prev
  }

  // Find the Kth element in the list
  subscript(index: Int) -> T? {
    var i = 0
    var current = head
    while let node = current {
      if i == index {
        return node.value
      }
      current = node.next
      i += 1
    }
    return nil
  }

  func flatten() -> LinkedList<T> {
    func walk(list: LinkedList<T>, _ f: (node: Node<T>) -> Void) {
      var current = list.head
      while let node = current {
        switch node.value {
        case let rlist as LinkedList:
          walk(rlist, f)
        default:
          f(node: node)
        }
        current = node.next
      }
    }

    let res = LinkedList<T>()
    var current:Node<T>? = nil
    walk(self) {
      if let _ = current {
        current!.next = $0
        current = current!.next
      } else {
        current = $0
        res.head = current
      }
    }
    return res
  }

  func map(f: (value: T) -> T) {
    var current = head
    while let node = current {
      node.value = f(value: node.value)
      current = node.next
    }
  }
}

extension LinkedList where T: Equatable {
  // Find whether the list is a palindrome (uses recursion)
  func isPalindrome() -> Bool {
    var head = self.head
    return isPalindromeRecursive(&head, head)
  }

  private func isPalindromeRecursive(inout left: Node<T>?, _ right: Node<T>?) -> Bool {
    guard let right = right else { return true }

    if !isPalindromeRecursive(&left, right.next) {
      return false
    }

    let res = left!.value == right.value
    left = left!.next
    return res
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
