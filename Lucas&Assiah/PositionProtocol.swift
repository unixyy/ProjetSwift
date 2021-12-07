/*
---------- Protocol Position ----------
   JEU : QUARTO

   EQUIPE : 11

   MEMBRES : 
        - Lucas DARIE
        - Assia HANNOU-MOUSSAOUI

    TYPES : 
        - Jeu
        - Piece
        - Position
---------------------------------------
*/

/// init -> Position
/// crée une position

/// estOccupée : Position -> Bool
/// vérifie si la position est occupée

/// placerPiece : Position x Piece -> Position
/// place une piece sur la position

/// getPiece : Position -> Piece?
/// renvoie la piece de la position ou vide si pas de piece

/// estGagnant : Position -> Bool
/// indique si la position appartient à l'alignement gagnant

/// estSurDiagDecroissante : Position -> Bool
/// renvoie si la position est sur la diagonale décroissante (de (1,1) à (4, 4))

/// estSurDiagCroissante : Position -> Bool
/// renvoie si la position est sur la diagonale croissante (de (1,4) à (4, 1))

/// getLigne : Position -> Int
/// renvoie le numero de la ligne de la position

/// getColonne : Position -> Int
/// renvoie le numero de la colonne de la position

/// makeIterator :Position -> PosCarreIterator


/// estOccupée(init()) == false
/// estOccupée(placerPiece(init(), p)) == true

/// getPiece(init()) == vide
/// getPiece(placerPiece(init(), p)) == p

/// estGagnant(init()) == false

protocol PositionProtocol {
    /// init -> Position
    /// crée une position
    init () 

    /// estOccupée : Position -> Bool
    /// vérifie si la position est occupée
    var estOccupee : Bool { get }

    /// placerPiece : Position x Piece -> Position
    /// place une piece sur la position
    mutating func placerPiece(piece:Piece)

    /// getPiece : Position -> Piece?
    /// renvoie la piece de la position ou vide si pas de piece
    func getPiece() -> Piece?

    /// estGagnant : Position -> Bool
    /// indique si la position appartient à l'alignement gagnant
    var estGagnant : Bool { get set }

    // renvoie si la position est sur la diagonale décroissante (de (1,1) à (4, 4))
    var estSurDiagDecroissante : Bool { get }

    // renvoie si la position est sur la diagonale croissante (de (1,4) à (4, 1))
    var estSurDiagCroissante : Bool { get }

    // renvoie le numero de la ligne de la position
    var getLigne : Int { get }

    // renvoie le numero de la colonne de la position
    var getColonne : Int { get }


    // iterator sur toutes les coordonées des carrés qui contiennent la Position
    // un carré de position est un groupe de 4 positions formant un carré de 2x2 
    // avec comme identifiant la coordonéee de la position en haut à gauche
    // il y a 9 carrés : (1, 1), (3, 1), (1, 3), (3, 3)
    //                 : (2, 1), (1, 2), (3, 2), (2, 3)
    //                 : (2, 2)
    // exemple : si la position est sur la ligne 2 et la colonne 2 : itère sur les valeurs suivante : (1, 1) -> (2, 1) -> (1, 2) -> (2, 2) -> nil
    func makeIterator() -> PosCarreIterator
}

protocol PosCarreIteratorProtocol : IteratorProtocol {
    init()
    next() -> (Int, Int)?
}
