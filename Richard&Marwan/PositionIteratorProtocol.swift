protocol PositionIteratorProtocol : IteratorProtocol {
    // board de la partie
    var Plateau : Board

    // Initalise l'itérateur à partir du board
    init(Plateau : Board)

    // On renvoie la position actuelle et on passe à la suivante
    mutating func next() -> Position?


}