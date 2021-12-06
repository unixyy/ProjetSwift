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
    // Création du board, des positions, avec les marbles placées aléatoirement sur le board
    // le mode est choisi (simple / multiplicateur)
    // Pre : mode est un Int, 0 ou 1
    //      sinon, la création du board échoue
    init?(mode : Int)

    // RandomColor : Board x Marble -> Marble
    // détermine une couleur aléatoire pour la marble choisie
    // Pre : la marble existe
    // Post : renvoie la marble avec la variable estBlanc:Bool modifiée
    mutating func RandomColor(marble: Marble) -> Marble

    // makeIterator : Board -> MarbleIterator
    // créée un itérateur sur les marbles et le renvoie
    // Pre : le board existe
    // Post : Renvoie l'itérateur sur les marbles 
    func makeIterator() -> MarbleIterator 

    // BoardIterator : Board -> MarbleIterator
    // Renvoie l'itérateur sur la collection de marbles
    func BoardIterator() -> MarbleIterator

    // positionIterator : Board -> PositionIterator
    // Renvoie l'itérateur sur la collection des positions
    func positionIterator() -> PositionIterator

    // gameOver : Board -> Bool
    // Indique si la partie est finie
    // Pre : Aucun des deux joueurs ne peux bouger, ou toutes les Marbles ont étés joués
    // Post : True si la partie est finie, false sinon
    func gameOver() -> Bool

    // MoveMarble : Marble x Int x Int ->
    // Déplace la marble selon la direction donnée en param du nombre de cases donnés en paramètres si c'est possible
    // Pre : 1 <= value <= 5
    // Post : déplace la marble selon la valeur donné
    mutating func MoveMarble(marble : Marble, value: Int, direction : DirectionEnum)


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

    // CannotMove : Board x Marble -> Bool
    // Dit si on peut déplacer au moins une marble de la couleur choisie
    // Pre : estBlanc est un Boolean
    // Post : Renvoie true s'il existe au moins une marble déplacable de la couleur
    // et false sinon
    func CanMove(estBlanc: Bool) -> Bool

    // cellsMovable : Board x Marble x Int -> Int
    // Donne le nombre de cases au maximum où on peux bouger la Marble donnée en paramètre
    // Pre : la Marble doit exister
    // Post : renvoie un int , le nombre de cases max où on peux bouger dans la direction choisie
    // renvoie 0 si la Marble ne peux pas bouger
    // cellsMovable(M) != 0 <=> isMovable 
    func cellsMovable(marble : Marble, direction : DirectionEnum) -> Int 

    // movable : Board x  Marble -> Bool
    // Donne si la marble peut bouger
    // Pre : la Marble doit exister 
    // Post : renvoie true si la Marble est déplaçable
    func isMovable(marble : Marble) -> Bool


    // NextTo : Board x Marble x Int -> Marble?
    // renvoie la présence d'une marble ou non juste à côté, dans la direction choisie
    // renvoie une marble s'il y en a une à côté dans la diretion, sinon Vide
    func NextTo(marble : Marble, direction : DirectionEnum) -> Marble?

    // willBeLastMoved : Board x Marble -> Marble
    // renvoie la dernière marble qui sera poussée par la marble choisie
    func willBeLastMoved(marble : Marble) -> Marble

    // getPosition : Board x Marble -> Position
    // renvoie la Position affiliée à la Marble choisie
    // Post : renvoi une position
    func getPosition(marble: Marble) -> Position
    
    // isMarble : Board x Position -> Marble?
    // Pre : La position appartient au plateau de jeu
    // renvoie la marble si une marble est a la position demandée, sinon renvoie Vide
    func getMarble(position : Position) -> Marble?
    
    // isInBorder : Board x Marble -> Bool
    // renvoie un boolean indiquant si la marble choisie est sur le bord ou pas
    // pre : la marble existe
    // Post : renvoie True si la marble est sur le bord, sinon false
    func isInBorder(marble : Marble) -> Bool

    // setMarble : Board x Marble x Position ->
    // place une marble sur la position indiquée, si celle-ci est vide
    mutating func setMarble(marble: Marble,position : Position)

    // MarblePack : Board x Marble -> Int
    // donne le nombre de Marbles dans le pack de cellule donnée en paramètre
    // Post : renvoi la valeur du pack dans lequel est la marble
    // Si M1 et M2 sont dans le même pack ( marbles adjacentes ) => MarblePack(M1) = MarblePack(M2)
    func MarblePack(marble : Marble) -> Int


    // Score : Board x Bool-> Int
    // Détermine le score du joueur choisi
    // isPlayer1 true c'est le joueur 1 , false c'est le joueur 2
    // Post : renvoie un Int,  Score du Joueur selon le mode de jeu choisit
    // Si mode == 0 => Pour toutes les Marbles B du joueur, il existe au moins une Marble M où MarblePack(M) >= MarblePack(B).
    // Le score est ainsi la valeur de MarblePack(M)
    // Si mode == 0 => Pour toutes les Marbles B du joueur, 
    func Score(isPlayer1 : Bool) -> Int

}