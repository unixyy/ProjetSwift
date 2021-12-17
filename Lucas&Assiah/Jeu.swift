struct Jeu : JeuProtocol{
    private var modeDifficile : Bool
    private var tab : [[Position]] = [[]]
    private(set) var nbPieceReserve : Int 
    private(set) var nbPiecePlateau : Int 
    private var reserve : [Piece] = []

   /// init : modeDifficile : Bool -> Jeu
    /// créer un nouveau jeu
    /// modeDifficile : Bool si le mode de jeu est difficile, 
    /// alors il y a la possibilié de gagner en posant 4 pièces avec une caracteristique identique en formant un carré de 2x2
    init(modeDifficile: Bool) {
        self.modeDifficile = modeDifficile
        self.nbPieceReserve = 16
        self.nbPiecePlateau = 0
        self.reserve[0] = Piece.init(estBlanche:false, estRonde:false, estRemplie:false, estGrande:false)
        self.reserve[1] = Piece.init(estBlanche:false, estRonde:false, estRemplie:false, estGrande:true)
        self.reserve[2] = Piece.init(estBlanche:false, estRonde:false, estRemplie:true, estGrande:false)
        self.reserve[3] = Piece.init(estBlanche:false, estRonde:false, estRemplie:true, estGrande:true)
        self.reserve[4] = Piece.init(estBlanche:false, estRonde:true, estRemplie:false, estGrande:false)
        self.reserve[5] = Piece.init(estBlanche:false, estRonde:true, estRemplie:false, estGrande:true)
        self.reserve[6] = Piece.init(estBlanche:false, estRonde:true, estRemplie:true, estGrande:false)
        self.reserve[7] = Piece.init(estBlanche:false, estRonde:true, estRemplie:true, estGrande:true)
        self.reserve[8] = Piece.init(estBlanche:true, estRonde:false, estRemplie:false, estGrande:false)
        self.reserve[9] = Piece.init(estBlanche:true, estRonde:false, estRemplie:false, estGrande:true)
        self.reserve[10] = Piece.init(estBlanche:true, estRonde:false, estRemplie:true, estGrande:false)
        self.reserve[11] = Piece.init(estBlanche:true, estRonde:false, estRemplie:true, estGrande:true)
        self.reserve[12] = Piece.init(estBlanche:true, estRonde:true, estRemplie:false, estGrande:false)
        self.reserve[13] = Piece.init(estBlanche:true, estRonde:true, estRemplie:false, estGrande:true)
        self.reserve[14] = Piece.init(estBlanche:true, estRonde:true, estRemplie:true, estGrande:false)
        self.reserve[15] = Piece.init(estBlanche:true, estRonde:true, estRemplie:true, estGrande:true)
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
        if !self.reserve.contains(piece) {
            throw InvalidPieceError.error
        }else{
            let index = self.reserve.firstIndex(of : piece)!
            reserve.remove(at: index)
            self.nbPieceReserve -= 1
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
        if (x<1 || x>4 || y<1 || y>4){
            return nil
        }else{
            return self.tab[x-1][y-1]
        }

    }

    // placerPiece : Jeu x Position x Piece -> Jeu
    // place une piece à une position donnée sur le plateau
    // placer une piece augmente le nombre de piece sur le plateau de 1
    mutating func placerPiece(pos:Position, piece:Piece){
        pos.placerPiece(piece:piece)
        nbPiecePlateau += 1
    }

    /// estGagnant : Jeu x Position -> Bool
    /// renvoie s'il y a une victoire à partir de la dernière position jouée, mise en paramètre
    /// victoire = au moins 1 caractèristique identique sur 4 pièces alignées sur une même ligne, colonne ou diagonale
    /// post : modifie le paramètre estGagnant des 4 positions gagnantes
    // TODO URGENT
    func estGagnant(pos:Position) -> Bool {
        var winner : Bool = false
        // On Itère sur les colonnes
        var ItColonne = self.makeItColonne(colonne : pos.getColonne())
        var tabPieces : [Piece] = []
        var cpt : Int = 0
        while let ItColonne = ItColonne.next() {
            tabPieces[cpt] = ItColonne
            cpt += 1
        }
        if cpt == 3 {
            if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                winner = true
            }
        }

        // On Itère sur les lignes
        var ItLigne = self.makeItLigne(ligne : pos.getLigne())
        tabPieces = []
        cpt = 0
        while let ItLigne = ItLigne.next() {
            tabPieces[cpt] = ItLigne
            cpt += 1
        }
        if cpt == 3 {
            if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                winner = true
            }
        }

        // On Itère sur la diagonale descendante
        var ItDiagoDesc = self.makeItDiagonale(desc : true)
        tabPieces = []
        cpt = 0
        while let ItDiagoDesc = ItDiagoDesc.next() {
            tabPieces[cpt] = ItDiagoDesc
            cpt += 1
        }
        if cpt == 3 {
            if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                winner = true
            }
        }

        // On Itère sur la diagonale ascendante
        var ItDiagoAsc = self.makeItDiagonale(desc : false)
        tabPieces = []
        cpt = 0
        while let ItDiagoAsc = ItDiagoAsc.next() {
            tabPieces[cpt] = ItDiagoAsc
            cpt += 1
        }
        if cpt == 3 {
            if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                winner = true
            }
        }

        if self.modeDifficile {
            // On Itère sur les carrés
            // Carre Haut Gauche
            // Si on est capable de créer un itérateur carré sur la case (x-1,y-1) 
            if (pos.getColonne() != 1 && pos.getLigne() != 1) {
                var ItCarreHG = self.makeItCarre(pos : (pos.getColonne()-1,pos.getLigne()-1))
                tabPieces = []
                cpt = 0
                while let ItCarreHG = ItCarreHG.next() {
                    tabPieces[cpt] = ItCarreHG
                    cpt += 1
                }
                if cpt == 3 {
                    if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                        winner = true
                    }
                }
            }
            // Carre Haut Droit 
            // Si on est capable de créer un itérateur carré sur la case (x-1,y)
            if (pos.getColonne() != 1 && pos.getLigne() != 4) {
                var ItCarreHD = self.makeItCarre(pos : (pos.getColonne()-1,pos.getLigne()))
                tabPieces = []
                cpt = 0
                while let ItCarreHD = ItCarreHD.next() {
                    tabPieces[cpt] = ItCarreHD
                    cpt += 1
                }
                if cpt == 3 {
                    if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                        winner = true
                    }
                }
            }
            // Carre Bas Gauche
            // Si on est capable de créer un itérateur carré sur la case (x,y-1)
            if (pos.getColonne() != 4 && pos.getLigne() != 1) {
                var ItCarreBG = self.makeItCarre(pos : (pos.getColonne(),pos.getLigne()-1))
                tabPieces = []
                cpt = 0
                while let ItCarreBG = ItCarreBG.next() {
                    tabPieces[cpt] = ItCarreBG
                    cpt += 1
                }
                if cpt == 3 {
                    if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                        winner = true
                    }
                }
            }
            // Carre Bas Droit 
            // Si on est capable de créer un itérateur carré sur la case (x,y)
            if (pos.getColonne() != 4 && pos.getLigne() != 4) {
                var ItCarreBD = self.makeItCarre(pos : (pos.getColonne(),pos.getLigne()))
                tabPieces = []
                cpt = 0
                while let ItCarreBD = ItCarreBD.next() {
                    tabPieces[cpt] = ItCarreBD
                    cpt += 1
                }
                if cpt == 3 {
                    if (compare(p1 : tabPieces[0], p2 : tabPieces[1], p3 : tabPieces[2], p4 : tabPieces[3])) {
                        winner = true
                    }
                }
            }
        }
        return winner

    }

    // renvoie le nombre de piece sur une ligne
    func nbPieceLigne(ligne: Int) -> Int{
        var nbPieceLigne = 0
        for i in 0...3{
            if  getPosition(x:ligne-1,y:i)?.getPiece() != nil{
                nbPieceLigne += 1
            }else{}
        }
        return nbPieceLigne
    }

    // renvoie le nombre de piece sur une colonne
    func nbPieceColonne(colonne: Int) -> Int{
        var nbPieceColonne = 0
        for i in 0...3{
            if getPosition(x:i,y:colonne)?.getPiece() != nil{
                nbPieceColonne += 1
            }else{}
        }
        return nbPieceColonne
    }

    // renvoie le nombre de piece sur une diagonale
    // diagonale decroissante (true) : de (1, 1) à (4, 4) \ 
    // diagonale croissante (false) : de (1, 4) à (4, 1) /
    func nbPieceDiagonale(decroissante: Bool) -> Int{
        var nbPieceDiagonale : Int = 0
        if decroissante == true{
            for i in 0...3{
                if getPosition(x:i,y:3-i)?.getPiece() != nil{
                    nbPieceDiagonale += 1
                }else{}
            }
        }else{
            for i in 0...3{
                if getPosition(x:3-i,y:i)?.getPiece() != nil{
                    nbPieceDiagonale += 1
                }else{}
            }
        }
        return nbPieceDiagonale
    }
   
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
    func nbPieceCarre(posCarre: (Int, Int)) -> Int{
        var nbPieceCarre = 0
        var x = posCarre.0
        var y = posCarre.1
        while x <= posCarre.0+1{
            y = posCarre.1
            while y<=posCarre.1+1{
                if getPosition(x:x,y:y)?.getPiece() != nil{
                    nbPieceCarre += 1
                }
                y += 1
            }
            x += 1
        }
        return nbPieceCarre
    }


    /// compare : Jeu x Piece x Piece x Piece x Piece -> Bool
    /// compare 4 pieces et renvoie true si elles ont au moins une caractéristique en commun
    func compare(p1: Piece, p2 : Piece, p3 : Piece, p4 : Piece) -> Bool{
        if (p1.estBlanche == p2.estBlanche) && (p2.estBlanche == p3.estBlanche) && (p3.estBlanche == p4.estBlanche){
            return true
        }else if (p1.estRonde == p2.estRonde) && (p2.estRonde == p3.estRonde) && (p3.estRonde == p4.estRonde){
            return true
        }else if (p1.estRemplie == p2.estRemplie) && (p2.estRemplie == p3.estRemplie) && (p3.estRemplie == p4.estRemplie){
            return true
        }else if (p1.estGrande == p2.estGrande) && (p2.estGrande == p3.estGrande) && (p3.estGrande == p4.estGrande){
            return true
        } else { return false }
    }

    // makeIterator : Jeu -> Piece
    // iterator sur toutes les pieces de la reserve
    func makeItReserve() -> PiecesIterator{
        return PiecesIterator.init(tab : self.reserve)
    }

    // makeIterator : Jeu -> Position
    // iterator sur toutes les positions du jeu
    func makeIterator() -> PositionIterator{
        return PositionIterator.init(tab : self.tab)

    }

    // iterator sur toutes les pièces d'une ligne
    // pre : 1 <= ligne <= 4
    //     : si une position de la ligne ne contient pas de piece, on passe à la position suivante avant de return
    func makeItLigne(ligne : Int) -> LigneIterator{
        return LigneIterator.init(tab : self.tab, lig : ligne)
    }

    // iterator sur toutes les pièces d'une colonne
    // pre : 1 <= colonne <= 4 
    //     : si une position de la colonne ne contient pas de piece, on passe à la position suivante avant de return
    func makeItColonne(colonne : Int) -> ColonneIterator{
        return ColonneIterator.init(tab : self.tab, col : colonne)

    }

    // iterator sur toutes les pièces d'une diagonale
    // diagonale decroissante (true) : de (1, 1) à (4, 4) \ 
    // diagonale croissante (false) : de (1, 4) à (4, 1) /
    //     : si une position de la diagonale ne contient pas de piece, on passe à la position suivante avant de return
    func makeItDiagonale(decroissante : Bool) -> DiagonaleIterator{
        return DiagonaleIterator.init(tab : self.tab, decr : decroissante)

    }

   // iterator sur toutes les pièces d'un carré
    //     : si une position du carré ne contient pas de piece, on passe à la position suivante avant de return
    // voir nbPieceCarre pour les positions d'un carré
    // exemple, si on donne la position (1,1), l'iterator va renvoyer les Pieces situées dans les Positions aux coordonnées (1,1) -> (2, 1) -> (1, 2) -> (2,2) puis nil à la fin de l'iteration
    // si chacune des positions contiens bien une piece. 
    func makeItCarre(posCarre:(Int, Int)) -> CarreIterator{
        return CarreIterator.init(tab : self.tab, posC : posCarre)
    }
    
    
}

struct PiecesIterator : IteratorProtocol {
    private var tab : [Piece] = []
    private var index : Int = 0

    init(){

    }

    init(tab : [Piece]){
        self.tab = tab
    }

    mutating func next() -> Piece?{
        if index < tab.count{
            defer{
                index += 1
            }
            return self.tab[index]
        }else { 
            return nil
        }
    }
}

struct PositionIterator : IteratorProtocol {
    private var tab : [[Position]] = [[]]
    private var index : Int = 0
    private var jndex : Int = 0

    init(){

    }

    init(tab : [[Position]]){
        self.tab = tab
    }

    mutating func next() -> Position?{
        if index == tab.count{
            return nil
        }
        if jndex == tab[0].count{
            jndex = 0 
            index += 1
        }
        defer{
            jndex += 1
        }
        return self.tab[index][jndex]

    }
}

struct LigneIterator : IteratorProtocol {
    private var ligne : [Position] = []
    private var currentPos : Int

    init(tab : [[Position]], lig : Int){
        for i in 0..<tab.count{
            self.ligne[i] = tab[i][lig]
        }
        self.currentPos = 0
    }
    mutating func next() -> Piece?{
        if currentPos == ligne.count{
            return nil
        }
        else {
            var temp = ligne[currentPos].getPiece()
            currentPos += 1
            if let temp = Piece {
                return temp
            }
            else {
                return self.next()
            }
            
        }
    }
}

struct ColonneIterator : IteratorProtocol {
    private var colonne : [Position] = []
    private var currentPos : Int

    init(tab : [[Position]], col : Int){
        self.colonne = tab[col]
        self.currentPos = 0
    }
    mutating func next() -> Piece?{
        if currentPos == colonne.count{
            return nil
        }
        else {
            var temp = colonne[currentPos].getPiece()
            currentPos += 1
            if let temp = Piece {
                return temp
            }
            else {
                return self.next()
            }
        }
        
    }
}

struct DiagonaleIterator : IteratorProtocol {
    private var diagonale : [Position] = []
    private var currentPos : Int

    init(tab : [[Position]], desc : Bool){
        if desc {
            for i in 0..<tab.count{
                self.diagonale = tab[i][i]
            }
        }
        else {
            for i in 0..<tab.count{
                self.diagonale = tab[i][tab.count-i]
            }
        }
        self.currentPos = 0
    }
    mutating func next() -> Piece?{
        if currentPos == diagonale.count{
            return nil
        }
        else {
            var temp = diagonale[currentPos].getPiece()
            currentPos += 1
            if let temp = Piece {
                return temp
            }
            else {
                return self.next()
            }
        }
        
    }
}

struct CarreIterator : IteratorProtocol {
    private var carre : [Position] = []
    private var currentPos : Int = 0

    init(tab : [[Position]], posC : (Int,Int)){
        var c = posC[0]
        var l = posC[1]
        self.carre[0] = tab[c][l]
        self.carre[1] = tab[c+1][l]
        self.carre[2] = tab[c][l+1]
        self.carre[3] = tab[c+1][l+1]
    }
    mutating func next() -> Piece?{
        if currentPos == carre.count{
            return nil
        }
        else {
            var temp = carre[currentPos].getPiece()
            currentPos += 1
            if let temp = Piece {
                return temp
            }
            else {
                return self.next()
            }
        }
    }
}

enum InvalidPieceError: Error {
    case error
}