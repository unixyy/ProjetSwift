protocol MarbleIteratorProtocol : IteratorProtocol {
    var Plateau : Board

    init(Plateau : Board)

    mutating func next() -> Marble


}