extension ClosedRange where Bound: SignedNumeric {
  var length: Bound {
    return abs(upperBound - lowerBound)
  }
  
  func distance(for value: Bound) -> Bound {
    value - self.lowerBound
  }
}
