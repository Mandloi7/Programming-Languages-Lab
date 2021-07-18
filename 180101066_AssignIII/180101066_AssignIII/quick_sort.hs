import System.Environment

--quick_sort List
quick_sort :: (Ord a) => [a] -> [a]
quick_sort [] = []                                          --return empty-list
quick_sort (pivot:lista) = do                               --taking the first element of the list as pivot
    if length lista > 0 then do
        let left = quick_sort [x | x <- lista, x <= pivot]  --partition the list , left contains elements smaller than or equal to the pivot
        let right = quick_sort [x | x <- lista, x > pivot]  --right contains elements greater than the pivot
        left ++ [pivot] ++ right                            --merge the partitioned lists
    else [pivot]
      
      

main = do
    args <- getArgs                                   --getting arguments from the commandline
    if(length args>0)then do                          --if valid number of arguments given   
        let intList = map read args :: [Integer]      --converting the argument from string to int
        let sorted_list = quick_sort intList          --quick_sort function call on intList
        print sorted_list                             --print sorted list
    else putStrLn ("Please Provide the input-list as argument with spaces.\nExample ./quick_sort 12 2 4 5 18")

