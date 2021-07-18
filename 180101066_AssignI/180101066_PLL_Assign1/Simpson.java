
/*
Name: Ritik Mandloi
Roll No. : 180101066

Instructions for Execution :
    javac Simpson.java
    java Simpson <No_of_Threads> <No_of_Points>

    Eg: javac Simpson.java
        java Simpson 4 1000001
*/

import java.util.*;

public class Simpson{

    //Number of Threads
    private static int nThreads=1;
    
    //Number of Points
    private static int nPoints=1000001;

    //Approximate value of the integral
    private static double SimpsonValue = 0.00;

    //lock for synchronization
    private static final Object lock = new Object();

    //Extended thread class
    class NewThread extends Thread{
        int pointsAllotted;                 //points allotted to each thread
        int pointsIndex;                    //Index of the starting point, considering index of point x=-1 as 0
        int threadId;                       //Id for each thread
        double DeltaX;                      //Length of the interval between two consecutive points

        //The constructor
        public NewThread(int pointsAllotted, int pointsIndex, double DeltaX, int threadId){
            this.pointsIndex = pointsIndex;
            this.pointsAllotted = pointsAllotted;
            this.DeltaX = DeltaX;
	        this.threadId = threadId;
        }

        //The run function
        public void run(){
            //System.out.print("Currently Running Thread : "+threadId+"\n");
            for( int i=0 ; i < pointsAllotted ; i++){

                //lock for synchronization in updating the shared variable 'SimpsonValue'
                synchronized(lock){

                    //SimpsonValue = (DeltaX/3)*[1*f(x1)+4*f(x2)+2*f(x3)+4*f(x4)+2*f(x5)+..........+1*f(xn)]

                    double x = -1.0+1.0*(pointsIndex+i)*DeltaX;                 //calculating x coordinate with help of the pointIndex and DeltaX
                    double value = Calculate(x);                                //function value at x
                    int coeff = SimpsonCoefficient(pointsIndex+i,nPoints);      //coefficient for the current x coordinate
                    double finalValue = (double)coeff*(double)value;            //product of coeff & function value
                    SimpsonValue+=((double) DeltaX/3.0)*(double)finalValue;     //product with the outer coefficient 'deltaX/3'
                }
            }
        }
    }
    
    public void RunThreads(int pointsPerThread, int pointsForLastThread, int nThreads,   double DeltaX)
    throws InterruptedException{

        NewThread[] THREAD = new NewThread[nThreads];                                               //Creating <nThread> number of threads

        for(int i=0;i<nThreads-1;i++){
            int pointsIndex = i*pointsPerThread;                                                    //Calculating PointIndex of starting point
            THREAD[i] = new NewThread(pointsPerThread, pointsIndex, DeltaX, i+1);                   //Initializing the values of the fields
        }
        int pointsIndex = (nThreads-1)*pointsPerThread;                                             //Calculating PointIndex of starting point for last thread
        THREAD[nThreads-1] = new NewThread(pointsForLastThread, pointsIndex, DeltaX, nThreads);     //Initialization for last thread

        for(int i=0;i<nThreads;i++){                            //starting all the threads for execution
            THREAD[i].start();
        }

        for(int i=0;i<nThreads;i++){                            //join() used for synchronization
            THREAD[i].join();
        }
    }

    //function to calculate the Coefficient of the Simpson's Sequence [1,4,2,4,2,4,2,4,2.....4,1]
    public static int SimpsonCoefficient(int index, int nPoints){         
        if(index==0||index==nPoints-1)return 1;     //if end points , return 1
        else return 2*(index%2+1);                  //else return 4 on odd indexes and 2 on even indexes.
    }
    
    //Function to Calculate the value of the function at given x coordinate
    public double Calculate(double x){
        double value = (double)Math.pow(Math.E, -(x*x)/2.0)/(double)Math.sqrt(2*Math.PI);
        return value;
    }

    public static void main(String []args)throws InterruptedException{
        int nArgs=args.length;
        if(nArgs==2){                                       //If number of arguments is 2
            nThreads = Integer.parseInt(args[0]);
            nPoints = Integer.parseInt(args[1]);
            if(nThreads<4 || nThreads>16){                  //If threads not in the range 4 to 16
                System.out.print("Invalid usage!\nNo. of threads should be in the range 4 to 16\n");
                return ;
            }else if(nPoints<=1000000){                      //If points <= 1000000
                System.out.print("Invalid usage!\nNo. of points should be greater than 10^6\n");
                return ;
            }
        }
        else{
            System.out.print("Invalid usage!\nTry the command:: java Simpson <nThreads> <nPoints>\nExample :: java Simpson 4 1000001\n");
            return;
        }

        //Calculating the number of points to be alloted to each thread
        int pointsPerThread=nPoints/nThreads;

        //If not exactly divisible, give the remainder number of points to last thread
        int pointsForLastThread=nPoints-(nThreads-1)*pointsPerThread;

        //Calculating the distance between two consecutive points. deltaX=(b-a)/(n-1) considering n points => n-1 intervals.
        double DeltaX=(double)(1-(-1))/(double)(nPoints-1);


        Simpson SimpsonObj = new Simpson();
        SimpsonObj.RunThreads(pointsPerThread, pointsForLastThread, nThreads, DeltaX);                  //performing multithreading
        System.out.println("Approximate Value of the Integral using "+nThreads+" Threads and "+nPoints+" Points = "+SimpsonValue);

        //Done.
    }
}
