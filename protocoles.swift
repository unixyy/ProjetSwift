
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

    // Pre : si c'est le premier tour, le joueur qui commence est aléatoire
    func TurnOf() -> Bool


}


protocol UserProtocol {
    // Déplace la bille selon la position x
    // Pre : 1 <= x <= 7 - Nombre de billes déjà sur la ligne
    mutating func MoveMarble(x: Int) throws

    mutating func MoveMarble(y: Int) throws
    
}


