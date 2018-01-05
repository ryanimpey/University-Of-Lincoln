using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace ThreeOrMore
{
    //Game Class, controls game.
    class Game
    {
        //Create list to store all players in, allowing the user to define the amount of players
        public List<Player> playerList = new List<Player>();

        //Main method
        static void Main(string[] args)
        {
            //Create new game object to interact with playerlist so that the user is able to add players.
            Game gameObject = new Game();

            //Basic introduction to game
            Console.WriteLine("Welcome to Three or More");

            //Controls while loop. Will stay false until the user inputs a valid amount of players
            bool validPlayerCount = false;

            //While loop to check player has entered a valid number of players
            while (!validPlayerCount)
            {
                //Ask the user how many people are playing
                Console.WriteLine("Please enter how many people will be playing.");
                //Catch any user input errors errors instead of crashing program
                try
                {
                    //Convert user input from string to int
                    int playerAmount = Convert.ToInt32(Console.ReadLine());

                    //Player count hasn't encountered an error and is now able to escape while loop
                    validPlayerCount = true;

                    //Loop to name each player. Incremented by one to read "Player 1" not "Player 0" as the first entry
                    for (int i = 1; i < playerAmount+1; i++)
                    {
                        Console.WriteLine("Please enter Player {0}'s name, using no special characters.", i);
                        //Get user input and name character from it
                        String playerName = Console.ReadLine();
                        //Sanitize name using Regex so that it is suitable for object naming convention. Will remove any characters not a-z or A-Z
                        String sanitizedPlayerName = Regex.Replace(playerName, @"[^a-zA-Z]+", "");

                        //Add named player to the playerList defined earlier with a score set to 0 to begin with.
                        gameObject.playerList.Add(new Player { Name = "Player" + sanitizedPlayerName, Score = 0 });
                    }

                    //Read out the players to the user
                    Console.WriteLine("The players are as followed:");

                    for(int i = 0; i < gameObject.playerList.Count; i++)
                    {
                        Console.WriteLine("-- {0} --", gameObject.playerList[i].Name);
                    }
                    //End of reading out players to user


                }
                //Catch any exceptions that may occur and report them back to the player
                catch (Exception e)
                {
                    Console.WriteLine("Exception, please enter a valid input! \n{0}", e.Message);
                }
            }
            

            //TODO: Remove this area and place it somewhere else
            Dice mainDice = new Dice();
            Console.WriteLine("{0}, {1}, {2}, {3}, {4}", mainDice.DiceRoll(), mainDice.DiceRoll() , mainDice.DiceRoll(), mainDice.DiceRoll(), mainDice.DiceRoll());
            Console.ReadLine();
            //:TODO
        }
    }

    //Dice Class used to generate Dice rolls
    class Dice
    {
        //Private random. Not for public use as it is only declaring the random generator
        private Random randomRoll= new Random();
        //Public method to generate dice roll, from and including 1 to 6
        public int DiceRoll()
        {
            //return dice value as integer
            return randomRoll.Next(1, 7);
        }
    }

    //Player class used to define new players
    class Player
    {
        //Name attribute used to define user
        public String Name;
        //Score attribute used to track users score
        public int Score;
        //RoundCount attribute used to keep track of the amount of turns the player has had
        private int roundCount;
        //Public method to increment roundCount after each turn
        public void incrementRoundCount()
        {
            //Add 1 to roundCount
            roundCount++;
        }
    }


    //Round class used to create a new round, allowing players to take their turns
    class Round
    {
        //Defines a new game object to access playerList
        Game gameObject = new Game();
        
            
            
        /* MAYBE: Put playerlist in better place? */

        //Public method to check players scores at the end of every go.
        public void checkScores()
        {

            //CHANGE THIS SO IT CHECKS PLAYERS SCORE
            for (int i = 0; i < gameObject.playerList.Count; i++)
            {
                if (gameObject.playerList[i].Score >= 50)
                {

                    endGame(gameObject.playerList[i].Name, gameObject.playerList[i].Score);

                }
            }
            //remove this and call at end of newRound
            nextRound();
        }

        //Create new round
        public void nextRound() {

        }

        //End game method to declare a winner
        public void endGame(string Player, int Score)
        {
            Console.WriteLine("-- Game Over! --/n {0} won with {1} points!");
            return;
        }
    }
}
