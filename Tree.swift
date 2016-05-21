// Binary search tree implementation from
// https://github.com/raywenderlich/swift-algorithm-club
public enum Tree<T: Comparable> {
  case Empty
  case Leaf(T)
  indirect case Node(Tree, T, Tree)

  public var count: Int {
    switch self {
    case .Empty: return 0
    case .Leaf: return 1
    case let .Node(left, _, right): return 1 + left.count + right.count
    }
  }

  public var height: Int {
    switch self {
    case .Empty: return 0
    case .Leaf: return 1
    case let .Node(left, _, right): return 1 + max(left.height, right.height)
    }
  }

  public func insert(newItem: T) -> Tree {
    switch self {
    case .Empty:
      return .Leaf(newItem)
    case .Leaf(let item):
      if newItem < item {
        return .Node(.Leaf(newItem), item, .Empty)
      } else {
        return .Node(.Empty, item, .Leaf(newItem))
      }
    case let .Node(left, item, right):
      if newItem < item {
        return .Node(left.insert(newItem), item, right)
      } else {
        return .Node(left, item, right.insert(newItem))
      }
    }
  }

  public func search(item: T) -> Tree? {
    switch self {
    case .Empty: return nil
    case let .Leaf(treeItem) where item == treeItem: return self
    case let .Node(left, treeItem, right):
      if item < treeItem {
        return left.search(item)
      } else if treeItem < item {
        return right.search(item)
      } else {
        return self
      }
    default: return nil
    }
  }
}
