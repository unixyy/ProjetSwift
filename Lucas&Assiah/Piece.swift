struct Piece : PieceProtocol{

    private var estBlanche : Bool, estRonde : Bool, estRemplie : Bool, estGrande : Bool
    /// init : Bool x Bool x Bool x Bool -> Piece 
    /// crée une piece avec les caractéristiques : couleur, forme, remplissage, hauteur

    init(estBlanche:Bool, estRonde:Bool, estRemplie:Bool, estGrande:Bool){
        self.estBlanche = estBlanche
        self.estRonde = estRonde
        self.estRemplie = estRemplie
        self.estGrande = estGrande
    }

}