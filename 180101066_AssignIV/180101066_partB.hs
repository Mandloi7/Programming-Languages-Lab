gcdd :: Integer -> Integer -> Integer               --gcd function
gcdd a b = do
    if (b == 0) then a                              -- gcd a 0 = a
    else gcdd b (a `rem` b)                         -- gcd a b = gcd b rem (rem = a mod b)


lcm_list :: [Integer] ->Int -> Integer              -- lcm function
lcm_list int_list i = do                               
    let n = length int_list                         --length of the list
    if(n-1 == i) then abs(int_list !! i)            --if last element, lcm is the element itself
    else do
        let x = lcm_list int_list (i+1)             --lcm of the right list
        let y = int_list !! i                       --current element
        let product = x*y                           --lcm(a,b)= (a*b)/gcd(a,b)
        abs(product `div` (gcdd x y) )                   --return lcm value


main :: IO ()                                       --main function
main =  do
putStr("Enter a list of numbers enclosed in [] and ',' seperated.\nExample: [1,2,3,4]\n")
input<-getLine                                      --getting input line
let int_list = (read input::[Integer])              --parsing input line to Integer List
putStr("\nYou Entered The List: ")
print(int_list)                                     --printing the Integer list
let n = length int_list                             --getting the length of the list
if (n > 0) then do                                  -- if list not empty
    putStr("The LCM of the given input List is ")
    print(lcm_list int_list 0)                      -- printing the LCM of the list
else putStr("You Entered an Empty list!\n")         -- If List empty



-- -- -- -- --These are the 10 test-cases. You can uncomment the lines below and run. Corresponding correct output is provided in comments to right of the list input

-- let int_list = [1,2,3,4,5,6,7,8,9,10]                          --Output (LCM) = 2520
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")


-- let int_list = [10,20,30,40,50,60,70,80,90,100,110,120]        --Output (LCM) = 277200
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")



-- let int_list = [11,-22,33,-44,55,-66,77,-88,99,-100]                --Output (LCM) = 138600
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")



-- let int_list = [15,0,45,7,-55,65,-74,85,-945,-140,-41,73]           --Output (LCM) = 0
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")



-- let int_list = [10,25,300,400,500,1681,71,98,97,1302]          --Output (LCM) = 105513206358000
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")



-- let int_list = [25,-25,-25,25,-25,25,-25,25,25,25]                     --Output (LCM) = 25
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")



-- let int_list = []                                                  --Empty List
-- putStr("\nYou Entered The List: []\n")
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")


-- let int_list = [56465465465,65465465465,5461214564651,654148948948,987894,65,1,6,564186549984,84684,8964,89,4984,894,9684,98,498,4,985644654654654654648,4564,84,564965,656565,65613,654654894,8489,489,4989999999999,849845]
-- --  ----------                                                      -- Output (LCM) = 5607737197007338025088525229178572870324023917217136467986518374097043792858818854092063166901634456328488999170578512671553332030351294560
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")


-- let int_list = [778,-88,787,-8,78,-89,-8878,98,-878,64,-659,887,-6469956,-879,965,65956,9,87,56565,959,895595,95956,62323,5]       --Output (LCM) = 136890902836091382001816167318645356314855627947683488320
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")



-- let int_list = [1,1,50,25,5,100,250]                                   --Output (LCM) = 500
-- putStr("\nYou Entered The List: ")
-- print(int_list)
-- let n = length int_list
-- if (n > 0) then do
--     putStr("The LCM of the given input List is ")
--     print(lcm_list int_list 0)
-- else putStr("You Entered an Empty list!\n")