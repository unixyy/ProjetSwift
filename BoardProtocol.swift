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

    // TurnOf : Board -> User
    // Donne Le joueur joueur qui doit jouer au tour actuel
    // Pre : si c'est le premier tour, le joueur qui commence est aléatoire
    // Post : Joueur qui doit jouer sous forme de Boolean , true pour le joueur 1, false pour le joueur 2
    func TurnOf() -> User

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

    // MarblesPosition : Board -> [Marble]
    // Donne les informations concernant les marbles (position, couleur)
    // Pre : 
    // Post : Renvoie un tableau de Billes (Marbles)
    func MarblesInfo() -> [Bille]

    // SkipTurn : Board x User -> User
    // passe le tour du joueur donné en paramètre
    // Pre : Le joueur existe
    // renvoi l'autre joueur
    func SkipTurn(joueur: User) -> User

}