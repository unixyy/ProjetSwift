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

protocol BoardProtocol : Sequence {
    // Correspond au mode de calcul du score
    // mode = 0 : mode simple de calcul
    // mode = 1 : mode mutiplicatif
    var mode : Int { get }

    // init : String -> Board
    // Création du Board, avec les marbles placées aléatoirement sur le board
    // le mode est choisi (simple / multiplicateur)
    // Pre : mode est un Int, 0 ou 1
    //      sinon, la création du board échoue
    init?(mode : Int)

    // makeIterator : Board -> MarbleIterator
    // créée un itérateur sur les marbles et le renvoie
    // Pre : le board existe
    // Post : Renvoie l'itérateur sur les marbles 
    func makeIterator() -> MarbleIterator 

    // BoardIterator : Board -> MarbleIterator
    // Renvoie l'itérateur sur la collection de marbles

    func BoardIterator() -> MarbleIterator
    // display : Board -> String
    // Affiche le plateau de jeu, avec l'état du jeu actuel
    // Pre : Le board existe
    // Post : Renvoie le string qui va être affiché en tant qu'interface
    func display() -> String

    // displayScore : Board -> String
    // Affiche les scores des joueurs selon le mode choisit à l'initialisation
    // Et si la partie est finie, affiche le gagnant
    // Pre : le board existe 
    // Post : Renvoie le string qui va être affiché en tant que Score des joueurs
    func displayScore() -> String
    
    // RandomMarbles : Board-> 
    // Placeme aléatoirement les Marbles sur le board
    // Pre : Le Board existe
    // Post : affecte des positions aléatoires chancunes différentes
    //      sans que la même couleur n'apparaisse plus de 2 fois de suite côte à côte ( diagonales incluses )
    mutating func RandomMarbles()

    // TurnOf : Board -> User
    // Donne le joueur dont c'est le tour de jeu et change le joueur du tour
    // Pre : si c'est le premier tour, le joueur qui commence est le joueur 1 
    // Post : renvoie le user qui doit jouer actuellement
    mutating func TurnOf() -> User


    // gameOver : Board -> Bool
    // Indique si la partie est finie
    // Pre : Aucun des deux joueurs ne peux bouger, ou toutes les Marbles ont étés joués
    // Post : True si la partie est finie, false sinon
    func gameOver() -> Bool

    // MarblesPosition : Board -> [Marble]
    // Donne les informations concernant les marbles (position, couleur)
    // Pre : 
    // Post : Renvoie un tableau de Marbles (Marbles)
    func MarblesInfo() -> [Marble]

    // MoveMarble : Marble x Int x Int ->
    // Déplace la marble selon la direction donnée en param du nombre de cases donnés en paramètres si c'est possible
    // Pre : 1 <= value <= 5
    // Post : déplace la marble selon la valeur donné
    mutating func MoveMarbleDirection(marble : Marble, value: Int, direction : Int)

    // MarblesInLine : Int -> Int
    // Donne le nombre de Marbles suivant la ligne donnée en paramètre ( sauf celles sur la bordure )
    // Pre : 1 =< row =< 6
    // Post : Renvoie un Int qui correspond au nombre de Marbles sur la ligne
    func MarblesInLine(row : Int) -> Int

    // MarblesInLine : Int -> Int
    // Donne le nombre de Marbles suivant la colonne donnée en paramètre ( sauf celles sur la bordure )
    // Pre : 1 =< column =< 6
    // Post : Renvoie un Int qui correspond au nombre de Marbles sur la colonne
    func MarblesInLine(column : Int) -> Int

    // SkipTurn : Board x User -> User
    // passe le tour du joueur donné en paramètre
    // Pre : Le joueur doit existe
    // renvoi l'autre joueur
    func SkipTurn(joueur: User) -> User

    // CannotMove : Board x User -> Bool
    // Dit si le joueur donné en paramètre est capable de jouer au moins une Marble
    // Pre : le joueur doit exister
    // Post : Renvoie true si le joueur peux bouger 
    // et false s'il ne peux pas bouger
    func CanMove(joueur : User) -> Bool

    // cellsMovable : Board x Marble -> Int
    // Donne le nombre de cases au maximum où on peux bouger la Marble donnée en paramètre
    // Pre : la Marble doit exister
    // Post : renvoie un int , le nombre de cases max où on peux bouger 
    // renvoie 0 si la Marble ne peux pas bouger
    // cellsMovable(M) != 0 <=> isMovable 
    func cellsMovable(marble : Marble) -> Int 

    // movable : Board x  Marble -> Bool
    // Donne si la marble peut bouger
    // Pre : la Marble doit exister 
    // Post : renvoie true si la Marble est déplaçable
    // 
    func isMovable(marble : Marble) -> Bool

    // getMarble : Board x Int -> (Marble|Vide)
    // Donne les informations associées au numéro de la marble
    // informations dans la Marble : Identifiant, Position, Couleur, direction initiale
    // Pre : num est un Int correspondant au numéro de la marble voulue
    // Post : la Marble si le numéro est valide, sinon Vide
    func getMarble(num : Int) -> Marble?

    // MarblePack : Board x Marble -> Int
    // donne le nombre de Marbles dans le pack de cellule donnée en paramètre
    // Post : renvoi la valeur du pack dans lequel est la marble
    // Si M1 et M2 sont dans le même pack ( marbles adjacentes ) => MarblePack(M1) = MarblePack(M2)
    func MarblePack(marble : Marble) -> Int

    // isNearby : Marble x Marble -> Bool
    // Dit si les marbles donnés en paramètres sont adjacentes
    // Pre : les marbles existent
    // Post : True si les marbles sont adjacentes, false sinon
    func isNearby(M1 : Marble, M2 : Marble) -> Bool

    // Score : User x Int -> Int
    // Détermine le score du joueur
    // Pre : Mode est soit : 0 pour le mode simple
    //                soit : 1 pour le mode multiplicatif
    // Post : renvoie un Int,  Score du Joueur selon le mode de jeu choisit
    // Si mode == 0 => Pour toutes les Marbles B du joueur, il existe au moins une Marble M où MarblePack(M) >= MarblePack(B).
    // Le score est ainsi la valeur de MarblePack(M)
    // Si mode == 0 => Pour toutes les Marbles B du joueur, 
    func Score(estBlanche : Bool) -> Int

}