
/*
Name: Ritik Mandloi
Roll No. : 180101066

Instructions for Execution :

    javac MatrixMultiplication.java
    java MatrixMultiplication <No_of_Threads>

    Eg: javac MatrixMultiplication.java
        java MatrixMultiplication 4
*/


import java.util.*;

public class MatrixMultiplication{
    
    //Number of threads
    private static int nThreads=1; 

    //Size of the matrix
    private static int N=1000;

    //lock for synchronization
    private static final Object lock = new Object();

    //Input Matrices A and B
    static double[][] A = new double[N][N];       
    static double[][] B = new double[N][N];

    //C = A X B (Output Matrix)
    static double[][] C = new double[N][N];

    Random rand=new Random();


    //Extended Thread Class
    class NewThread extends Thread{

        int rowsAllotted;           //Rows allotted to each thread
        int startingRow;            //starting rowIndex of each thread
        int threadId;               //threadID

        //Constructor
        public NewThread(int rowsAllotted, int startingRow, int threadId){
            this.startingRow = startingRow;
            this.rowsAllotted = rowsAllotted;
	        this.threadId = threadId;
        }

        //run function
        public void run(){
            //System.out.print("Currently Running Thread : "+threadId+"\n");
            for( int i=startingRow ; i < startingRow+rowsAllotted ; i++){
                for(int j=0;j<N;j++){
                    synchronized(lock){             //lock used to update the shared matrix C
                        double x = 0.000;
            		    for(int k=0;k<N;k++) x += (double)A[i][k] * (double)B[k][j]; //row-column multiplication
            		    C[i][j]=x;
                    }
                }
            }
	        //System.out.print("Currently Running Thread : "+threadId+"\n");
        }
    }
    
    public void RunThreads(int rowsPerThread, int rowsForLastThread, int nThreads)
    throws InterruptedException{
        NewThread[] THREAD = new NewThread[nThreads];                               //Creating <nThread> number of threads
        for(int i=0;i<nThreads-1;i++){
            int startingRow = i*rowsPerThread;
            THREAD[i] = new NewThread(rowsPerThread, startingRow, i+1);             //Initializing the values of the fields
        }
        int startingRow = (nThreads-1)*rowsPerThread;
        THREAD[nThreads-1] = new NewThread(rowsForLastThread, startingRow, nThreads);   //Initializing values for the last thread

        for(int i=0;i<nThreads;i++){                                                //starting all the threads for execution
            THREAD[i].start();
        }
        for(int i=0;i<nThreads;i++){                                                //join() used for synchronization
            THREAD[i].join();
        }
    }

    //A function to generate the randomized matrix
    public void Generate(double[][] A,int N)
    throws InterruptedException{
        for(int i=0;i<N;i++){
            for(int j=0;j<N;j++){
                A[i][j]=rand.nextDouble()*10;
            }
        }
    }

    //A function to display the randomized matrix
    public void Display(double[][] A,int N)
    throws InterruptedException{
        for(int i=0;i<N;i++){
            for(int j=0;j<N;j++){
                System.out.print(A[i][j]+" ");
            }
            System.out.print("\n");
        }
    }

    public static void main(String []args)throws InterruptedException{
        int nArgs=args.length;

        if(nArgs==1){                               //if number of arguments is 1
            nThreads = Integer.parseInt(args[0]);
            if(nThreads<4 || nThreads>16){          //if value not between 4 and 16
                System.out.print("Invalid usage!\nNo. of threads should be in the range 4 to 16\n");
                return ;
            }
        }
        else{                                       
            System.out.print("Invalid usage!\nTry the command:: java MatrixMultiplication <nThreads>\nExample :: java MatrixMultiplication 4\n");
            return;
        }

        MatrixMultiplication MM_Obj = new MatrixMultiplication();

        //Generate Matrix A and B
        MM_Obj.Generate(A,N);                       
        MM_Obj.Generate(B,N);

        //Display the Generated matrices A and B
        System.out.println("\nMatrix A :");
        MM_Obj.Display(A,N);
        System.out.println("\nMatrix B :");
        MM_Obj.Display(B,N);

        //Calculating the number of rows to be alloted to each thread
        int rowsPerThread=N/nThreads;

        //If not exactly divisible, give the remainder number of rows to last thread
        int rowsForLastThread=N-(nThreads-1)*rowsPerThread;

        //performing multithreading
        MM_Obj.RunThreads(rowsPerThread, rowsForLastThread, nThreads);

        //Displaying the final A X B matrix
        System.out.println("\nMatrix C = A X B :");
        MM_Obj.Display(C,N);

        //Done
    }
}
