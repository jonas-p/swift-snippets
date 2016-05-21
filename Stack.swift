// Stack implementation from
// https://github.com/raywenderlich/swift-algorithm-club
public struct Stack<T> {
  private var items = [T]()

  public var isEmpty: Bool {
    return items.isEmpty
  }

  public var count: Int {
    return items.count
  }

  public mutating func push(element: T) {
    items.append(element)
  }

  public mutating func pop() -> T? {
    if isEmpty {
      return nil
    } else {
      return items.removeLast()
    }
  }

  public func peek() -> T? {
    return items.last
  }
}
