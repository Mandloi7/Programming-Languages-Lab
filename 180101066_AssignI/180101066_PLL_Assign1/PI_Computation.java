
/*
Name: Ritik Mandloi
Roll No. : 180101066

Instructions for Execution :

    javac PI_Computation.java
    java PI_Computation <No_of_Threads>

    Eg: javac PI_Computation.java
        java PI_Computation 4
*/

import java.util.*;
import java.util.Random;

public class PI_Computation{
    //Number of Threads
    private static int nThreads=1;

    //Number of points inside the square
    private static int nSquarePoints = 0;

    //Number of points inside the circle
    private static int nCirclePoints = 0;

    //lock for synchronization
    private static final Object lock = new Object();

    //Extended thread class
    class NewThread extends Thread{
        int points;         //points allotted to each thread
        int threadId;       //Id of each thread
        
        //Constructor
        public NewThread(int points, int threadId){
            this.points = points;
            this.threadId = threadId;
        }

        //Run function
        public void run(){
            Random rand = new Random();
            //System.out.print("Currently Running Thread : "+threadId+"\n");
            for( int i=0 ; i < points ; ++i){

                //lock for synchronization in updating the shared variables 'nCirclePoints' & 'nSquarePoints'
                synchronized(lock){                 
                    
                    double x = rand.nextDouble();   //random x coordinate
                    double y = rand.nextDouble();   //random y coordinate
                    if( (x*x + y*y) <= 1){
                        nCirclePoints++;            //incrementing circlepoints if inside the circle
                    }
                    nSquarePoints++;                //incrementing squarepoints
                
                }
            }
	        //System.out.print("Currently CirclePoints : "+nCirclePoints+", SquarePoints : "+nSquarePoints+"\n");
        }
    }
    
    public void RunThreads(int pointsPerThread, int pointsForLastThread, int nThreads )
    throws InterruptedException{

        NewThread[] THREAD = new NewThread[nThreads];                           //Creating <nThread> number of threads

        for(int i=0;i<nThreads-1;i++){
            THREAD[i] = new NewThread(pointsPerThread, i+1);                    //Initializing the values of the fields
        }
        THREAD[nThreads-1] = new NewThread(pointsForLastThread, nThreads);      //Initializing values for the last thread

        for(int i=0;i<nThreads;i++){                                            //starting all the threads for execution
            THREAD[i].start();
        }
        
        for(int i=0;i<nThreads;i++){                                            //join() used for synchronization
            THREAD[i].join();
        }
    }
    
    public static void main(String []args)throws InterruptedException{
        int nArgs=args.length;
        if(nArgs==1){                                                   //if number of arguments is 1
            nThreads = Integer.parseInt(args[0]);
            if(nThreads<4 || nThreads>16){                              //if value not between 4 and 16
                System.out.print("Invalid usage!\nNo. of threads should be in the range 4 to 16\n");
                return ;
            }
        }
        else{
            System.out.print("Invalid usage!\nTry the command:: java PI_Computation <nThreads>\nExample :: java PI_Computation 4\n");
            return;
        }
    
        //Calculating the number of points to be alloted to each thread
        int pointsPerThread=1000000/nThreads;

        //If not exactly divisible, give the remainder number of points to last thread
        int pointsForLastThread=1000000-(nThreads-1)*pointsPerThread;

        PI_Computation PI_Comp = new PI_Computation();
        PI_Comp.RunThreads(pointsPerThread, pointsForLastThread, nThreads);                 //performing multithreading
        System.out.println("Number of points inside the circle = "+nCirclePoints);
        System.out.println("Number of points inside the square = "+nSquarePoints);	
        System.out.println("PI = "+(4*(double)nCirclePoints/(double)nSquarePoints));

        //Done
    }
}
