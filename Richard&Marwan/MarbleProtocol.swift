
protocol MarbleProtocol{
    // Correspond à la couleur de la bille
    // False : Noir
    // True : Blanc
    var estBlanc : Bool { get }
    // Direction initiale de la bille ( vers où elle peux être déplaçée depuis la bord )
    var initialDirection : Int { get }
    // Position actuelle de la bille , elle est unique à la bille à tout instant T
    var position : (Int,Int) { get set }
    
    init(estBlanc : Bool, initalDirection : Int, position : (Int,Int))


    // isInBorder : Marble -> Bool
    // indique si la marble est encore sur le bord du terrain
    // Post: Renvoie true si la marble est sur le bord, sinon false
    func isInBorder() -> Bool
    
}