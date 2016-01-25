goalWall(Maze):- 
	findInMaze(Maze, g, Location), 
	(isRightToWall(Location, Maze); 
		isLeftToWall(Location, Maze); 
		isBelowToWall(Location, Maze); 
		isAboveToWall(Location, Maze)).

isWall(Element):- Element == x.

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

isRightToWall((X,Y), Maze):- 
	RowNum is X,
	ColNum is Y-1,
	nth0(RowNum, Maze, Row), 
	nth0(ColNum, Row, Elem), 
	isWall(Elem).

isLeftToWall((X,Y), Maze):- 
	RowNum is X,
	ColNum is Y+1,
	nth0(RowNum, Maze, Row), 
	nth0(ColNum, Row, Elem), 
	isWall(Elem).

isAboveToWall((X,Y), Maze):-
	RowNum is X-1,
	ColNum is Y, 
	nth0(RowNum, Maze, Row), 
	nth0(ColNum, Row, Elem), 
	isWall(Elem).

isBelowToWall((X,Y), Maze):-
	RowNum is X+1,
	ColNum is Y, 
	nth0(RowNum, Maze, Row), 
	nth0(ColNum, Row, Elem), 
	isWall(Elem).

