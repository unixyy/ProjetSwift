/*
---------- Protocol Jeu ----------
   JEU : QUARTO

   EQUIPE : 11

   MEMBRES : 
        - Lucas DARIE
        - Assia HANNOU-MOUSSAOUI

    TYPES : 
        - Jeu
        - Piece
        - Position
----------------------------------
*/

/// init()
/// nbPieceReserve : Jeu -> Int // indique le nombre de pieces restantes dans la reserve
/// nbPiecePlateau : Jeu -> Int // indique le nombre de pieces restantes sur le plateau
/// restPieceReserve : Jeu -> Bool // indique s'il reste des pieces dans la reserve
/// choisirPiece : Jeu x Piece -> Jeu // enlève la pièce donnée en paramètre de la reserve
/// getPosition : Jeu x Int x Int -> Position? // renvoie une position à partir de deux entier x et y. x correspondant à la colonne et y à la ligne
/// estGagnant : Jeu x Position -> Bool // renvoie s'il y a une victoire à partir de la dernière position jouée, mise en paramètre
/// nbPieceLigne : Jeu x Int -> Int // renvoie le nombre de piece sur une ligne
/// nbPieceColonne : Jeu x Int -> Int // renvoie le nombre de piece sur une colonne
/// nbPieceDiagonale: Jeu x Int -> Int // renvoie le nombre de piece sur une diagonale
/// makeItReserve : Jeu -> PiecesIterator // iterator sur toutes les pieces de la reserve
/// makeIterator : Jeu -> PositionIterator // iterator sur toutes les positions du jeu
/// MakeItLigne : Jeu x Int-> LigneIterator // iterator sur toutes les pièces d'une ligne
/// MakeItColonne : Jeu x Int-> ColonneIterator // iterator sur toutes les pièces d'une colonne
/// MakeItDiagonale : Jeu x Bool -> DiagonaleIterator // iterator sur toutes les pièces d'une diagonale
/// compare : Jeu x Piece x Piece x Piece x Piece -> Bool
/// 
/// 
/// nbPieceReserve(init()) == 16

/// placerPiece(getPosition(jeu_etape1, 0, 0), piece)
/// =>  nbPieceReserve(jeu_etape2) == nbPieceReserve(jeu_etape1)-1

/// placer une piece augmente le nombre de piece sur le plateau de 1

/// choisir une piece diminue le nombre de piece de la reserve de 1

/// restePieceReserve(init()) == true
/// nbPieceReserve(jeu) == 0 => restePieceReserve(jeu) == false

/// iterator sur ligne, colonne, diagonale, renvoie uniquement les pieces s'il y en a


protocol JeuProtocol : Sequence {
    /// créer un nouveau jeu
    init()

    /// nbPieceReserve : Jeu -> Int
    /// indique le nombre de pieces restantes dans la reserve
    var nbPieceReserve : Int { get }

    /// nbPiecePlateau : Jeu -> Int
    /// indique le nombre de pieces restantes sur le plateau
    var nbPiecePlateau : Int { get }

    /// restPieceReserve : Jeu -> Bool
    /// indique s'il reste des pieces dans la reserve
    var restePieceReserve : Bool { get }

    /// choisirPiece : Jeu x Piece -> Jeu
    /// enlève la pièce donnée en paramètre de la reserve
    /// pre : piece est dans la reserve
    ///     erreur -> piece pas dans la reserve
    /// post : diminue le nombre de piece de la reserve de 1
    mutating func choisirPiece(piece : Piece) throws

    /// getPosition : Jeu x Int x Int -> Position?
    /// renvoie une position à partir de deux entier x et y. x correspondant à la colonne et y à la ligne
    // pre : 1 <= x <= 4
    //       1 <= y <= 4
    // renvoie vide si la position n'existe pas
    // 
    // pos en (x, y) && pos.estOccupée == true => getPosition(x, y) == vide
    func getPosition(x:Int, y:Int) -> Position?

    // placerPiece : Jeu x Position x Piece -> Jeu
    // place une piece à une position donnée sur le plateau
    // placer une piece augmente le nombre de piece sur le plateau de 1
    mutating func placerPiece(pos:Position, piece:Piece)

    /// estGagnant : Jeu x Position -> Bool
    /// renvoie s'il y a une victoire à partir de la dernière position jouée, mise en paramètre
    /// victoire = au moins 1 caractèristique identique sur 4 pièces alignées sur une même ligne, colonne ou diagonale
    /// post : modifie le paramètre estGagnant des 4 positions gagnantes
    func estGagnant(pos:Position) -> Bool

    // renvoie le nombre de piece sur une ligne
    func nbPieceLigne(ligne: Int) -> Int

    // renvoie le nombre de piece sur une colonne
    func nbPieceColonne(colonne: Int) -> Int

    // renvoie le nombre de piece sur une diagonale
    // diagonale decroissante (true) : de (1, 1) à (4, 4) \ 
    // diagonale croissante (false) : de (1, 4) à (4, 1) /
    func nbPieceDiagonale(decroissante: Bool) -> Int

    // makeIterator : Jeu -> Piece
    // iterator sur toutes les pieces de la reserve
    func makeItReserve() -> PiecesIterator

    // makeIterator : Jeu -> Position
    // iterator sur toutes les positions du jeu
    func makeIterator() -> PositionIterator

    // iterator sur toutes les pièces d'une ligne
    // pre : 1 <= ligne <= 4
    //     : si une position de la ligne ne contient pas de piece, on passe à la position suivante avant de return
    func makeItLigne(ligne : Int) -> LigneIterator

    // iterator sur toutes les pièces d'une colonne
    // pre : 1 <= colonne <= 4 
    //     : si une position de la colonne ne contient pas de piece, on passe à la position suivante avant de return
    func makeItColonne(colonne: Int) -> ColonneIterator

    // iterator sur toutes les pièces d'une diagonale
    // diagonale decroissante (true) : de (1, 1) à (4, 4) \ 
    // diagonale croissante (false) : de (1, 4) à (4, 1) /
    //     : si une position de la diagonale ne contient pas de piece, on passe à la position suivante avant de return
    func makeItDiagonale(decroissante:Bool) -> DiagonaleIterator

    /// compare : Jeu x Piece x Piece x Piece x Piece -> Bool
    /// compare 4 pieces et renvoie si elles ont au moins une caractéristique en commun
    func compare(p1: Piece, p2 : Piece, p3 : Piece, p4 : Piece) -> Bool
}

protocol PiecesIteratorProtocol : IteratorProtocol {
    init()
    next() -> Piece?
}

protocol PositionIteratorProtocol : IteratorProtocol {
    init()
    next() -> Position?
}

protocol LigneIteratorProtocol : IteratorProtocol {
    init()
    next() -> Piece?
}

protocol ColonneIteratorProtocol : IteratorProtocol {
    init()
    next() -> Piece?
}

protocol DiagonaleIteratorProtocol : IteratorProtocol {
    init()
    next() -> Piece?
}