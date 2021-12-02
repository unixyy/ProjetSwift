// Liste des fonctionnalités de User : 
/*
    - Déplacer les marbles
    - Avoir les infos concernant les marbles (identifiant, position, couleur, direction initiale)
    - Connaître le score actuel du joueur
    - Savoir quelle marbles sont actuellement déplaçable ou non
    - Savoir de combien de cases au maximum une certaine marble en particulier est déplaçable
    -  




protocol UserProtocol {
    // Correspond au numéro du joueur
    var identifiant : Int { get }

    // init : Int -> User
    // Créée un joueur
    // Pre : Le numéro du joueur est soit 1, soit 2 ( le joueur 1 joue en premier )
    // Post : Initialisation du joueur, dont le numéro est celui donné en paramètre
    init(player : Int) 

    // MoveMarble : Marble x Int ->
    // Déplace la marble selon sa direction initiale donnée en param du nombre de cases donnés en paramètres si c'est possible
    // Pre : 1 <= valeur <= 7 et isMovable(M) et valeur <= cellsMovable(M,valeur)
    // Post : Déplaçe la marble donnée en paramètre du nombre value de cases selon sa direction inhérente
    // fais un appel de MoveMarbleDirection
    mutating func MoveMarble(marble : Marble, value: Int)

    

}
*/