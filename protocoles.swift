
protocol BoardProtocol {

    associatedtype Position : Numeric
    // init -> Board
    // Création du Board, avec les billes placées aléatoirement sur le board
    // 
    init()

    // init : String -> Board
    // Création du Board, avec les billes placées aléatoirement sur le board
    // le mode est choisi (simple / multiplicateur)
    // Pre : mode est un Boolean, true ou false
    init?(mode : Bool)
    
    // placement aléatoire sur le board des billes
    mutating func RandomMarbles()


}


protocol UserProtocol {

    mutated func MoveMarble()
    
}


