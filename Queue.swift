// Queue implementation from
// https://github.com/raywenderlich/swift-algorithm-club
public struct Queue<T> {
  private var items = [T?]()
  private var head = 0

  public var isEmpty: Bool {
    return items.isEmpty
  }

  public var count: Int {
    return items.count - head
  }

  public mutating func enqueue(item: T) {
    items.append(item)
  }

  public mutating func dequeue() -> T? {
    guard head < items.count, let item = items[head] else {
      return nil
    }

    // remove head element and increase head count
    items[head] = nil
    head += 1

    // clean up if more than fifty items in the queue
    // and the percentage of free items in the queue
    // is above 25%
    let percentage = Double(head)/Double(items.count)
    if items.count > 50 && percentage > 0.25 {
      items.removeFirst(head)
      head = 0
    }

    return item
  }

  public func peek() -> T? {
    if isEmpty {
      return nil
    } else {
      return items[head]
    }
  }
}
