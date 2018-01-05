using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SortingAndSearching
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] welcomeScreen =
            {
                @"                                                                              ",
                @"  _____                     _                       _    _____            _   ",
                @" / ____|                   | |                     | |  / ____|          | |  ",
                @"| (___   ___  __ _ _ __ ___| |__     __ _ _ __   __| | | (___   ___  _ __| |_ ",
                @" \___ \ / _ \/ _` | '__/ __| '_ \   / _` | '_ \ / _` |  \___ \ / _ \| '__| __|",
                @" ____) |  __/ (_| | | | (__| | | | | (_| | | | | (_| |  ____) | (_) | |  | |_ ",
                @"|_____/ \___|\__,_|_|  \___|_| |_|  \__,_|_| |_|\__,_| |_____/ \___/|_|   \__|",
                @"                                                                                "
            };

            for (int i = 0; i < welcomeScreen.Length; i++)
            {
                Console.WriteLine(welcomeScreen[i]);
            }

            newAnalysis();

        }


        public static void newAnalysis()
        {
            Console.WriteLine("---- What would you like to do? ----\n1: Sort and analyse a single array\n2: Search for a value in the data\n------------------------------------");
            try
            {
                int sortOrSearchSelection = Convert.ToInt32(Console.ReadLine());

                switch (sortOrSearchSelection)
                {
                    case 1:
                        Console.WriteLine("Please select what data you would like to analyse! [0-10]");
                        Console.WriteLine("0. Day\n1. Depth\n2. IRIS_ID\n3. Latitude\n4. Longitude\n5. Magnitude\n6. Month\n7. Region\n8. Time\n9. Timestamp \n10. Year");

                        string fileLocation = "../../txt_files/";

                        try
                        {
                            int userChoiceOfArray = Convert.ToInt32(Console.ReadLine());

                            switch (userChoiceOfArray)
                            {
                                case 0:
                                    analyseArray(fileLocation + "Day_1.txt");
                                    break;
                                case 1:
                                    analyseArray(fileLocation + "Depth_1.txt");
                                    break;
                                case 2:
                                    analyseArray(fileLocation + "IRIS_ID_1.txt");
                                    break;
                                case 3:
                                    analyseArray(fileLocation + "Latitude_1.txt");
                                    break;
                                case 4:
                                    analyseArray(fileLocation + "Longitude_1.txt");
                                    break;
                                case 5:
                                    analyseArray(fileLocation + "Magnitude_1.txt");
                                    break;
                                case 6:
                                    analyseArray(fileLocation + "Month_1.txt");
                                    //MONTH TO INT AND REMOVE WHITESPACE WITH TRIM
                                    break;
                                case 7:
                                    analyseArray(fileLocation + "Region_1.txt");
                                    break;
                                case 8:
                                    analyseArray(fileLocation + "Time_1.txt");
                                    break;
                                case 9:
                                    analyseArray(fileLocation + "Timestamp_1.txt");
                                    break;
                                case 10:
                                    analyseArray(fileLocation + "Year_1.txt");
                                    break;
                                default:
                                    Console.WriteLine("Please choose a correct value!");
                                    newAnalysis();
                                    break;
                            }
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine("Please choose a correct value!\nError Code: {0}", e.Message);
                            newAnalysis();
                        }

                        break;
                    case 2:
                        searchData();
                        break;
                    default:
                        Console.WriteLine("Please choose a correct value!");
                        newAnalysis();
                        break;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Please choose a correct value!\nError Code: {0}", e.Message);
                newAnalysis();
            }
            Console.ReadLine();

        }

        //Take in chosen array and analyse (Sort)
        public static void analyseArray(string location)
        {

            string[] stringToSort = File.ReadAllLines(location);
            //int[] Day1_Array_Sorted = Array.ConvertAll(Day1_Array, int.Parse);

            
            //Console.WriteLine("\n-- Unsorted --\n");
            //for (int i = 0; i < /* Day1_Array_Sorted.Length */ 50; i++)
            //{
            //    Console.Write(" {0}, ", /*Day1_Array_Sorted*/ stringToSort[i]);
            //}
            

            QuicksortData(stringToSort, 0, stringToSort.Length - 1);

            bool ascOrDescLoop = false;
            Console.WriteLine("How would you like your array formatted?\n1. Ascending\n2. Descending");

            while (!ascOrDescLoop)
            {

                try
                {

                    int ascOrDesc = Convert.ToInt32(Console.ReadLine());
                    //Console.WriteLine(ascOrDesc);
                    if (ascOrDesc == 1)
                    {
                        for (int i = 0; i < /*Day1_Array_Sorted.Length*/ 50; i++)
                        {
                            Console.Write(" {0}, ", stringToSort[i]);
                        }
                        ascOrDescLoop = true;
                    }
                    else if (ascOrDesc == 2)
                    {
                        Array.Reverse(stringToSort);
                        for (int i = 0; i < /*Day1_Array_Sorted.Length*/ 50; i++)
                        {
                            Console.Write(" {0}, ", stringToSort[i]);
                        }
                        ascOrDescLoop = true;
                    }
                    else
                    {
                        Console.WriteLine("Unexpected input detected. Please try again!");
                    }

                }
                catch (Exception e)
                {
                    Console.WriteLine("Unexpected input detected. Please try again!");
                }

            }

            Console.WriteLine("\n\nWould you like to perform another action? Please enter 'Y' to do so, otherwise the program will exit.");

            try
            {
                char continueOrNot = Convert.ToChar(Console.ReadLine());
                if(continueOrNot == 'Y' || continueOrNot == 'y')
                {
                    newAnalysis();
                }
                else
                {
                    Console.WriteLine("Press any key to exit...");
                }
            }
            catch(Exception e)
            {
                Console.WriteLine("Press any key to exit...");
            }

            //Console.WriteLine("\n-- Sorted --\n");

            //for (int i = 0; i < /*Day1_Array_Sorted.Length*/ 50; i++)
            //{
            //    Console.Write(" {0}, ", stringToSort[i]);
            //}
            //Console.ReadLine();

        }

        //Search all Data in Array
        public static void searchData()
        {

        }

        //Quicksort Function for Arrays
        public static void QuicksortData(IComparable[] elements, int left, int right)
        {
            int i = left, j = right;
            IComparable pivot = elements[(left + right) / 2];

            while (i <= j)
            {
                while (elements[i].CompareTo(pivot) < 0)
                {
                    i++;
                }

                while (elements[j].CompareTo(pivot) > 0)
                {
                    j--;
                }

                if (i <= j)
                {
                    // Swap
                    IComparable tmp = elements[i];
                    elements[i] = elements[j];
                    elements[j] = tmp;

                    i++;
                    j--;
                }
            }

            // Recursive calls
            if (left < j)
            {
                QuicksortData(elements, left, j);
            }

            if (i < right)
            {
                QuicksortData(elements, i, right);
            }
        }

        //Binary Search for Sorted Arrays
        public static object BinarySearchRecursive(int[] inputArray, int key, int min, int max)
        {
            if (min > max)
            {
                return "Nil";
            }
            else
            {
                int mid = (min + max) / 2;
                if (key == inputArray[mid])
                {
                    return ++mid;
                }
                else if (key < inputArray[mid])
                {
                    return BinarySearchRecursive(inputArray, key, min, mid - 1);
                }
                else
                {
                    return BinarySearchRecursive(inputArray, key, mid + 1, max);
                }
            }
        }
    }
}
