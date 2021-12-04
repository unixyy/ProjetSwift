
protocol MarbleProtocol{

    // Correspond à la couleur de la bille
    // False : Noir
    // True : Blanc
    var estBlanc : Bool { get }
    // Direction initiale de la bille ( vers où elle peux être déplaçée depuis la bord )
    // selon une enumeration des directions
    var initialDirection : DirectionEnum { get }
    
    
    init(estBlanc : Bool, initalDirection : DirectionEnum)

    
}