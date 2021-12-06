protocol MarbleIteratorProtocol : IteratorProtocol {
    // board de la partie
    var Plateau : Board

    // Initalise l'itérateur à partir du board
    init(Plateau : Board)

    // On renvoie la bille actuelle et on passe à la suivante
    mutating func next() -> Marble?


}