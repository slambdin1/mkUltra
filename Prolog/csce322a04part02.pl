fewestSlides(Maze,PathToGoal):- 
	findInMaze(Maze, 1, PlayerPosition),
	getShortestPath(Maze, PlayerPosition, ShortestPath),
	PathToGoal=ShortestPath.

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

isWallOrPlayer(Element):- (Element==x; member(Element,[2,3,4])).

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
