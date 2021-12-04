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

}

// Affiche le score et éventuellement qui gagne
func displayScore(jeu : Board){
    // Affiche le score    
}


func main(){
    newGame()
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