struct Jeu : JeuProtocol {
    private var modeDifficile
    private var tab = [[Position]] = [:]
    private var nbPieceReserve : Int 
    private var nbPiecePlateau : Int 
    private var reserve : [Pieces] = []

   /// init : modeDifficile : Bool -> Jeu
    /// créer un nouveau jeu
    /// modeDifficile : Bool si le mode de jeu est difficile, 
    /// alors il y a la possibilié de gagner en posant 4 pièces avec une caracteristique identique en formant un carré de 2x2
    init(modeDifficile: Bool) {
    self.modeDifficile = modeDifficile
    self.nbPieceReserve = 16
    self.nbPiecePlateau = 0
    self.reserve[1] = Piece.init(estBlanche:false, estRonde:false, estRemplie:false, estGrande:false)
    }


    /// restPieceReserve : Jeu -> Bool
    /// indique s'il reste des pieces dans la reserve
    var restePieceReserve : Bool { 
        return nbPieceReserve != 0
    }

    /// choisirPiece : Jeu x Piece -> Jeu
    /// enlève la pièce donnée en paramètre de la reserve
    /// pre : piece est dans la reserve
    ///     erreur -> piece pas dans la reserve
    /// post : diminue le nombre de piece de la reserve de 1
    mutating func choisirPiece(piece : Piece) throws {
        if !self.reserve.contains(piece){
            throw error
        }else{
            // TODO Cette partie
        }

    }

    /// getPosition : Jeu x Int x Int -> Position?
    /// renvoie une position à partir de deux entier x et y. x correspondant à la colonne et y à la ligne
    // pre : 1 <= x <= 4
    //       1 <= y <= 4
    // renvoie vide si la position n'existe pas
    // 
    // pos en (x, y) && pos.estOccupée == true => getPosition(x, y) == vide
    func getPosition(x:Int, y:Int) -> Position? {
        if (x<1 || x>4 || y<1 ||y>4){
            return nil
        }else{
            return self.tab[y][x]
        }

    }

    // placerPiece : Jeu x Position x Piece -> Jeu
    // place une piece à une position donnée sur le plateau
    // placer une piece augmente le nombre de piece sur le plateau de 1
    // TODO : A faire
    mutating func placerPiece(pos:Position, piece:Piece)

    /// estGagnant : Jeu x Position -> Bool
    /// renvoie s'il y a une victoire à partir de la dernière position jouée, mise en paramètre
    /// victoire = au moins 1 caractèristique identique sur 4 pièces alignées sur une même ligne, colonne ou diagonale
    /// post : modifie le paramètre estGagnant des 4 positions gagnantes
    // TODO
    func estGagnant(pos:Position) -> Bool

    // renvoie le nombre de piece sur une ligne
    func nbPieceLigne(ligne: Int) -> Int

    // renvoie le nombre de piece sur une colonne
    func nbPieceColonne(colonne: Int) -> Int

    // renvoie le nombre de piece sur une diagonale
    // diagonale decroissante (true) : de (1, 1) à (4, 4) \ 
    // diagonale croissante (false) : de (1, 4) à (4, 1) /
    func nbPieceDiagonale(decroissante: Bool) -> Int
   
    // renvoie le nombre de piece dans un carre
    // un carré de position est un groupe de 4 positions formant un carré de 2x2 
    // avec comme identifiant la coordonéee de la position en haut à gauche
    // il y a 9 carrés : (1, 1), (3, 1), (1, 3), (3, 3)
    //                 : (2, 1), (1, 2), (3, 2), (2, 3)
    //                 : (2, 2)
    /*
        |------|------|------|------|       
        |  01  |  02  |  03  |  04  |
        |------|------|------|------|
     01 |(1, 1)|(2, 1)|(3, 1)| BRVG |
        |------|------|------|------|
     02 |(1, 2)|(2, 2)|(3, 2)| BRVG |
        |------|------|------|------|
     03 |(1, 3)|(2, 3)|(3, 3)| BRVG |
        |------|------|------|------|
     04 | BRVG | BRVG | BRVG | BRVG |
        |------|------|------|------|
    */
    func nbPieceCarre(posCarre: (Int, Int)) -> Int

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

   // iterator sur toutes les pièces d'un carré
    //     : si une position du carré ne contient pas de piece, on passe à la position suivante avant de return
    // voir nbPieceCarre pour les positions d'un carré
    // exemple, si on donne la position (1,1), l'iterator va renvoyer les Pieces situées dans les Positions aux coordonnées (1,1) -> (2, 1) -> (1, 2) -> (2,2) puis nil à la fin de l'iteration
    // si chacune des positions contiens bien une piece. 
    func makeItCarre(posCarre:(Int, Int)) -> CarreIterator
   
    /// compare : Jeu x Piece x Piece x Piece x Piece -> Bool
    /// compare 4 pieces et renvoie true si elles ont au moins une caractéristique en commun
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

protocol CarreIteratorProtocol : IteratorProtocol {
    init()
    next() -> Piece?
}