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
    // Pre : mode est un Int, 0 ou 1
    //      sinon, la création du board échoue
    init?(mode : Int)

    // display : Board ->
    // Affiche le plateau de jeu, avec l'état du jeu actuel
    // Pre : Le board existe
    func display()

    // displayScore : Board ->
    // Affiche les scores des joueurs selon le mode choisit à l'initialisation
    // Et si la partie est finie, affiche le gagnant
    // Pre : le board existe 
    func displayScore()
    
    // RandomMarbles : Board -> 
    // Placeme aléatoirement les billes sur le board
    // Pre : Le Board existe
    // Post : affecte des positions aléatoires chancunes différentes
    //      sans que la même couleur n'apparaisse plus de 2 fois de suite côte à côte ( diagonales incluses )
    mutating func RandomMarbles()

    // TurnOf : Board -> User
    // Donne le joueur dont c'est le tour de jeu
    // Pre : si c'est le premier tour, le joueur qui commence est le joueur 1 
    // Post : renvoie le user qui doit jouer 
    func TurnOf() -> User

    // playerScore : Board x User -> Int
    // Donne le score du joueur donné en paramètre
    // Pre : Le joueur et le board existent
    // Post : Renvoie un entier , le score du joueur
    func playerScore(joueur : User) -> Int

    // gameOver : Board -> Bool
    // Indique si la partie est finie
    // Pre : Aucun des deux joueurs ne peux bouger, ou toutes les billes ont étés joués
    // Post : True si la partie est finie, false sinon
    func gameOver() -> Bool

    // MarblesPosition : Board -> [Marble]
    // Donne les informations concernant les marbles (position, couleur)
    // Pre : 
    // Post : Renvoie un tableau de Billes (Marbles)
    func MarblesInfo() -> [Bille]

     // MoveMarble : Bille x Int x Int ->
    // Déplace la marble selon la direction donnée en param du nombre de cases donnés en paramètres si c'est possible
    // Pre : 1 <= value <= 5
    // Post : déplace la marble selon la valeur donné
    mutating func MoveMarbleDirection(marble : Bille, value: Int, direction : Int)

    // MarblesInLine : Int -> Int
    // Donne le nombre de billes suivant la ligne donnée en paramètre ( sauf celles sur la bordure )
    // Pre : 1 =< row =< 6
    // Post : Renvoie un Int qui correspond au nombre de billes sur la ligne
    func MarblesInLine(row : Int) -> Int

    // MarblesInLine : Int -> Int
    // Donne le nombre de billes suivant la colonne donnée en paramètre ( sauf celles sur la bordure )
    // Pre : 1 =< column =< 6
    // Post : Renvoie un Int qui correspond au nombre de billes sur la colonne
    func MarblesInLine(column : Int) -> Int

    // SkipTurn : Board x User -> User
    // passe le tour du joueur donné en paramètre
    // Pre : Le joueur doit existe
    // renvoi l'autre joueur
    func SkipTurn(joueur: User) -> User

    // CannotMove : Board x User -> Bool
    // Dit si le joueur donné en paramètre est capable de jouer au moins une bille
    // Pre : le joueur doit exister
    // Post : Renvoie true si le joueur peux bouger 
    // et false s'il ne peux pas bouger
    func CanMove(joueur : User) -> Bool

}