import java.util.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;


class AccountLinkedList{                    //The Singly Linked-List containing Account Info
    private AccountNode head;
    public static class AccountNode{        //Node of linked list
        long balance;
        String accountNo;
        AccountNode next;
        int branchCode;
        private Lock lock = new ReentrantLock();

        public AccountNode(long balance, String accountNo){ //constructor
            this.accountNo = accountNo;
            this.branchCode = accountNo.charAt(0)-'0';
            this.balance = balance;
            this.next = null;
            this.lock = new ReentrantLock();
        }

        public void lock(){
            this.lock.lock();
        }

        public void unlock(){
            this.lock.unlock();
        }
    }

    public void CashDeposit(String accountNo, long Cash_Deposit){//deposit into account
        while(true){
            AccountNode curr = this.head;
            AccountNode AccNode = FindAccountNode(curr,accountNo);
            if(AccNode==null){
                return ;
            }
            AccNode.lock();
            try{
                AccNode.balance+=Cash_Deposit;
                return;
            }finally{
                AccNode.unlock();
            }
        }
    }

    public boolean CashWithdrawal(String accountNo, long cash_withdrawal){////withdraw from account
        while(true){
            
            AccountNode curr = this.head;
            AccountNode AccNode = FindAccountNode(curr,accountNo);
            if(AccNode==null){
                return false;
            }
            AccNode.lock();
            try{
                if(AccNode.balance-cash_withdrawal>=0){
                    AccNode.balance-=cash_withdrawal;
                    return true;
                }
                else {
                    return false;
                }
            }finally{
                AccNode.unlock();
            }
        }
    }
    
    public AccountLinkedList(){
        this.head = null;
    }

    public boolean add(String accountNo, long balance){
        while(true){
            AccountNode head=this.head;
            AccountNode node = new AccountNode(balance, accountNo);
            if(head==null){
                this.head = node;
                return true;
            }else{
                head.lock();
                try{
                    if(head.next!=null) {
                        AccountNode secnode = head.next;
                        secnode.lock();
                        try{
                            head.next=node;
                            node.next=secnode;
                            return true;
                        }finally{
                            secnode.unlock();
                        }
                    }
                    else{
                        head.next=node;
                        return true;
                    }
                }
                finally{
                    head.unlock();
                }
            }
            
        }
    }

    public String remove(String accountNo){
        while (true){
            AccountNode curr = this.head;
            AccountNode prev = null;
            if(curr==null){
                return "NOT_FOUND";
            }
            while (true){
                if(curr.accountNo.equals(accountNo)){
                    break;
                }else{
                    prev = curr;
                    curr = curr.next;
                }
                if(curr==null)return "NOT_FOUND";
            }
            if(prev==null){
                curr.lock();
                try{
                    this.head=this.head.next;
                    return curr.accountNo + " " + Long.toString(curr.balance);
                }
                finally{
                    curr.unlock();
                }
            }
            prev.lock();
            try{
                curr.lock();
                try{
                    prev.next = curr.next;
                    curr.next = null;
                    return curr.accountNo + " " + Long.toString(curr.balance);
                }
                finally{
                    curr.unlock();
                }
            }finally{
                prev.unlock();
            }
        }
    }

    public AccountNode FindAccountNode(AccountNode curr, String accountNo){
        while (curr != null && !curr.accountNo.equals(accountNo)){
                curr = curr.next;
        }
        if(curr==null){
            return null;
        }else return curr;
    }

    public void printAccountLinkedList(){
        if(this.head==null){
            System.out.print("Empty\n");
        }else{
            AccountNode curr = this.head;
            if(curr.accountNo=="HeadNode")curr=curr.next;
            while (curr != null ){
                System.out.print("[acc="+curr.accountNo  +", bal="+ Long.toString(curr.balance)+"],");
                curr = curr.next;
            }
            System.out.print("\n");
        }
    }

}


public class MyGNB{

    public static AccountLinkedList[] Account_LL = new AccountLinkedList[10];
    public static Set<String> all_accounts = new HashSet<String>();
    public static String[] AccountNumbers = new String[10000010];
    long size=-1;
    public static ExecutorService[] ES = new ExecutorService[10];
    public static Lock[] Listlocks = new ReentrantLock[10];

    
    public String GetString(int size){
        String s="";
        Random rand = new Random(); 
        for(int i=1;i<10;i++){
            s += (char)('0'+rand.nextInt(9));
        }
        return s;
    }

    public String getRandomAccountNumber(){
        int item = new Random().nextInt((int)size);
        return AccountNumbers[item];
    }

    
    public long RandomInInterval(long l, long r){
        long rand = (long) (Math.random() * (r - l));
        return l + rand;
    }
    

    public String GetNewAccountNumber(int index){
        char start=(char)(index + '0');
        while(true){
            String account = ""+start;
            account += GetString(9);
            if(all_accounts.contains(account)){
                continue;
            }else{
                all_accounts.add(account);
                size++;
                AccountNumbers[(int)size]=account;
                return account;
            }
        }
    }

    public AccountLinkedList initializeList(int index, long size){
        AccountLinkedList LL = new AccountLinkedList();
        for(int i = 0; i < size; i++){
            String temp = GetNewAccountNumber(index);
            LL.add(temp, RandomInInterval(100, 10000000));
        }
        return LL;
    }

    public int decodeBranch(String account){
    	return (account.charAt(0)-'0');
    }
    


    class MyThread implements Runnable{
        private String Account_A;
        private String Account_B;
        private String opcode;
        private long amount;
    	private int branch;
    	@Override
    	public void run(){
            String OpCode = this.opcode;
    		if(OpCode.equals("Cash_Deposit")){
    			int branchx = decodeBranch(this.Account_A);
                Account_LL[branchx].CashDeposit(this.Account_A, this.amount);
    		}
            else if(OpCode.equals("Cash_Withdrawal")){
    			int branch = decodeBranch(this.Account_A);
                boolean x= Account_LL[branch].CashWithdrawal(this.Account_A, this.amount);
    			if(x){
                    //Success
                }
                else{
                    //System.out.println("Not Enough Balance");
                }
    		}
    		else if(OpCode.equals("Money_Transfer")){
    			int branch1 = decodeBranch(this.Account_A);
    			int branch2 = decodeBranch(this.Account_B);
                boolean x = Account_LL[branch1].CashWithdrawal(this.Account_A, this.amount);
    			if(x){
                    Account_LL[branch2].CashDeposit(this.Account_B, this.amount);
    			}else{
                    //System.out.println("Not Enough Balance");
                }
    		}
    		else if(OpCode.equals("Add_Customer")){
    			int branch = decodeBranch(this.Account_A);
    			Account_LL[branch].add(this.Account_A, this.amount);
    		}
    		else if(OpCode.equals("Delete_Customer")){
    			int branch = decodeBranch(this.Account_A);
    			Account_LL[branch].remove(this.Account_A);
    		}
    		else if(OpCode.equals("Transfer_Customer")){
                String removed_user;
    			int branch1 = decodeBranch(this.Account_A);
                removed_user = Account_LL[branch1].remove(this.Account_A);
                if(removed_user.equals("NOT_FOUND")){
                    //System.out.println("Not Found")
                }else{
                    //Found
                    String[] Arr = removed_user.split(" ");
                    int branchx=this.branch;
                    long amountBef = Long.parseLong(Arr[1]);
                    String Account_A = Arr[0];
                    Account_A = branchx  + Account_A.substring(1);
                    all_accounts.add(Account_A);
                    Account_LL[branchx].add(Account_A, amountBef);
                }
    		}
    	}

    	public MyThread(String str){
            Account_A = "";
            Account_B = "";
    		branch = -1;
            amount = -1;
            String[] s = str.split(" ");
    		this.opcode = s[0];
            this.Account_A = s[1];
            String code=s[0];
            if(code.equals("Cash_Deposit")||code.equals("Cash_Withdrawal")||code.equals("Add_Customer")){
                this.amount = Long.parseLong(s[2]);
            }else if(code.equals("Money_Transfer")){
                this.Account_B = s[2];
    			this.amount = Long.parseLong(s[3]);
            }else{
                if(code.equals("Transfer_Customer"))this.branch = Integer.parseInt(s[2]);
            }
    	}
        
    }
    
    public String generateOpcode(){
    	Random random = new Random();
        int i = random.nextInt(1000);
        if(i<330) return "Cash_Deposit";
        else if(i<660) return "Cash_Withdrawal";
        else if(i<990) return "Money_Transfer";
        else if(i<993) return "Add_Customer";
        else if(i<996) return "Delete_Customer";
        else  return "Transfer_Customer";
    }

    public String GenerateTransaction(){
    	String transaction;
    	String opcode = generateOpcode();
        String s1="";
        String s2="";
        String s3="";
        if(opcode.equals("Cash_Deposit")){
            String Acc = getRandomAccountNumber();
            String cash_temp = Long.toString(RandomInInterval(1L,10000000));
            s1=Acc;
            s2=cash_temp;
        }
        else if(opcode.equals("Cash_Withdrawal")){
            String Acc = getRandomAccountNumber();
            String cash_temp = Long.toString(RandomInInterval(1L,10000000));
            s1=Acc;
            s2=cash_temp;
        }
        else if(opcode.equals("Money_Transfer")){
            String Acc_1 = getRandomAccountNumber();
            String Acc_2 = getRandomAccountNumber();
            String cash_temp = Long.toString(RandomInInterval(1L,10000000));
            s1=Acc_1;
            s2=Acc_2;
            s3=cash_temp;
        }
        else if(opcode.equals("Add_Customer")){
            int item = new Random().nextInt(10);
            String Acc = GetNewAccountNumber(item);
            String cash_temp = Long.toString(RandomInInterval(100,10000000));
            s1=Acc;
            s2=cash_temp;
        }
        else if(opcode.equals("Delete_Customer")){
            String Acc = getRandomAccountNumber();
            s1=Acc;
        }
        else if(opcode.equals("Transfer_Customer")){
            String Acc = getRandomAccountNumber();
            long randomBranch = RandomInInterval(0L,9L);
            while(decodeBranch(Acc)== randomBranch){
                randomBranch=RandomInInterval(0L,9L);
            }
            String branch_temp = Long.toString(randomBranch);
            s1=Acc;
            s2=branch_temp;
            
        }
        transaction = opcode + " "+s1+" "+s2+" "+s3;
    	return transaction;
    }

    public void Testing(long nTransactions ){            //Testing Function
    	System.out.println("\nTesting :: ");
    	for(int i=0;i<nTransactions;i++){
    		String s = GenerateTransaction();

            // System.out.print(i+": ");
            // System.out.println(s);

    		String[] s_split = s.split(" ");
    		int branch = decodeBranch(s_split[1]);
    		ES[branch].submit(new MyThread(s));
    	}
        
    	for(int i=0;i<10;i++){
    		ES[i].shutdown();
    		while(!ES[i].isTerminated()){}
    	}

    	System.out.println("\nTesting Completed\n");
    }
    
    public void InitializeArrayOfLinkedList(long sizePerIndex, MyGNB BS) {
        for(int i = 0; i < 10; i++){   
            Account_LL[i] = BS.initializeList(i,sizePerIndex);
            Listlocks[i] = new ReentrantLock();
            ES[i] = Executors.newFixedThreadPool(10);
        }
    }

    public static void main(String[] args){
        MyGNB BS = new MyGNB();
        long nUsers = 100000;              //Total Users
        long nTransactions = 1000000;           //Total Transactions, Make it small for faster execution, Adjust according to requirement
        long sizePerIndex = (nUsers / 10);
        
        BS.InitializeArrayOfLinkedList(sizePerIndex,BS);
        
        System.out.println("Initialized Linked List Array");
        // for(int i = 0; i < 10; i++){                     //uncomment to print initial  list
        //     System.out.print("Branch "+i+": ");
        //     Account_LL[i].printAccountLinkedList();
        // }
        
        double startTime = System.currentTimeMillis();
        BS.Testing(nTransactions);
        double endTime = System.currentTimeMillis();
        //System.out.println("Final Status Of all accounts");   //uncomment to print final list
        // for(int i = 0; i < 10; i++){
        //     System.out.print("Branch "+i+": ");
        //     Account_LL[i].printAccountLinkedList();
        // }
        System.out.println("\nExecution time :"+ (endTime - startTime)+ " ms");
    }
}
