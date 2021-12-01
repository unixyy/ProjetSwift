// Liste des fonctionnalités de User : 
/*
    - Déplacer les marbles
    - Avoir les infos concernant les marbles (position, couleur, direction initiale)
    - Connaître le score actuel du joueur
    - Savoir quelle marbles sont actuellement déplaçable ou non
    - Savoir de combien de cases au maximum une certaine marble en particulier est déplaçable
    - Savoir combien de coups de retard possède le joueur
    - Le joueur peux demander de jouer un de ses coups en retard
    -  



*/

protocol UserProtocol {

    associatedtype Bille : Marble

    // init : Int -> User
    // Créée un joueur
    // Pre : Le numéro du joueur est soit 1, soit 2 ( le joueur 1 joue en premier )
    // Post : Initialisation du joueur, dont le numéro est celui donné en paramètre
    init(player : Int) 


    // MoveMarble : Bille x Int ->
    // Déplace la marble selon sa direction initiale donnée en param du nombre de cases donnés en paramètres si c'est possible
    // Pre : 1 <= value <= 7 - Nombre de marbles déjà sur la ligne
    // Post : déplace la marble selon la valeur donnés, si la marble ne peut pas bouger, ne la déplace pas et passe son tour
    mutating func MoveMarble(marble : Bille, value: Int)

    // getMarble : User x Int -> (Marble|Vide)
    // donne les informations associées à la Marble choisie
    // informations dans la bille : Position, Couleur, direction initiale
    // Pre : num est un Int correspondant au numéro de la marble voulue
    // Post : la Marble si le numéro est valide, sinon Vide
    func getMarble(num : Int) -> Bille?

    // Marble Color : User x Bille -> Bool
    // Donne la couleur du Marble choisit
    // Pre : marble existe
    // Post : renvoi la couleur du Marble sous forme de Boolean
    func MarbleColor(marble : Bille) -> Bool?

    // MarblePack : User x Bille-> Int
    // donne le nombre de Billes dans le pack de cellule donnée en paramètre
    // Post : renvoi la valeur du pack dans lequel est la marble
    func MarblePack(marble : Bille) -> Int


    // Score : User x Int -> Int
    // Détermine le score du joueur
    // Pre : Mode est soit : 0 pour le mode simple
    //                soit : 1 pour le mode multiplicatif
    // Post : renvoie un Int,  Score du Joueur selon le mode de jeu choisit
    func Score(mode : Int) -> Int


    // movable : Bille -> Bool
    // Donne de combien de cases la bille peux être déplacée au maximum selon la direction donnée
    // Pre : la bille doit exister 
    // Post : renvoie true si la bille est déplaçable
    // 
    func isMovable(marble : Bille) -> Bool


    // cellsMovable : Bille -> Int
    // Donne le nombre de cases au maximum où on peux bouger la bille donnée en paramètre
    // Pre : la bille doit exister
    // Post : renvoie un int , le nombre de cases max où on peux bouger 
    // renvoie 0 si la bille ne peux pas bouger
    // cellsMovable(M) != 0 <=> isMovable 
    func cellsMovable(marble : Bille) -> Int 
}