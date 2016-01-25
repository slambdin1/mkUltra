noAdvantage(Maze):-
	numberOfPlayers(Maze, PlayaNum),
	checkifPlayerIsInMaze(1, PlayaNum, Maze, Path1),
	checkifPlayerIsInMaze(2, PlayaNum, Maze, Path2),
	checkifPlayerIsInMaze(3, PlayaNum, Maze, Path3),
	checkifPlayerIsInMaze(4, PlayaNum, Maze, Path4),
	write('Path1:'),
	writeln(Path1),
	write('Path2:'),
	writeln(Path2),
	write('Path3:'),
	writeln(Path3),
	write('Path4:'),
	writeln(Path4),
	not(checkIfHasAdvantage(Path1, Path2, Path3, Path4)).

checkifPlayerIsInMaze(PlayerNum, TotalPlayerCount, Maze, PathLength):-
	(PlayerNum =< TotalPlayerCount,
	findInMaze(Maze, PlayerNum, PlayerPosition),
	getShortestPath(Maze, PlayerPosition, ShortestPath)) -> 
	(length(ShortestPath, Length),
	PathLength is Length); PathLength is 11.

checkIfHasAdvantage(Path1, Path2, Path3, Path4):-
	(Path1 =< Path2), (Path1 =< Path3), (Path1 =< Path4).

% ---------------------------------- FROM PART 1 --------------------------------

numberOfPlayersHelper([],0).
numberOfPlayersHelper([Y|T],N1):- isValidPlayer(Y),numberOfPlayersHelper(T,N2),N1 is N2+1,!.
numberOfPlayersHelper([_|T],N1):- numberOfPlayersHelper(T,N1).

numberOfPlayers([],0).
numberOfPlayers([X|T],FinalNum):- numberOfPlayersHelper(X,NewNum),numberOfPlayers(T,TempNum),addNumbers(NewNum, TempNum, Sum),FinalNum is Sum.

isValidPlayer(Num):- member(Num,[1,2,3,4]).

addNumbers(X,Y,Z):- Z is X+Y.

% ---------------------------------- FROM PART 2 --------------------------------

% findInMaze(Maze,Element,Position)
findInMaze([Row|_],What,(0,C)):-
    findInRow(Row,What,C).
findInMaze([_|Rows],What,(R,C)):-
    findInMaze(Rows,What,(TempR,C)),
    R is TempR + 1.

% findInRow([Col|Cols],What,Where)
findInRow([What|_],What,0).
findInRow([_|Tail],What,Where):-
    findInRow(Tail,What,TWhere),
    Where is TWhere + 1.

isWallOrPlayer(Element):- (Element==x; member(Element,[1,2,3,4])).

isGoal(Element):- Element==g.

checkIsGoal(X, Maze):-
	getValFromPosition(Maze, X, Val),
	isGoal(Val).

getAdjacentNode((X,Y), (AdjacentX,Y), Direction):- AdjacentX is X-1, Direction=u.
getAdjacentNode((X,Y), (AdjacentX,Y), Direction):- AdjacentX is X+1, Direction=d.
getAdjacentNode((X,Y), (X, AdjacentY), Direction):- AdjacentY is Y-1, Direction=l.
getAdjacentNode((X,Y), (X, AdjacentY), Direction):- AdjacentY is Y+1, Direction=r.

slideFromToDirection(Maze, (X,Y), (SlideX,SlideY), Direction):-
	getAdjacentNode((X,Y), (AdjX,AdjY), Direction),
	getValFromPosition(Maze, (AdjX,AdjY), Val),
	((isGoal(Val),SlideX is AdjX, SlideY is AdjY);
		(not(isWallOrPlayer(Val)),
			(slideFromToDirection(Maze, (AdjX, AdjY), (NextX, NextY), Direction)->
				(SlideX is NextX, SlideY is NextY); (SlideX is AdjX, SlideY is AdjY))
		)
	).

getPathToGoal(Maze, (X,Y), TempPath, Path):-
	slideFromToDirection(Maze, (X,Y), (AdjX,AdjY), Direction),
	append(TempPath, [Direction], NewPath),
	findInMaze(Maze, g, GoalPosition),
	(GoalPosition==(AdjX,AdjY)-> Path=NewPath;
		(length(NewPath, Length),
		Length < 10,
		getPathToGoal(Maze, (AdjX,AdjY), NewPath, Path)
		)).

%getValFromPosition(Maze, Position, Val)
getValFromPosition(Maze, (X,Y), Val):-
	nth0(X, Maze, Row), 
	nth0(Y, Row, Elem), 
	Val=Elem.

getShortestPath(Maze, (X,Y), ShortestPath):-
    setof((Length,Path), (getPathToGoal(Maze, (X,Y), [], Path), length(Path, Length)), SortedPaths),
    nth0(0, SortedPaths, (ShortestLength,_)),
    member((ShortestLength,ShortestPath), SortedPaths).


