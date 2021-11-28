// Liste des fonctionnalités de Board :
/*
    - Créer un plateau rempli avec les marbles placés aléatoirement
    - Pareil mais en choisissant le mode de comptage des points
    - Placer aléatoirement les marbles
    - Savoir à quel joueur est-ce le tour de jeu
    - Savoir où sont actuellement les marbles
    - Savoir si la partie est terminée ou non
    - Calculer le score des joueurs
    -



*/

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


protocol BoardProtocol {

    associatedtype Bille : Marble
    // init : -> Board
    // Création du Board, avec les marbles placées aléatoirement sur le board
    init()

    // init : String -> Board
    // Création du Board, avec les marbles placées aléatoirement sur le board
    // le mode est choisi (simple / multiplicateur)
    // Pre : mode est un Boolean, true ou false
    //      sinon, la création du board échoue
    init?(mode : Bool)
    
    // RandomMarbles : Board -> 
    // placement aléatoire sur le board des marbles
    // Pre : Le Board existe
    // Post : affecte des positions aléatoires chancunes différentes
    //      sans que la même couleur n'apparaisse plus de 2 fois de suite
    mutating func RandomMarbles()

    // TurnOf : Board -> Bool
    // Donne Le joueur joueur qui doit jouer au tour actuel
    // Pre : si c'est le premier tour, le joueur qui commence est aléatoire
    // Post : Joueur qui doit jouer sous forme de Boolean , true pour le joueur 1, false pour le joueur 2
    func TurnOf() -> Bool

    // playerScore : Board -> (Int;Int)
    // Donne le score des deux joueurs
    // Pre : 
    // Post : Renvoie un doublet d'entiers , le premier entier correspond au score du joueur 1
    func playerScore() -> (Int;Int)

    //  gameOver() : Board -> Bool
    // Indique si la partie est finie
    // Pre : 
    // Post : True si la partie est finie, false sinon
    func gameOver() -> Bool

    // MarblesPosition() : Board -> [Marble]
    // Donne les informations concernant les marbles (position, couleur)
    // Pre : 
    // Post : Renvoie un tableau de Billes (Marbles)
    func MarblesInfo() -> [Bille]

}

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
    func MarbleColor(M : Bille) -> Bool?

    // MarblePack : User -> Array<Int>
    // donne une liste du nombre de Marble par Pack différents
    // Post : liste de nombre de marbles par pack
    func MarblePack() -> Array<Int>


    // Score : Bool x User x Marble -> Int
    // fonction qui détermine le score du joueur
    // Pre : Mode est un Boolean
    // Post : Score du Joueur selon le mode de jeu choisit
    func Score(mode : Bool) -> Int
    
    // MovesLeft : User -> Int
    // Donne le nombre de coups en retards restants du joueur
    // Pre : Le joueur n'a pas de coups de retard au début de la partie
    // MovesLeft(Init(player : 1)) = 0  
    // Post : Renvoie un Int correspondant au nombre de coups en retards restants du joueur
    func MovesLeft() -> Int

    // BonusMove : User ->
    // Effectue un coup supplémentaire si le joueur avait au moins un coup en retard restant
    // Pre : Ne fais rien si le joueur n'a pas de coups en retard
    // Post : Modifie le nombre de coups restants et effectue un coup
    // MovesLeft()  != 0 => MovesLeft(BonusMove()) = MovesLeft() - 1
    mutating func BonusMove()


    // movable : Bille -> String x Int
    // Donne dans quelle direction et de combien de cases la bille peux être déplacée au maximum
    // Pre : les directions sont : Nord, Sud, Est, Ouest
    // Renvoie 0 si la bille ne peux pas être déplacée  
    // Post : Renvoie un String correspondant à la direction où la bille peux être déplacée 
    // ainsi qu'un entier correspondant au nombre de cases maximal où on peux pousser la bille
    func movable(B : Bille) -> (String;Int)

}


