import Foundation



func entry(numberMax:Int) -> Int{
    var number = -1
    repeat {
        if let input = readLine() {
            if let tmp = Int(input) {
                number = tmp
            }
        }
    } while number < 0 || number > limit
    return number
}

func entry(valueMax: Int) -> Int{
    var number = 0
    repeat {
        if let input = readLine() {
            if let tmp = Int(input) {
                number = tmp
            }
        }
    } while number <= 0 || number > limit
    return number
}


// initilalise une nouvelle partie
func newGame() {
    // 
    print("choisissez votre mode de jeu\n")
    var n = entry(limit :1)
    // créer la partie avec le plateau rempli aléatoirement de Marbles
    var game = Board.init(mode : n)
    print("la partie commence\n")
}

// Affiche l'interface du jeu à chaque tour
func displayGame(jeu : Board) {
    /*  ce à quoi s'est censé ressembler 
       |   X0  |   X1  |   X2  |   X3  |   X4  |   X5  |   X6  |   X7  |\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y0 |       |\(X1Y0)|\(X2Y0)|\(X3Y0)|\(X4Y0)|\(X5Y0)|\(X6Y0)|       |\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y1 |\(X0Y1)|\(X1Y1)|\(X2Y1)|\(X3Y1)|\(X4Y1)|\(X5Y1)|\(X6Y1)|\(X7Y1)|\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y2 |\(X0Y2)|\(X1Y2)|\(X2Y2)|\(X3Y2)|\(X4Y2)|\(X5Y2)|\(X6Y2)|\(X7Y2)|\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y3 |\(X0Y3)|\(X1Y3)|\(X2Y3)|\(X3Y3)|\(X4Y3)|\(X5Y3)|\(X6Y3)|\(X7Y3)|\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y4 |\(X0Y4)|\(X1Y4)|\(X2Y4)|\(X3Y4)|\(X4Y4)|\(X5Y4)|\(X6Y4)|\(X7Y4)|\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y5 |\(X0Y5)|\(X1Y5)|\(X2Y5)|\(X3Y5)|\(X4Y5)|\(X5Y5)|\(X6Y5)|\(X7Y5)|\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y6 |\(X0Y6)|\(X1Y6)|\(X2Y6)|\(X3Y6)|\(X4Y6)|\(X5Y6)|\(X6Y6)|\(X7Y6)|\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y7 |       |\(X1Y7)|\(X2Y7)|\(X3Y7)|\(X4Y7)|\(X5Y7)|\(X6Y7)|       |\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    */  
    var displayString : String = 
    "   
       |   X0  |   X1  |   X2  |   X3  |   X4  |   X5  |   X6  |   X7  |\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    Y0 |       |\n
       |-------|-------|-------|-------|-------|-------|-------|-------|\n
    
    "
    var posIt = jeu.positionIterator()
    // Y0
    var currentLigne : Int = 0
    // on commence par afficher X1Y0 puis X2Y0 etc...
    // Ensuite on affiche X0Y1 puis X1Y1 etc...
    // "B" => bille blanche
    // "N" => bille noire
    while let posIt = posIt.next() {
        if currentLigne != postIt.positions[1] {
            currentLigne = postIt.position[1]
            if currentLigne == 7 {
                displayString = displayString + "Y7 |       |"
            }
            else if currentLigne != 0 {
                displayString = displayString + "\n   |-------|-------|-------|-------|-------|-------|-------|-------|\nY\(currentLigne) |"
            }
        }
        if let posIt.contains = Marble {
            if posIt.contains.estBlanc {
                displayString = displayString + "   B   |"
            }
            else{
                displayString = displayString + "   N   |"
            }
        }
        else{
            displayString = displayString + "       |"
        }
    }
    print(displayString)
}

// Affiche le score et éventuellement qui gagne
func displayScore(jeu : Board){
    // Affiche le score
    print("Fin de la partie!\n")
    var scoreP1 = jeu.score(true)
    var scoreP2 = jeu.score(false)
    if scoreP1 > scoreP2 {
        print("Bravo au joueur 1 qui gagne à \(scoreP1) points contre \(scoreP2)!\n")
    }
    else{
        print("Bravo au joueur 2 qui gagne à \(scoreP2) points contre \(scoreP1)!\n")
    }
}


func main(){
    newGame()
    // Si j'ai bien compris, le player 1 a les billes blanches
    var player = 1
    var playerBool : Bool

    while !game.gameOver(){
        displayGame(jeu : game)
        print("Joueur \(player), c'est à vous de jouer !\n")
        if player = 1 {playerBool = true}
        else{ playerBool = false}

        if player == 2 { player = 1}
        else{ player = 2}

        if !game.CanMove(estBlanc : playerBool){
            continue
        }
        print("Choisissez la marble à déplacer :\n")
        print("Choix de la ligne : ")
        var x = entry(numberMax:8) // la limite est incluse
        print("\nChoix de la colonne : ")
        var y = entry(numberMax:8) // la limite est incluse
        let marble: Marble? = game.getMarble(x:x,y:y)
        while let marble == nil || marble.estBlanc =! playerBool || !game.isInBorder(marble :marble){
            print("\nLa Marble n'est pas bonne, veuillez en choisir une autre\n")
            print("Choix de la ligne : ")
            var x = entry(limit:8) // la limite est incluse
            print("\nChoix de la colonne : ")
            var y = entry(limit:8) // la limite est incluse
            let marble: Marble? = game.getMarble(x:x,y:y)
        }
        print("Choisissez de combien de cases vous voulez déplacer cette Marble :")
        let maxValue = game.cellsMovable(marble:marble, direction:marble.initalDirection)
        var value = entry(limit = maxValue)
        game.MoveMarble(marble:marble, value:value,direction: marble.initalDirection)
    }

    displayScore(jeu : game)

}


main()