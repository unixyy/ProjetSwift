// Liste des fonctionnalités de User : 
/*
    - Déplacer les marbles
    - Avoir les infos concernant les marbles (position, couleur)
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
    func getMarble(num : Int) -> Bille?

    // Marble Color : User x Marble -> Bool
    // Donne la couleur du Marble choisit
    // Pre : marble existe
    // Post : renvoi la couleur du Marble sous forme de Boolean
    func MarbleColor(marble : Bille) -> Bool?

    // MarblePack : User x Bille-> Int
    // donne le nombre de Billes dans le pack de celel donnée en paramètre
    // Post : renvoi la valeur du pack dans lequel est la marble
    func MarblePack(marble : Bille) -> Int


    // Score : Bool x User -> Int
    // fonction qui détermine le score du joueur
    // Pre : Mode est un Boolean
    // Post : Score du Joueur selon le mode de jeu choisit
    func Score(mode : Bool) -> Int


    // movable : Bille x Int -> Int
    // Donne de combien de cases la bille peux être déplacée au maximum selon la direction donnée
    // Pre : les directions sont : Nord 0 , Ouest 1, Sud 2, Est 3 
    // Renvoie 0 si la bille ne peux pas être déplacée  
    // Post : renvoi un Int correspondant au nombre de cases maximal où on peux pousser la bille
    func isMovable(marble : Bille,direction : Int) -> (Int)

}