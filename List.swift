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

  private func flatWalk(f: (node: Node<T>) -> Void) {
    var current = head
    while let node = current {
      switch node.value {
      case let rlist as LinkedList:
        rlist.flatWalk(f)
      default:
        f(node: node)
      }
      current = node.next
    }
  }

  func flatten() -> LinkedList<T> {
    let res = LinkedList<T>()
    var current:Node<T>? = nil
    flatWalk() {
      if let node = current {
        node.next = $0
        current = node.next
      } else {
        current = $0
        res.head = current
      }
    }
    return res
  }

  // A non-recursive method of flatten
  func flatten2() -> LinkedList<T> {
    let res = LinkedList<T>()
    // create a stack and add current head to it
    var stack:[Node<T>?] = [head]
    // last keeps track of the last element in the result list
    var last:Node<T>? = nil

    stackLoop: while !stack.isEmpty {
      // work last added node
      while let node = stack.last! {
        // move node inside the stack
        stack[stack.endIndex - 1] = node.next
        if let list = node.value as? LinkedList {
          // the node is another list, add it to the stack and
          // break so we start working on it immediately
          stack.append(list.head)
          continue stackLoop
        }
        // if it's not a list, append it to our result list
        if last == nil {
          // first element fix
          res.head = node
          last = res.head
        } else {
          last!.next = node
          last = last!.next
        }
      }
      // top of the stack is now nil so remove it
      // in other words, we have reached the end on the
      // list we are currently working on
      stack.removeLast()
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

  // Eliminate consecutive duplicates
  func compress() {
    var current = head
    while let node = current {
      // consume all consecutive duplicates
      var dup = node
      while let next = dup.next {
        if next.value != node.value {
          break
        }
        dup = next
      }
      node.next = dup.next
      current = node.next
    }
  }

  // Pack consecutive duplicates into sub lists
  func pack() -> LinkedList<LinkedList<T>> {
    let res = LinkedList<LinkedList<T>>()
    var resCurrent = res.head
    var current = head
    while let node = current {
      // Initialize sub list
      let sub = LinkedList<T>()
      sub.head = node

      // Consume all consecutive duplicates
      var subCurrent = sub.head
      while let subnext = subCurrent!.next {
        if subnext.value != sub.head!.value {
          break
        }
        subCurrent = subnext
      }

      // Add sublist to list
      if let last = resCurrent {
        last.next = Node(sub)
        resCurrent = last.next
      } else {
        res.head = Node(sub)
        resCurrent = res.head
      }

      current = subCurrent!.next
      subCurrent!.next = nil
    }
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
