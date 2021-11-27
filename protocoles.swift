
protocol BoardProtocol {

    associatedtype Position : Numeric
    // init -> Board
    // Création du Board, avec les marbles placées aléatoirement sur le board
    init()

    // init : String -> Board
    // Création du Board, avec les marbles placées aléatoirement sur le board
    // le mode est choisi (simple / multiplicateur)
    // Pre : mode est un Boolean, true ou false
    //      sinon, la création du board échoue
    init?(mode : Bool)
    
    // RandomMarbles : Board -> Marble
    // placement aléatoire sur le board des marbles
    // Pre : Le Board existe
    // Post : affecte des positions aléatoires chancunes différentes
    //      sans que la même couleur n'apparaisse plus de 2 fois de suite
    mutating func RandomMarbles()

    // TurnOf : Board -> Bool
    // Donne Le joueur joueur qui doit jouer au tour actuel
    // Pre : si c'est le premier tour, le joueur qui commence est aléatoire
    // Post : Joueur qui doit jouer sous forme de Boolean
    func TurnOf() -> Bool


}

protocol UserProtocol {
    // MoveMarble : (String,String) -> User
    // Déplace la marble selon la position x
    // Pre : 1 <= value <= 7 - Nombre de marbles déjà sur la ligne
    // Pre : 0 <= direction <= 3
    // Post : déplace la marble selon la valeur donnés, si la marble ne peut pas bouger, ne la déplace pas et passe son tour
    mutating func MoveMarble(value: Int, direction: Int)

    // getMarble : User x Int -> (Marble|Vide)
    // donne les informations associées à la Marble choisie
    // Pre : num est un Int correspondant au numéro de la marble voulue
    // Post : la Marble si le numéro est valide, sinon Vide
    func getMarble(num : Int) -> Marble?

    // Marble Color : User x Marble -> Bool
    // Donne la couleur du Marble choisit
    // Pre : marble existe
    // Post : renvoi la couleur du Marble sous forme de Boolean
    func MarbleColor(marble : Marble) -> Bool?

    // MarblePack : User -> Array<Int>
    // donne une liste du nombre de Marble par Pack différents
    // Post : liste de nombre de marbles par pack
    func MarblePack() -> Array<Int>


    // Score : Bool x User x Marble -> Int
    // fonction qui détermine le score du joueur
    // Pre : Mode est un Boolean
    // Post : Score du Joueur selon le mode de jeu choisit
    func Score(mode : Bool) -> Int
    

}


