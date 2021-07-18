
--defining the Tree
data Tree a = Nil | Node (Tree a) a (Tree a) deriving Show      


-- Function to insert an integer into the Tree
insert_node :: Tree Integer-> Integer -> Tree Integer           
insert_node Nil x = Node Nil x Nil                              -- If tree is Nil, return a tree with root x
insert_node (Node left curr_root right) x = do                  -- If tree not Nil
    if(curr_root < x) then do                                   -- If element is less than root, insert to the left
        let new_right_subtree = insert_node right x             -- new right subtree
        Node left curr_root new_right_subtree                   -- Return the new Tree
    else if(curr_root == x) then Node left curr_root right      -- If element is equal to root, ignore the duplicate.
    else do                                                     -- If element is greater than root, insert to the right
        let new_left_subtree = insert_node left x               -- new left subtree
        Node new_left_subtree curr_root right                   -- Return the new Tree
    
    
-- Helper Function to create a BST
create_bst2 :: Tree Integer->[Integer]->Tree Integer            
create_bst2 curr_tree [] = curr_tree                            --Empty list, return the current tree
create_bst2 curr_tree (curr_head:remaining_list) = do           --curr_head is head of the present list
    let new_tree = (insert_node curr_tree curr_head)            --Insert the curr_head in the curr_tree
    create_bst2 new_tree remaining_list                         --recursive call for remaining list


-- Function that uses the above function and generates the BST
create_bst :: [Integer]->Tree Integer
create_bst[] = Nil                                              --List empty, return Nil
create_bst(curr_head:remaining_list) = do                       --curr_head is head of the present list
    let new_tree = (Node Nil curr_head Nil)                     --Create the root of the tree, left and right Nil
    create_bst2 new_tree remaining_list                         --Call to the create_bst2 function
    

-- Preorder Traversal function 
preorder :: Tree Integer-> IO()
preorder Nil = putStr("")                                       --If root Nil, print nothing
preorder (Node left curr_root right) = do                       --If root not Nil
    putStr((show curr_root) ++ " ")                             --Print root
    preorder left                                               --Recursive call to left
    preorder right                                              --Recursive call to right
    
-- Inorder Traversal function 
inorder :: Tree Integer-> IO()
inorder Nil = putStr("")                                        --If root Nil, print nothing
inorder (Node left curr_root right) = do                        --If root not Nil
    inorder left                                                --Recursive call to left
    putStr((show curr_root) ++ " ")                             --Print root
    inorder right                                               --Recursive call to right
    
-- Postorder Traversal function 
postorder :: Tree Integer-> IO()
postorder Nil = putStr("")                                      --If root Nil, print nothing
postorder (Node left curr_root right) = do                      --If root not Nil
    postorder left                                              --Recursive call to left
    postorder right                                             --Recursive call to right
    putStr((show curr_root) ++ " ")                             --Print root
    
    

main :: IO ()                                                   --main function
main =  do                                  
putStr("Enter a list of numbers enclosed in [] and ',' seperated.\nExample: [1,2,3,4]\n")
input<-getLine                                                  --getting input line
let int_List = (read input::[Integer])                         --parsing input line to Integer List
putStr("\nYou Entered The List:: ")
print(int_List)                                                --printing the Integer list
let n = length int_List                                        --getting the length of the list
if (n > 0) then do                                              --if list not empty
    let bst = create_bst int_List                              -- Create BST from the list
    putStr("Generated BST       :: ")
    print(bst)                                                  --Printing the BST Nodes
    putStr("PreOrder Traversal  :: ")
    preorder bst                                                -- Preorder traversal
    putStr("\n")
    putStr("InOrder Traversal   :: ")
    inorder bst                                                 -- Inorder traversal
    putStr("\n")
    putStr("PostOrder Traversal :: ")
    postorder bst                                               -- Postorder traversal
    putStr("\n")
else putStr("You Entered an Empty list!\n")                     --If list empty


-- -- -- -- --These are the 10 test-cases. You can uncomment the lines below and run. Corresponding correct output is provided in comments to right of the list input

-- let int_List = [1,2,3,4,5,6,7,8] 
-- -- -- -- -- Correct PreOrder  : 1 2 3 4 5 6 7 8
-- -- -- -- -- Correct InOrder   : 1 2 3 4 5 6 7 8
-- -- -- -- -- Correct PostOrder : 8 7 6 5 4 3 2 1
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")


-- let int_List = [8,7,6,5,4,3,2,1,0,-1,-2,-3] 
-- -- -- -- -- Correct PreOrder  : 8 7 6 5 4 3 2 1 0 -1 -2 -3
-- -- -- -- -- Correct InOrder   : -3 -2 -1 0 1 2 3 4 5 6 7 8
-- -- -- -- -- Correct PostOrder : -3 -2 -1 0 1 2 3 4 5 6 7 8
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")



-- let int_List = [50,0,100,25,75,-25,90,40,60,30,70,15,85,20,80,10] 
-- -- -- -- -- Correct PreOrder  : 50 0 -25 25 15 10 20 40 30 100 75 60 70 90 85 80
-- -- -- -- -- Correct InOrder   : -25 0 10 15 20 25 30 40 50 60 70 75 80 85 90 100
-- -- -- -- -- Correct PostOrder : -25 10 20 15 30 40 25 0 70 60 80 85 90 75 100 50
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")




-- let int_List = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10] 
-- -- -- -- -- Correct PreOrder  : 1 2 3 4 5 6 7 8 9 10
-- -- -- -- -- Correct InOrder   : 1 2 3 4 5 6 7 8 9 10
-- -- -- -- -- Correct PostOrder : 10 9 8 7 6 5 4 3 2 1 
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")





-- let int_List = [2,1,3] 
-- -- -- -- -- Correct PreOrder  : 2 1 3
-- -- -- -- -- Correct InOrder   : 1 2 3
-- -- -- -- -- Correct PostOrder : 1 3 2
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")






-- let int_List = [5,3,4,2,1,7,6,9,8,10] 
-- -- -- -- -- Correct PreOrder  : 5 3 2 1 4 7 6 9 8 10
-- -- -- -- -- Correct InOrder   : 1 2 3 4 5 6 7 8 9 10 
-- -- -- -- -- Correct PostOrder : 1 2 4 3 6 8 10 9 7 5 
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")







-- let int_List = [] 
-- -- -- -- -- Empty List
-- putStr("\nYou Entered The List:: []\n")
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")





-- let int_List = [16565623232356421323265694131326494632303232] 
-- -- -- -- -- Correct PreOrder  : 16565623232356421323265694131326494632303232 
-- -- -- -- -- Correct InOrder   : 16565623232356421323265694131326494632303232
-- -- -- -- -- Correct PostOrder : 16565623232356421323265694131326494632303232
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")






-- let int_List = [54654564654,34566541,4564164,46541652,145616,465417,465486,9849869,65418,1654110,465656,6546546,6546548765,654654894,65468498121,13464,3156,45659,1564,54,4,564,84121665,4,465] 
-- -- -- -- -- Correct PreOrder  : 54654564654 34566541 4564164 145616 65418 13464 3156 1564 54 4 564 465 45659 465417 465486 1654110 465656 9849869 6546546 46541652 6546548765 654654894 84121665 65468498121
-- -- -- -- -- Correct InOrder   : 4 54 465 564 1564 3156 13464 45659 65418 145616 465417 465486 465656 1654110 4564164 6546546 9849869 34566541 46541652 84121665 654654894 6546548765 54654564654 65468498121 
-- -- -- -- -- Correct PostOrder : 4 465 564 54 1564 3156 45659 13464 65418 465656 1654110 465486 465417 145616 6546546 9849869 4564164 84121665 654654894 6546548765 46541652 34566541 65468498121 54654564654
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")





-- let int_List = [-6547,-73441,-64164,-44162,1456,65417,46486,-49869,618,-54110,4656,46,65485,-54894,-121,-5134,-93156,74569,-11564,-8954,-744,564,-21665,-400,-4601] 
-- -- -- -- -- Correct PreOrder  : -6547 -73441 -93156 -64164 -44162 -49869 -54110 -54894 -11564 -21665 -8954 1456 618 46 -121 -5134 -744 -4601 -400 564 65417 46486 4656 65485 74569
-- -- -- -- -- Correct InOrder   : -93156 -73441 -64164 -54894 -54110 -49869 -44162 -21665 -11564 -8954 -6547 -5134 -4601 -744 -400 -121 46 564 618 1456 4656 46486 65417 65485 74569 
-- -- -- -- -- Correct PostOrder : -93156 -54894 -54110 -49869 -21665 -8954 -11564 -44162 -64164 -73441 -4601 -400 -744 -5134 -121 564 46 618 4656 46486 74569 65485 65417 1456 -6547 
-- putStr("\nYou Entered The List:: ")
-- print(int_List)
-- let n = length int_List
-- if (n > 0) then do
--     let bst = create_bst int_List
--     putStr("Generated BST       :: ")
--     print(bst)                                                  --Printing the BST Nodes
--     putStr("PreOrder Traversal  :: ")
--     preorder bst
--     putStr("\n")
--     putStr("InOrder Traversal   :: ")
--     inorder bst
--     putStr("\n")
--     putStr("PostOrder Traversal :: ")
--     postorder bst 
--     putStr("\n")
-- else putStr("You Entered an Empty list!\n")



