func isNil(string : String?) -> Bool{
    if let string = string && string != ""{
        return true
    }
    return false
}

// initilalise une nouvelle partie
func newGame() {
    // 
    print("choisissez votre mode de jeu\n")
    n = readLine()
    if !isNil(string :n){
        n = Int(n)
    }else{
        n = 0
    }
    // créer la partie avec le plateau rempli aléatoirement de Marbles
    var game = Board.init(mode : n)
    // création des 2 joueurs 
    // Le joueur dont le numéro est 1 joue en premier
    var player1 = User.init(player : 1)
    var player2 = User.init(player : 2)
    print("la partie commence\n")
}

func display(game : Board) {
    var It = game.BoardIterator()
    for elt in It{
        
        if It.next(){
            print("B")
        }
        else{
            print("N")
        }
            
    }
}

func displayScore(game : Board){
    // Affiche le score    
}

func main(){
    newGame()
    // tant que aucun joueur n'a gagné la partie
    while !game.gameOver(){
        display(game : Board)
        // user est le joueur dont c'est le tour de jeu
        var user = board.TurnOf()
        if game.CanMove(user)){
            // Lire le numéro de la marble qu'on veux déplaçer
            print("entrez le numéro de la Marble choisie\n")
            let input = readLine()
            // verifie que l'input n'est pas nil ou vide
            // On passe à la suite quand il aura mis un input valide
            while isNil(string: input){
                print("numéro invalide, recommencez :\n")
                input = readLine()
            }
            // converti l'entrée en Int 
            input = Int(input)
            // on stocke la Marble choisie
            var currentMarble:Marble? =  user.getMarble(num : input)
            while currentMarble == nil {
                print("entrez le numéro de la Marble choisie\n")
                let input = readLine()
                // verifie que l'input n'est pas nil ou vide
                // On passe à la suite quand il aura mis un input valide
                while isNil(string: input){
                    print("numéro invalide, recommencez :\n")
                    input = readLine()
                }
                // converti l'entrée en Int 
                input = Int(input)
                // on stocke la Marble choisie
                var currentMarble:Marble? =  user.getMarble(num : input)
                
            }
            // on verifie que la marble existe
            if let currentMarble = currentMarble {
                // on vérifie su la Marble deplaçable
                if user.isMovable(marble : currentMarble){
                    // Lire le nombre de cases pour le déplaçement
                    // on set la value à une valeur supérieure à 6 initialement
                    // pour pouvoir rentrer la 1ère fois dans la boucle while 
                    var value = 10
                    // boucle qui permet de véifier si le nombre de cases choisies pour le déplacement est possible
                    while value > user.cellsMovable(marble :currentMarble){
                        // on change de type value et on la lis
                        print("entrez un nombre de déplacement valide :\n")
                        var value = readLine()
                        // On passe à la suite quand il aura mis un input valide
                        while isNil(string : value){
                            print("numéro invalide, recommencez :\n")
                            value = readLine()
                        }
                        // on transforme alors la value en Int
                        value = Int(value)
                    }
                        // on deplace la marble du nombre de cases
                        user.MoveMarble(marble :currentMarble, value :value)
                }
            }
        }
    }
    game.displayScore()
}


main()