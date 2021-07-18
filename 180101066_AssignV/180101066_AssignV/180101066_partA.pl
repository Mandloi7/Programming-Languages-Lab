% AUTHOR      : RITIK MANDLOI
% ROLL NUMBER : 180101066

% THE SQUARE-ROOT FUNCTION IS IMPLEMEMTED HERE USING THE BINARY SEARCH APPROACH

% A FUNCTION USED TO UPDATE THE 'LEFT' AND THE 'RIGHT' PARAMETERS OF THE BINARYSEARCH FUNCTION.

handle_result(Result,Left,Right,Accuracy,X) :-  Result*Result > X ,                                 % IF CURRENT RESULT IS GREATER THAN THE ACTUAL SQUARE-ROOT
                                                NewRight is ((Right + Left)/2),                     % SO, WE UPDATE THE RIGHT TO (RIGHT+LEFT)/2
                                                binary_search(X,Result, Accuracy, Left, NewRight).  % BINARY SEARCH CALL ON THE UPDATED PARAMETERS

handle_result(Result,Left,Right,Accuracy,X) :-  Result*Result =< X ,                                % IF CURRENT RESULT IS LESS THAN OR EQUAL TO THE ACTUAL SQUARE-ROOT
                                                NewLeft is ((Right + Left)/2),                      % SO, WE UPDATE THE LEFT TO (RIGHT+LEFT)/2
                                                binary_search(X,Result, Accuracy, NewLeft, Right).  % BINARY SEARCH CALL ON THE UPDATED PARAMETERS



% BINARY SEARCH FUNCTION
binary_search(X,Result,Accuracy,  _ ,  _  ) :-  abs(Result*Result - X) =< Accuracy ,                % IF CURRENT RESULT IS THE APPROXIMATE SQUARE-ROOT
                                                write(Result).                                      % PRINT CURRENT RESULT
binary_search(X,Result,Accuracy,Left,Right) :-  abs(Result*Result - X) > Accuracy ,                 % CURRENT RESULT NEEDS TO BE MORE ACCURATE
                                                NewResult is ((Left+Right)/2),                      % UPDATE THE CURRENT RESULT TO (RIGHT+LEFT)/2
                                                handle_result(NewResult, Left,Right,Accuracy, X).   % handle_result CALL ON THE UPDATED PARAMETERS



% SQUARE ROOT FUNCTION
squareroot(X,Result,Accuracy) :-    X > 1,                                                          % IF NUMBER IS GREATER THAN 1
                                    binary_search(X,Result,Accuracy,1,X).                           % BINARY SEARCH IN INTERVAL 1 TO X

squareroot(X,   _  ,   _    ) :-    X < 0,                                                          % IF NUMBER IS LESS THAN 0
                                    write('You entered a negative number!'), nl.                    % REPORT ERROR

squareroot(X,Result,Accuracy) :-    X =< 1,                                                         % IF NUMBER IS LESS THAN OR EQUAL TO 1
                                    binary_search(X,Result,Accuracy,X,1).                           % BINARY SEARCH IN INTERVAL X TO 1



% SOME TEST CASES IN CASE YOU NEED.

% squareroot(4,2,0.001).
% squareroot(49,24.5,0.00001).
% squareroot(2,1,0.00000001).
% squareroot(3,1.5,0.0001).
% squareroot(42.25,21.125,0.000001).
% squareroot(0.64,0.32,0.0001).
% squareroot(1,0.5,0.00001).
% squareroot(0,0,0.001).
% squareroot(42,21,0.01).
% squareroot(22222,11111,0.0001).
