


%
%****************************************************************************************************************
%

% Name 	   : Ritik Mandloi
% Roll No. : 180101066

%
%******************************Sample Queries***********************************
%

% shortestpath(1,0,2,8,3,10).
% shortestpath(1,0,0,2,3,10).
% assertz(faultynode(1)).
% shortestpath(1,0,0,2,3,10).
% retract(faultynode(1)).
% shortestpath(1,0,0,2,3,10).
% retract(faultynode(15)).
% retract(faultynode(25)).
% shortestpath(1,0,2,8,3,10).
% assertz(faultynode(25)).
% shortestpath(1,0,2,8,3,10).


% *****************************code starts here********************************



% making faultynode predicate dynamic
:- dynamic(faultynode/1).

% append predicate used to append two lists
% append(lista,listb,listc) means listc is the concatenation of list a and list b

% keep adding first element of the first list to the third argument listc.
append([X|Y],Z,[X|W]) :- append(Y,Z,W). 

% if lista empty, listc is listb.
append([],X,X).							


% updateminpath predicate used to update the global variables 'current_shortest_length' and 'current_shortest_path'.
% 'current_shortest_length' and 'current_shortest_path' store the shortest path length and the shortest path respectively.

% argument description : updateminpath(length of the present path, the present path in list form  )
updateminpath(CurrLength, CurrentPath):-nb_getval(current_shortest_length,CurrentMinLength), % read the current shortest length and store in variable CurrentMinLength
										CurrLength < CurrentMinLength, 						 % if present path length less than CurrentMinLength
										nb_setval(current_shortest_length,CurrLength),		 % update the global variable current_shortest_length with CurrLength
										nb_setval(current_shortest_path,CurrentPath).		 % update the global variable current_shortest_path with CurrentPath

% findpaths predicate used to search for all paths from X to Y.
% argument description : findpaths(SourceNode X,DestinationNode Y,Visited List,CurrentPath List,Length of the current path)

findpaths(X,Y,  _    ,CurrentPath,Length):- mazelink(X,Y),									 % if edge between X and Y
											Length2 is Length + 1, 							 % increment length of path by 1
											append(CurrentPath,[Y],CurrentPath2),			 % append Y to current path list
											updateminpath(Length2,CurrentPath2).			 % update the shortest path till now.

findpaths(X,Y,Visited,CurrentPath,Length):- mazelink(X,Z), 									 % if new edge between X and Z
											Z=\=Y,											 % if Z is not Y
											\+faultynode(Z), 								 % if Z is not faulty node
											\+member(Z,Visited),							 % if Z is not already visited
					  						append([X],Visited, Visited2),					 % add X to visited list
											nb_getval(current_shortest_length,CurrMinLen), 	 % read the current shortest length and store in variable CurrMinLen
											CurrMinLen > Length,							 % current pathlength less than current shortest length
					  						append(CurrentPath,[Z], CurrentPath2),			 % add Z to current path list
				          					Length2 is Length + 1,							 % increment length of path by 1
					  						findpaths(Z,Y,Visited2,CurrentPath2,Length2).	 % recursive call for shortest path between Z and Y with updated arguments.


% check predicate used to check for validity of arguments.
% argument description : check(SrcX,SrcY,DestX,DestY,Width og grid,Height of grid)


check(  _ ,SrcY,  _  ,  _  ,  _  ,Height):- Height =< SrcY, 								 % if SrcY greater than or equal to Height of the grid
											write("SrcY out of bound!"),nl.					 % report the error

check(  _ ,  _ ,  _  ,DestY,  _  ,Height):- Height =< DestY, 								 % if DestY greater than or equal to Height of the grid
											write("DestY out of bound!"),nl.				 % report the error

check(SrcX,  _ ,  _  ,  _  ,Width,  _   ):- Width =< SrcX, 									 % if SrcX greater than or equal to Width of the grid
											write("SrcX out of bound!"),nl.			 		 % report the error

check(  _ ,  _ ,DestX,  _  ,Width,  _   ):- Width =< DestX, 								 % if DestX greater than or equal to Width of the grid
											write("DestX out of bound!"),nl.				 % report the error

check(SrcX,SrcY,  _  ,  _  ,  _  ,Height):- SourceNode is Height*SrcX+SrcY,					 % Node number in the grid.
											faultynode(SourceNode), 						 % if sourcenode faulty
											write("Source Node Itself Is Faulty!"),nl.		 % report the error

check(  _ ,  _ ,DestX,DestY,  _  ,Height):- DestinationNode is Height*DestX+DestY,			 % Node number in the grid.
											faultynode(DestinationNode), 					 % if destnode faulty
											write("Destination Node Itself Is Faulty!"),nl.  % report the error

% checksame predicate used to check if src and dest nodes are same.
% argument description : checksame(SrcX,SrcY,DestX,DestY)
checksame(SrcX,SrcY,DestX,DestY):- 	SrcX =:= DestX, 										 % if SrcX is equal to DestX
								   	SrcY=:= DestY. 											 % if SrcY is equal to DestY
									


% getshortestpath predicate used to make a call to findpaths predicate.
% argument description : getshortestpath(SrcX,SrcY,DestX,DestY,Width,Height)

getshortestpath(SrcX,SrcY,DestX,DestY,  _  ,Height):- 	SourceNode is Height*SrcX+SrcY,										 	% get sourcenode number
					   									DestinationNode is Height*DestX+DestY,									% get destnode number
				           								findpaths(SourceNode, DestinationNode, [SourceNode],[SourceNode],1).	% call to findpaths with visited as [sourcenode],path as [sourcenode], length as 1


% shortestpath predicate used to make a call to findpaths predicate.
% argument description : shortestpath(SrcX,SrcY,DestX,DestY,Width,Height)

shortestpath(SrcX,SrcY,DestX,DestY,Width,Height):-	nb_setval(current_shortest_length,100000000000),						 	% initialize the global variable current_shortest_length to 100000000000
													nb_setval(current_shortest_path,[]),										% initialize the global variable current_shortest_path to []
													\+check(SrcX,SrcY,DestX,DestY,Width,Height),								% check for any argument errors
													\+checksame(SrcX,SrcY,DestX,DestY),											% check if source and dest are different nodes
													forall(getshortestpath(SrcX,SrcY,DestX,DestY,Width,Height),write("")),		% run getshortestpath for all solutions, shortest path information will be stored in the global variables.
													nb_getval(current_shortest_length,CurrentMinLength),						% read the current_shortest_length in variable CurrentMinLength
													nb_getval(current_shortest_path,CurrentMinPath),							% read the current_shortest_path in variable CurrentMinPath
													CurrentMinLength < 100000000000,											% if there is atleast one path from source to destination
													write("Shortest Path Length = "),write(CurrentMinLength),nl,				% print the length of the shortest path
													write("Shortest Path = "),write(CurrentMinPath),nl,!.						% print the shortest path

shortestpath(SrcX,SrcY,DestX,DestY,Width,Height):- 	checksame(SrcX,SrcY,DestX,DestY),														% check if source and dest are same nodes
													\+check(SrcX,SrcY,DestX,DestY,Width,Height),											% check for any argument errors
													write("Source Node and Destination Node Same! Shortest Path is the Node itself."),nl,	% check if source and dest are different nodes
													SourceNode is Height*SrcX+SrcY,										 					% get sourcenode number
													write("Shortest Path Length = "),write(1),nl,											% print the length of the shortest path = 1
													write("Shortest Path = "),write([SourceNode]),nl,!.										% print the node

shortestpath(  _ ,  _ ,  _  ,  _  ,  _  ,  _   ):- write("No Path Exists Between The Given Nodes"),nl.							% No path found

