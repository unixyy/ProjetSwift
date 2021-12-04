

protocol PositionProtocol{


    var position : (Int,Int) { get }
    var isBorder : Bool { get }
    var contains : Marble? { get set }


    init(position: (Int,Int), isBorder : Bool, contains : Marble?)




}