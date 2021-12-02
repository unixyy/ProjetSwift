
protocol MarbleProtocol{
    // Correspond à l'identifiant de cette Bille , il est unique
    var id : Int { get }
    // Correspond à la couleur de la bille
    // False : Noir
    // True : Blanc
    var color : Bool { get }
    // Direction initiale de la bille ( vers où elle peux être déplaçée depuis la bord )
    var initialDirection : Int { get }
    // Position actuelle de la bille , elle est unique à la bille à tout instant T
    var position : (Int,Int) { get set }
    
    init(color : bool, direction : Int, position : (Int,Int), id : Int ) 

    


}