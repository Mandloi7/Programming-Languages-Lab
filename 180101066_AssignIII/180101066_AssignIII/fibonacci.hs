import System.Environment



--fibonacci decreasing_counter current_fibonacci next_fibonacci
fibonacci :: Integer->Integer->Integer->Integer
fibonacci counter current_fibonacci next_fibonacci = do
    if counter==0 
        then 0                                          -- if counter 0, return 0
    else if counter==1 
        then next_fibonacci                             -- if counter 1, return current_fibonacci
    else 
        -- recursive call with (counter-1) as argument and incrementing both fibonacci numbers
        fibonacci (counter-1) next_fibonacci (current_fibonacci + next_fibonacci)    



main = do
    args <- getArgs                                             --getting arguments from the commandline
    if (length args)==1 then do                                 --if valid number of arguments given   
        let n  = (read (head args) :: Integer)                  --converting the argument from string to double
        let ans = fibonacci n 0 1                               -- Fibonacci function call 
        putStrLn ("The " ++ (show n) ++ "th Fibonacci Number is " ++ (show ans))
    else                                                        --Invalid Arguments
        putStrLn ("Please Provide the input 'n' as argument.\nExample ./fibonacci 200")