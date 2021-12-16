struct Position: PositionProtocol{

    /// estOccupée : Position -> Bool
    /// vérifie si la position est occupée
    private(set) var estOccupee : Bool
    private(set) var contenu : Piece?
    private(set) var getLigne : Int
    private(set) var getColonne : Int
    internal var estGagnant : Bool

    

    init(){
        self.estOccupee = false
        self.contenu = nil
        self.estGagnant = false
        self.getLigne = 0
        self.getColonne = 0
    } 

    init(pos:(Int,Int)){
        self.estOccupee = false
        self.contenu = nil
        self.getLigne = pos.0
        self.getColonne = pos.1
        self.estGagnant = false
        
    }


    /// placerPiece : Position x Piece -> Position
    /// place une piece sur la position
    mutating func placerPiece(piece:Piece){
        self.contenu = piece
    }


    func getPiece() -> Piece?{
        return self.contenu
    }


    // renvoie si la position est sur la diagonale décroissante (de (1,1) à (4, 4))
    var estSurDiagDecroissante : Bool { 
        var i : Int = 0
        while i<4 {
            if (self.getLigne, self.getColonne) == (i,i){
                return true
            }
            i += 1
        }
        return false
    }

    // renvoie si la position est sur la diagonale croissante (de (1,4) à (4, 1))
    var estSurDiagCroissante : Bool { 
        var i : Int = 0
        while i<4 {
            if (self.getLigne, self.getColonne) == (i,3-i){
                return true
            }
            i += 1
        }
        return false
    }



    // iterator sur toutes les coordonées des carrés qui contiennent la Position
    // un carré de position est un groupe de 4 positions formant un carré de 2x2 
    // avec comme identifiant la coordonéee de la position en haut à gauche
    // il y a 9 carrés : (1, 1), (3, 1), (1, 3), (3, 3)
    //                 : (2, 1), (1, 2), (3, 2), (2, 3)
    //                 : (2, 2)
    // exemple : si la position est sur la ligne 2 et la colonne 2 : itère sur les valeurs suivante : (1, 1) -> (2, 1) -> (1, 2) -> (2, 2) -> nil
    func makeIterator() -> PosCarreIterator{
        let tmpL = getLigne
        let tmpC = getColonne
        if tmpL > 3{
            tmpL -= 1
        } else if tmpL <0{
            tmpL += 1
        }
        if tmpC > 3{
            tmpC -= 1
        } else if tmpC < 0{
            tmpC += 1
        }

        let PosCarre = PosCarreIterator.init(pos: (tmpL, tmpC))
        return PosCarre
    }
}

struct PosCarreIterator : PosCarreIteratorProtocol {

    private let values : [(Int,Int)]
    private var index : Int

    init(){
        self.index = 0
        self.values = [(0,0)]
    }

    init(pos : (Int,Int)){
        self.index = 0
        self.values = [(pos.0,pos.1),(pos.0+1,pos.1),(pos.0,pos.1+1),(pos.0+1,pos.1+1)]
    }

    mutating func next() -> (Int, Int)?{
        if index < values.count-1{
            index += 1
            return values[self.index]
        }
        return nil
    }
}
