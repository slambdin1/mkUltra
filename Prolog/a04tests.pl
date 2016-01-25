printPaths([]).
printPaths([Path|Paths]):-
    writeln(Path),
    printPaths(Paths).

loadHelpers:-
    	['helpers.pl'],
    	['csce322a04part01.pl'],
	['csce322a04part02.pl'],
	['csce322a04part03.pl'],
	['csce322a04part04.pl'].

part01:-
    readMazeGame('part01test01.m',Maze),
    printMazeGame(Maze),
    colsAndPlayers(Maze).
    
part02:-
    readMazeGame('part01test01.m',Maze),
    printMazeGame(Maze),
    setof(Path,fewestSlides(Maze,Path),Paths),
    writeln(paths),
    printPaths(Paths).

part03:-
    readMazeGame('part01test01.m',Maze),
    printMazeGame(Maze),
    noAdvantage(Maze).

part04:-
    readMazeGame('part01test01.m',Maze),
    printMazeGame(Maze),
    goalWall(Maze).
