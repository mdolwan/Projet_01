//
//  Game.swift
//  Last New Version
//
//  Created by Mohammad Olwan on 18/07/2021.
//

import Foundation

public class Game {
   
    public var namesReserved = ["Viking", "Batman", "Spiderman", "Superman"] // Un tableau pour ne pas répéter les noms qui sont déjà choisis.

    var attackerAttacked : [Soldier] = [] // Ce tableau nous aide pour choisir le premier attaquer, et le attaqué perssonage
    
    var team1Available: [Soldier] = [] // Tableau contient les perssonages qui ont des points de vie supérieur à 0 pour la Team 1
    var team2Available: [Soldier] = [] // Tableau contient les perssonages qui ont des points de vie supérieur à 0 pour la Team 2
    
    var players: [Player] = [] // Player c'est le commandeur
    
    var round = 1 // Nombre de rounds
    var teamRound = 1 // Cette variable indique à team qui va commencer le round (1 pour team1, 2 pour team2)
    
    public func start(){
        initializedPlayers()
    }

    // Cette Méthode pour initialiser tout le joueur et les personnages.
    private func initializedPlayers(){
        print("Bonjour tous les mondes, Vous êtes les Bienvenues à le scene de la guerre mondiale 3.")
        print("-------------------------------------------------------------------------------------\n")
        
        for i in 1...2 {
            let player = Player()
            print("Bonjour joueur \(i), écrivez votre nom:")
            player.name = initPlayer()
            
            print("Maintenant, veuillez choisir votre équipe....\n")
            
            let position = ["premier", "deuxième", "troisième"]
            
            var team: [Soldier] = []
            
            for J in 0...2 {
                print("Sélectionnez votre \(position[J]) personnage")
                let character = getSoldier()
                team.append(character)
                if i == 1{
                    team1Available.append(character)
                } else{
                    team2Available.append(character)
                }
            }
            player.team = team
            players.append(player)
        }
        print ("La guerre peut commencer dés maintenant, Voici Les deux équipes :\n\n")
        showTeams()
        startWar()
    }
    
    // En cette méthode, on supprime des soldats qui ont des pointes de vie inférieures de 0.
    private func setAvailableArray(){
        for i in  (0...team1Available.count-1).reversed(){
            if (team1Available[i].pointLife == 0){
                team1Available.remove(at: i)
            }
        }
        for i in  (0...team2Available.count-1).reversed(){
            if (team2Available[i].pointLife == 0){
                team2Available.remove(at: i)
            }
        }
    }
    
    private func startWar(){
        
        while testThewinner(){
            
            if (teamRound == 1){
            startRound(playerAttacking: players[0], teamAttacking: team1Available ,playerAttacked: players[1], teamAttacked: team2Available)
            }
            else{
            startRound(playerAttacking: players[1], teamAttacking: team2Available, playerAttacked: players[0], teamAttacked: team1Available)
            }
        }
        showTeams()
        print (" -------------------------------\n | C'est la fin de cette guerre |\n -------------------------------\n\n")
   } // fin de sartWar
}
// MARK: - Convenience Methods

extension Game {
    // Cette méthode pour choisir un nom pour les joueurs
    public func initPlayer() -> String{

        getName()
        return namesReserved.last!
    }
    // Cette méthode pour choisir un personnage et un nom.
    private func getSoldier() -> Soldier{
        
        let sString = ["1","2","3","4"] // les choix disponible, qui montré en haut ^
        
        showSoldiers()
        var firstCharacter = readLine()!
        
        if !(sString.contains(firstCharacter)){
            repeat
            {
                print("Vous n'avez pas choisi un bon choix, choissesez un autre, s'il vous plaît : ")
                firstCharacter = readLine()!
            } while(!sString.contains(firstCharacter))
        }
        
        var soldier = Soldier()
        
        if (firstCharacter == "1"){
            soldier = Batman()
        }
        else if (firstCharacter == "2"){
            soldier = Spiderman()
        }
        else if(firstCharacter == "3"){
            soldier = Superman()
        }
        else{
            soldier = Viking()
        }
        print("Vous avez choisi \(soldier.type), veuillez écrire votre nom, s'il vous plaît : ")
        
        getName()
        soldier.name = namesReserved.last!
        return soldier
    }
    // Cette méthode montre tous les personnages avant de commencer la guerre.
    private func showTeams(){
        let position = ["première", "deuxième"]
        
        for (index, player) in players.enumerated(){
            print("Les personnages de la \(position[index]) équipe de \(player.name)....:\n")
            for (index, soldier) in player.team.enumerated(){
                print("\(index + 1). \(soldier.type) s'appelle \(soldier.name), a comme arme une \(soldier.weapon.name), sa puissance est de \(soldier.weapon.weaponPower), il a \(soldier.pointLife) points de vie.")
            }
            print("--------------------------------------------------------------------------------------\n")
        }
    }
    // Cette méthode montre tout le personnage disponible.
    private func showSoldiers(){
        let soldiers = [Batman(), Spiderman(), Superman(), Viking()]
        
        for (index, soldier) in soldiers.enumerated(){
            print("\(index + 1). \(soldier.type), qui a \(soldier.weapon.name), et a \(soldier.pointLife) Points de vie, et peut faire \(soldier.weapon.weaponPower) de dégâts")
        }
    }
    
    // Le principe de cette guerre
    public func startRound(playerAttacking: Player,teamAttacking: [Soldier], playerAttacked: Player, teamAttacked: [Soldier]){
        // on libres touts les perssonage de le précédent round
        attackerAttacked.removeAll()
        
        // choisir le premier perssone pour commencer cette round
        let solderSelected = listSolderteam(anyPlayer: playerAttacking, anyTeam: teamAttacking)
        
        // ajouter le premier personnage (l'attaquer)
        attackerAttacked.append(solderSelected)
        
        // ici on peut choisir de changer l'arme ou non.
        chooseArm(solder: attackerAttacked[0])
        
        // Ici, on peut choisir soit ajouter point de vie en plus où soit faire attaquer.
        let position1 = ["1","2"]
        print("\(attackerAttacked[0].name), que souhaitez-vous faire?\n 1- Soignez vous-même \(attackerAttacked[0].name).\n 2- Attaquer l'ennemi équipe (\(playerAttacked.name)).")

            var yourOption1 = readLine()
            if(!position1.contains(yourOption1!)){
                repeat{
                    print("Vous n'avez pas choisi un bon choix, Veuillez choisir un autre choix :")
                    yourOption1 = readLine()
                }while !position1.contains(yourOption1!)
            }
            if(yourOption1 == "1"){
                addPoint()
            }
            else{
                //ici on peut choisir une personnage de l'autre équipe
                let solderSelected = listSolderteam(anyPlayer: playerAttacked, anyTeam: teamAttacked)
                attackerAttacked.append(solderSelected)  // ajouter le deuxième personnage
                performAttack() // Commence l'attaquer
            }
       setAvailableArray() // Pour assurer que les personnages ont points de vie supérieure de zéro.
  }
    
    // pour vérifier c'est qui gagne, ou pour countinuer à nouvelle round
    private func testThewinner()-> Bool{
        var test = true
        if team1Available.count == 0{
 
            print("L'équipe de \(players[1].name) gagne, et l'équipe de \(players[0].name) perd.")
            test = false
        }
        else if team2Available.count == 0{
     
            print("L'équipe de \(players[0].name) gagne, et l'équipe de \(players[1].name) perd.")
            test = false
        }
        if !test{
            print("\nCette guerre a pris \(round - 1) rounds pour terminer.\n\n\n")
        }
         return test
    }
    // ce méthode utilisé pour montrer l'équipe à choisir une personne qui va participer à actuelle round
    private func listSolderteam(anyPlayer: Player ,anyTeam : [Soldier])-> Soldier
    {
        print("\n\(anyPlayer.name), Veuillez choisir votre personnage pour commencer ce round :\n")
        
        var position : [String] = []
        for index in 0 ..< anyTeam.count{
                print("\(index+1)- \(anyTeam[index].name),il est \(anyTeam[index].type) et a \(anyTeam[index].weapon.name) comme arme, qui peut faire \(anyTeam[index].weapon.weaponPower) dégât, et a \(anyTeam[index].pointLife) point de vie.")
                position.append(String(index+1))
            }

        var myOption = readLine()
        if(!position.contains(myOption!)){
            repeat{
                print("Vous n'avez pas choisi un bon choix, Veuillez choisir un autre:")
                myOption = readLine()
            }while(!position.contains(myOption!))
        }
        let s = anyTeam[Int(myOption!)!-1]
        return s
    }
    
    // cette méthode pour choisir une vnouvelle arme
    private func chooseArm(solder: Soldier){
        let position1 = ["1","2"]
        print("Un coffret apparaît devant vous (\(solder.name)), voulez-vous changer votre arme?\n 1- Oui. \n 2- Non.")
                var yourOption = readLine()
                if(!position1.contains(yourOption!)){
                    repeat{
                        print("Vous n'avez pas choisi un bon choix, Veuillez choisir un autre choix :")
                        yourOption = readLine()
                    } while (!position1.contains(yourOption!))
                }
                    if(yourOption == "1"){
                        
                        if(solder.weapon.weaponPower == 5000){
                            print("\(attackerAttacked[0].name), Vous avez l'arme la plus puissante.\n")
                            return
                            
                        } else if (solder.weapon.weaponPower == 2500) {
                            solder.weapon = Glaive()
                            
                        } else if (solder.weapon.weaponPower == 500) {
                            let weapons = [Glaive(), Sabre()]
                            let selectedWeapon = weapons.randomElement()
                            solder.weapon = selectedWeapon!
                            
                        } else {
                            let weapons = [Glaive(), Sabre(), Axe()]
                            let selectedWeapon = weapons.randomElement()!
                            solder.weapon = selectedWeapon
                            
                        }
                        print("\(solder.name), a désormais \(solder.weapon.name), qui peut faire \(solder.weapon.weaponPower) dégâts.\n")
                    }
    }
    
    // Cette méthode pour ajuter de pointe de vie en plus.
    private func addPoint(){
        
        attackerAttacked[0].heal()
        
        print("\(attackerAttacked[0].name) a reçoit 50 points de vie, et maintenant \(attackerAttacked[0].name) a \(attackerAttacked[0].pointLife) comme points de vie.\n")
        
        endRound()
    }
    
    // Cette méthode pour faire attaquer
    private func performAttack(){
        
        attackerAttacked[0].attack(soldier: attackerAttacked[1]) // L'attaque effectué
        
        // Ici, on modifie le valeur de point de vie, alors que le valeur moins de 0, on le fait 0.
        if(attackerAttacked[1].pointLife<0){
            
             attackerAttacked[1].pointLife = 0
        }
        
        print("\(attackerAttacked[1].name) a désormais \(attackerAttacked[1].pointLife) de point de vie.\n")
        endRound()
    }
    
    // La fin de l'actuel round
    private func endRound(){
        
        print("La Fin de round \(round).\n________________________________________________________________")
        round += 1
        teamRound = (teamRound == 1) ? 2 : 1 // Pour basculer entre l'attacker et l'attacked
    }
    
    // Cette méthode pour choisir une nouvelle nom
    private func getName(){
        var yourName = readLine()
        
                if (namesReserved.contains(yourName!) == true){
                    
                        repeat {
                            
                            print("Vous avez déjà choisi ce nom, saisir un autre nom, s'il vous plaît : ")
                            yourName = readLine()
                    } while (namesReserved.contains(yourName!) == true)
                }
                else if (yourName!.trimmingCharacters(in: .whitespaces).count == 0){
                    
                        repeat {
                            
                            print("Vous avez choisi un vide nom, saisir un autre nom, s'il vous plaît : ")
                            yourName = readLine()
                    } while (yourName!.trimmingCharacters(in: .whitespaces).count == 0)
                }
        
                namesReserved.append(yourName!.trimmingCharacters(in: .whitespaces))
                print("Bienvenue \(namesReserved.last!) !\n")
    }
  }
