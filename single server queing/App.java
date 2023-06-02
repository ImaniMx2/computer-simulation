import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

public class App {
    public static void main(String[] args) throws Exception {

      // Declare fixed variables
       double m = (2^31)-1;  //set modulos
       double a = 48271; //set multplier
       double totalTime = 0; //hold summation of all interarival times 
       double TotalSrviceTime = 0; //hold summation of all service times 
       double averageInterarrival; //hold average of all interarival times 
       double averageServiceTime; //hold average of all service times 
       double averageArrival; //hold average arrival rate
       double averageService;//hold average service rate
      // randome number generator inital  vuales 

       double xArivalSeed = 3 ; 
       double xServiceSeed = 11; 
      
       //retrive user input 
        int numberCustomers = getInteger("Enter the number of customer:"); //ask for number of customers n
        double arrivalMean = getDouble("Enter the mean interarrival times:");// #ask for interarrival times
        double serviceMean = getDouble("Enter the mean service times:");// #ask for number of customers n
       
        //generate interarrival times and service time for n customers exponential
         
        double[] intArrival = getSequence(xArivalSeed, arrivalMean, a,m, numberCustomers);
        double[] serviceTime = getSequence(xServiceSeed, serviceMean, a,m, numberCustomers);
        
        //caluculate 
        for(int k=0;k<numberCustomers;k++)
        {
            // System.out.println(intArrival[k] + " " + serviceTime[k]);
            totalTime += intArrival[k];
            TotalSrviceTime += serviceTime[k];


        }
       // System.out.println("Total arrival:" +totalTime);
       // System.out.println("Total service:" +TotalSrviceTime);

        //calculate  average of all interarival and service times 
        averageInterarrival= totalTime/numberCustomers;
        averageServiceTime =TotalSrviceTime/numberCustomers;
          
        //System.out.println("avg inter arrival:" +averageInterarrival);
        // System.out.println("avg service:" +averageServiceTime);

        //calculate  𝜇 is the average service rate and 𝜆 is the average arrival rate

        averageArrival = 1/averageInterarrival;
        averageService = 1/averageServiceTime;

        System.out.println("average arrival rate 𝜆:" +averageArrival );
        System.out.println("average service rate 𝜇:" +averageService);


        //generate the expected server utilization, i.e., ρˆ = λ/(cμ) c=1
        double utilizaiton = averageArrival/averageService;
   
        //generate time-average number of customer in que LˆQ =λWq; ρ^2/(1−ρ)

        double averageNumCust = (utilizaiton*utilizaiton)/(1-utilizaiton);

       // generate the expected average delay in queue per customer, i.e., wˆQ, = Lq/λ

       double wQ = averageNumCust/averageArrival;
       
        
        
        
        
         System.out.println("Expected average delay:"+ wQ );
         System.out.println("Time-average number of customer:"+ averageNumCust);
         System.out.println("Expected server utilization:"+ utilizaiton);



    }
    
    public static double[] getSequence(double X,double mean,double a, double m, int i)
    {
        double[]ans = new double[i];

        double Xi ;
        double Xz = X;
        for(int k = 0; k < i;k++)
        {
            Xi = ((a*Xz)%m)/m;
            ans[k]= roundOFF(- mean* Math.log(1- Xi),3); 
            Xz = Xi;
        }

        return ans;

    }

    static double roundOFF(double value, int decimalpoint)
    {
  
       
        value = value * Math.pow(10, decimalpoint);
        value = Math.floor(value);
        value = value / Math.pow(10, decimalpoint);
  
       
  
        return value;
    }
    public static double expVar( double mean,double randomVar)
    {
        //return - 1/mean * Math.log( 1 - (randomVar));
        Double lambda = 1/mean;
       return Math.log(1- randomVar)*1/(-lambda);
    }

    public static double getDouble(String prompt)
    {
        Scanner input = new Scanner(System.in);
        double number = -1;
        System.out.println("\n"+prompt);
    
        while(number < 0){
            try{
                

                number = input.nextDouble();
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
    public static double getX(double X,double a,double m)
    {
        return (a*X)%m;

    }
   
public static double getR(double Xi,int i)
    {
        return Xi/i;

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
}
