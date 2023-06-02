//randome number generator 
import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

public class App {
    public static void main(String[] args) throws Exception {
        double x0 = getDouble("Enter the seed(X0):");
        int a = getInteger("Enter the multiplier(a):");
        int c = getInteger("Enter the increment(c):");
        int m = getInteger("Enter the modulous(m):");
        int i= getInteger("Enter the size of the sequence that you want:");
        System.out.println("i\t R");
        printSequence(x0, a,  c, m,  i);






    }

    public double getNext(double lambda) {
        Random rand = new Random();

        return  Math.log(1- (rand.nextDouble()* (1 - 0)) + 0)/(-lambda);}

    public static void printSequence(double X,int a, int c,int m, int i)
    {
        double Xi ;
        double Xo = X;
        for(int k = 1; k <= i;k++)
        {
            Xi = getX(Xo, a, c, m);
            System.out.println(i +"\t"+ getR(Xi,m));
            Xo = Xi;
        }

    }


    public static double getR(double Xi,int i)
    {
        return Xi/i;

    }

    public static double getX(double X,int a, int c,int m)
    {
        return (a*X + c)%m;

    }

    public static int getInteger(String prompt)
    {
        Scanner input = new Scanner(System.in);
        int number = -1;
        System.out.println("\n"+prompt);
    
        while(number < 0){
            try{
                

                number = input.nextInt();
                if(number < 0)
                {
                    System.out.print("ERROR! Should be positive." +prompt );
                    number = -1;

                }
                
            }
            catch (InputMismatchException e)
            {
                System.out.print("Not an integer!Try again!"+prompt);
                input.next();

            }
        }

        //input.close();

        return number;
    }
    public static double getDouble(String prompt)
    {
        Scanner input = new Scanner(System.in);
        int number = -1;
        System.out.println("\n"+prompt);
    
        while(number < 0){
            try{
                

                number = input.nextInt();
                if(number < 0)
                {
                    System.out.print("ERROR! Should be positive." +prompt );
                    number = -1;

                }
                
            }
            catch (InputMismatchException e)
            {
                System.out.print("Not an integer!Try again!"+prompt);
                input.next();

            }
        }

        //input.close();

        return number;
    }

}
