/*
---------- MAIN ----------
   JEU : QUARTO

   EQUIPE : 11

   MEMBRES : 
        - Lucas DARIE
        - Assia HANNOU-MOUSSAOUI

    TYPES : 
        - Jeu
        - Piece
        - Position
--------------------------
*/

import Foundation
func printPiece(p:Piece) {
    // B : Blanche / N : Noire
    // R : Ronde / C : Carrée
    // R : Remplie / V : Vide
    // G : Grande / P : Petite
    print(" ",terminator:"")
    print((p.estBlanche) ? "B" : "N", terminator:"")
    print((p.estRonde) ? "R" : "C", terminator:"")
    print((p.estRemplie) ? "R" : "V", terminator:"")
    print((p.estGrande) ? "G" : "P", terminator:"")
    print(" ",terminator:"")
}

// le joueur saisi un nombre entre 1 et le nombre de piece dans la reserve
// tant que la saisie n'est pas valide le joueur peut re-saisir un nombre
func saisieInt(max:Int) -> Int{
    var choix = 0
    repeat {
        if let typed = readLine() {
            if let num = Int(typed) {
                choix = num
            }
        }
    } while choix <= 0 || choix >= max
    return choix
}

func affiche_reserve(j:Jeu) {
    var i = 1
    var reserveIterator = j.makeItReserve()
    while let piece = reserveIterator.next() {
        print(i, terminator:" | ")
        i += 1
        printPiece(p:piece)
        print()
    }
}

func choix_piece_reserve(j:inout Jeu, choix:Int) -> Piece {
    var reserveIterator = j.makeItReserve()
    var k = 0
    while k != choix {
        k += 1
        do {
            if let piece_joueur = reserveIterator.next(){
            try j.choisirPiece(piece:piece_joueur)
            return piece_joueur
            }
        } catch {
            fatalError("erreur")
        }
    }
    return reserveIterator.next()!
}

func choix(j:inout Jeu) -> Piece {
    //affiche_reserve(j:j)
    // saisie de l'utilisateur
    print("> choisissez la pièce de votre adversaire parmis les pièces disponibles :")
    let choix_joueur = saisieInt(max:j.nbPieceReserve+1) //+1 car le compteur commence à 1 dans affiche_reserve()
    // choix valide, on enleve la piece de la reserve et on recupère la piece choisie
    let piece_choisie = choix_piece_reserve(j:&j, choix:choix_joueur)
    return piece_choisie
}

func printPlateau(jeu:Jeu, victoire:Bool) {

    /*
        |------|------|------|------|
        |  01  |  02  |  03  |  04  |
        |------|------|------|------|
     01 | BRVG | BRVG | BRVG | BRVG |
        |------|------|------|------|
     02 | BRVG | BRVG | BRVG | BRVG |
        |------|------|------|------|
     03 | BRVG | BRVG | BRVG | BRVG |
        |------|------|------|------|
     04 | BRVG | BRVG | BRVG | BRVG |
        |------|------|------|------|
    */
    var positionIterator = jeu.makeIterator()
    print("\n")
    printPattern(start:"   ", pattern:"|--------")
    // print des numeros de colonnes
    print("   ", terminator:"")
    for c in 1...4 {
        print("|   0\(c)   ", terminator:"")
    }
    print("|")
    // fin print numeros colonnes
    // print de chaque ligne
    for i in 1...4 {
        // lignes séparatrice
        printPattern(start:"   ", pattern:"|--------")
        // print des numero de ligne
        print("0\(i) ", terminator:"")
        // print des 4 positions par ligne
        for k in 1...4 {
            let position = positionIterator.next()
            print("| ", terminator:"")
            // s'il y a une piece on print ses caracteristiques
            if !victoire /*|| position!.estGagnant*/ { // s'il y a victoire, on affiche uniquement les positions gagnantes. 
                if let piece = position!.getPiece() {
                    printPiece(p:piece)
                }
                // sinon on print la position de la case pour le joueur
                else {
                    print("(\(i), \(k))", terminator:"")
                }
            }
            else {
                print("      ", terminator:"")
            }
            print(" ", terminator:"")
        }
        print("|")
    }
    // ligne de cloture
    printPattern(start:"   ", pattern:"|--------")
}

// print un motif de la manière suivante : "startPatternPatternPatternPattern|"
func printPattern(start:String, pattern:String) {
    print(start, terminator:"")
    for _ in 1...4 {
        print(pattern, terminator:"")
    }
    print("|")
}

func getPos(x:Int, y:Int) -> Position {
    if let pos = jeu.getPosition(x:x, y:y) {
        if !pos.estOccupee {
            // pos est assurée d'être de type Position et la position n'est pas occupée
            return pos
        }
    }
    else{
        let x1 = saisieInt(max:5) // max exclu
        let y1 = saisieInt(max:5) // max exclu
        return getPos(x:x1, y:y1) // getPos est forcement du type Position donc on s'assure de retourner le bon type
    }
    return jeu.getPosition(x:0,y:0)!
}

func choixDifficulte() -> Bool {
    print("Voulez vous jouer dans le mode de jeu difficile ? (victoire possible si 4 pièces ont une caracteritique commune sur un carré de 2x2)")
    print("(oui/non) : ", terminator:"")
    var modeDifficile = false
    var valide = false
    while !valide {
        if let typed = readLine() {
            modeDifficile = (typed == "oui")
            valide = true
        }
    }
    print("Mode de difficulté choisi : ", terminator:"")
    print(modeDifficile ? "Difficile" : "Normal")
    return modeDifficile
}


/*
---------- MAIN ----------
*/
var modeDifficile = choixDifficulte()
var jeu = Jeu.init(modeDifficile:modeDifficile)
var victoire = false
var joueur = 1
// premier tour, le premier joueur ne fait que choisir une pièce
print("Joueur \(joueur) c'est à vous de jouer : ")

while !victoire && jeu.nbPiecePlateau < 16 {
    // choix de la pièce pour l'autre joueur
    let pieceJoueur = choix(j:&jeu)
    // changement de joueur
    if joueur == 1 { joueur = 2}
    else { joueur = 1}
    print("Joueur \(joueur) c'est à vous de jouer : ")
    print("Votre adversaire a choisi la piece suivante : ", terminator:"")
    // affichage de la pièce choisie 
    printPiece(p:pieceJoueur)
    // affichage du plateau
    printPlateau(jeu:jeu,victoire:victoire)
    print("Choisissez une case où placer votre pièce :")
    print("Choix de la ligne : ", terminator:"")
    let y = saisieInt(max:5) // max exclu
    print("Choix de la colonne : ", terminator:"")
    let x = saisieInt(max:5) // max exclu
    // recuperation de la position choisie par le joueur
    var posJoueur = getPos(x:x, y:y)
    print("posJoueur =",posJoueur)
    jeu.placerPiece(pos:&posJoueur, piece:pieceJoueur)
    print("posJoueur =",posJoueur)
    //victoire = jeu.estGagnant(pos:posJoueur)

}
if victoire {
    print("Joueur \(joueur) A GAGNÉ !")
}else {
    print("ÉGALITÉ !")
}
printPlateau(jeu:jeu,victoire:victoire)

