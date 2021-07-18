import System.Environment


--square_root right left accuracy N
square_root :: Double->Double->Double->Double->Double
square_root right left e n = do                         --binary search algorithm
    let mid = (left + right)/2
    if mid * mid <= n && (mid + e) * (mid + e) >= n     --Case1: Square Root found => return mid
        then mid
    else if mid * mid < n
        then square_root right mid e n                  --Case2: binary search in [mid...right]
    else square_root  mid left e n                      --Case3: binary search in [left...mid]

--precision function to round the number to 5 decimal places (x=number, y=100000)
precision :: Double -> Double -> Double 
precision x y = fromIntegral(round $x * y)/y



---main function
main = do
    args <- getArgs                                     --getting arguments from the commandline
    if (length args)==1 then do                         --if valid number of arguments given   
        let n  = (read (head args) :: Double)           --converting the argument from string to double
        if(n>1) then do                                 --Case1 : if number is greater than 1
            let e = 0.000001                            --declaring the accuracy
            let sqrtn = square_root n 1 e n             --square_root function call, left=1, right=n
            let ans = precision sqrtn 100000            --rounding the answer to 5 decimal places
            putStrLn ("The Square Root of " ++ (show n) ++ " is " ++ (show ans))
        else if (n>=0 && n<=1 ) then do                 --Case2 : if number is in the range [0..1]
            let e = 0.000001                            --declaring the accuracy
            let sqrtn = square_root 1 n e n             --square_root function call, left=n, right=1
            let ans = precision sqrtn 100000            --rounding the answer to 5 decimal places
            putStrLn ("The Square Root of " ++ (show n) ++ " is " ++ (show ans))
        else                                            --Case3 : if number is negative
            putStrLn ("You entered a negative number. Please Provide a positive 'n' as argument.\nExample ./square_root 23.56")
    else                                                --Invalid Arguments
        putStrLn ("Please Provide a positive 'n' as argument.\nExample ./square_root 23.56")