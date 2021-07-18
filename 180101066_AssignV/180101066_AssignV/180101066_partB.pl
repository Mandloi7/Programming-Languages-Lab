% AUTHOR      : RITIK MANDLOI
% ROLL NUMBER : 180101066

% EMPTY LIST WILL ALWAYS BE A SUBLIST
sublist([],_).

% IF FIRST ELEMENT IS SAME FOR BOTH LISTS, REMOVE THE FIRST ELEMENT AND RECURSIVE CALL FOR THE REMAINING LISTS.
sublist([H|Tail1],[H|Tail2]) :- sublist(Tail1,Tail2).

% IF FIRST ELEMENT IS NOT SAME FOR BOTH LISTS, RECURSIVE CALL ON THE SECOND REMAINING LIST (SECOND ARGUMENT LIST).
sublist([H|Tail1],[_|Tail2]) :- sublist([H|Tail1],Tail2).




% SOME TEST CASES IN CASE YOU NEED.

% sublist([],[]).
% sublist([],[1]).
% sublist([1],[1,2,3]).
% sublist([1],[1]).
% sublist([2,3],[3,2]).
% sublist([3,4],[1,2,3,4,5]).
% sublist([2,5,1],[2,1,5,0]).
% sublist([1,2,3,4,5,6,7,8,9,0],[1,2,3,4,5,6,7,8,9,0]).
% sublist([1024,86],[]).
% sublist([25.9],[-89.6]).
