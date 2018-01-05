using System;

public class looping{

  public static void Main(string[] args){

    int widgetQuantity = 0;
      float widgetPrice = 0;

      Console.WriteLine("Price of Widgets:");

      while(widgetQuantity < 101){
      
        if(widgetQuantity <= 50){
          widgetPrice = widgetQuantity*5;
        }

        if(widgetQuantity > 50 && widgetQuantity <= 80){
          widgetPrice = widgetQuantity*4;
        }

        if(widgetQuantity > 80){
          widgetPrice = widgetQuantity*2.5f;
        }

        Console.WriteLine("Quantity: {0}", widgetQuantity);
        Console.WriteLine("Price: {0:c}", widgetPrice);
        widgetQuantity += 10;
      }

    //Console.WriteLine("Please enter how many widgets you would like");
    //Console.WriteLine("If you would like to pause the process, press q");
    //int userInput = Convert.ToInt32(Console.ReadLine());
  }
}