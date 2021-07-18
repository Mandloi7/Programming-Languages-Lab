

main :: IO ()                                       --main function
main =  do                                  
putStr("Enter a list of numbers enclosed in [] and ',' seperated.\nExample: [1,2,3,4]\n")
input<-getLine                                      --getting input line
let int_list = (read input::[Integer])             --parsing input line to Integer List
putStr("You Entered The List: ")
print(int_list)                                    --printing the Integer list


-- -- -- -- --You can try the testcases given below. You will get the output in the format  "You Entered The List: <Your Input List>"
-- --   [1,2,3,4,5,6,7,8,9,10]
-- --   []
-- --   [1]
-- --   [-1]
-- --   [1,-2,-3,-4,-5,-6,-7,-8,-9,-10]
-- --   [0]
-- --   [0,0,0,0,0,0,0,0,0,0,0,0]
-- --   [-1,2,-3,4,-5,6,-7,8,-9,10]
-- --   [4,246457,96,-7764,25,54,-76,5432,4,57,-8,564,3,-46,8,967,5764,-2447879,8564,4,9,8676543,7]
-- --   [4234,-435246457,42396,-773464,235265,573644,-773646,5763432,4763,56577,-864764,564,3746,-64746,8467476,967,5467764,-246747879,8674564,4,739,6738676543,7637]