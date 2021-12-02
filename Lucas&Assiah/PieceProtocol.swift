/*
---------- Protocol Piece ----------
   JEU : QUARTO

   EQUIPE : 11

   MEMBRES : 
        - Lucas DARIE
        - Assia HANNOU-MOUSSAOUI

    TYPES : 
        - Jeu
        - Piece
        - Position
------------------------------------
*/
/// init : Bool x Bool x Bool x Bool -> Piece 
/// crée une piece avec les caractéristiques : couleur, forme, remplissage, hauteur
/// estBlanche : Piece -> Bool // vérifie si la piece est de couleur blanche (pas noir)
/// estRonde : Piece -> Bool // vérifie si la piece est ronde (pas carrée)
/// estRemplie : Piece -> Bool // vérifie si la pièce est remplie (pas creuse)
/// estGrande : Piece -> Bool // vérifie si la pièce est grande (pas petite)
/// compare : Piece x Piece x Piece x Piece -> Bool // compare 4 pieces et renvoie true si elles ont au moins une caractéristique en commun
/// 
/// estBlanche(init(false, Bool, Bool, Bool)) == false
/// estBlanche(init(true, Bool, Bool, Bool)) == true
/// 
/// estRonde(init(Bool, false, Bool, Bool)) == false
/// estRonde(init(Bool, true, Bool, Bool)) == true
///
/// estRemplie(init(Bool, Bool, false, Bool)) == false
/// estRemplie(init(Bool, Bool, true, Bool)) == true
///
/// estGrande(init(Bool, Bool, Bool, false)) == false
/// estGrande(init(Bool, Bool, Bool, true)) == true
///
/// compare(p1, p2, p3, p4) == true => p1 et p2 et p3 et p4 ont au moins une des caractéristiques en commun

protocol PieceProtocol {

    /// init : Bool x Bool x Bool x Bool -> Piece 
    /// crée une piece avec les caractéristiques : couleur, forme, remplissage, hauteur
    init(estBlanche:Bool, estRonde:Bool, estRemplie:Bool, estGrande:Bool)

    /// estBlanche : Piece -> Bool // vérifie si la piece est de couleur blanche (pas noir)
    var estBlanche : Bool { get }

    /// estRonde : Piece -> Bool // vérifie si la piece est ronde (pas carrée)
    var estRonde : Bool { get }

    /// estRemplie : Piece -> Bool // vérifie si la pièce est remplie (pas creuse)
    var estRemplie : Bool { get }

    /// estGrande : Piece -> Bool // vérifie si la pièce est grande (pas petite)
    var estGrande : Bool { get }
}