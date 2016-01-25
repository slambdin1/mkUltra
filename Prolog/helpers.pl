:- module( helpers,
	 [ readMazeGame/2
	 , printMazeGame/1
	 ]
    ).

readMazeGame(File,Maze):-
    open(File,read,Input),
    readMaze(Input,Maze),
    close(Input).

readMaze(Input,[]):-
    at_end_of_stream(Input),
    !.
readMaze(Input,[Row|Rows]):-
    \+ at_end_of_stream(Input),
    read(Input,Row),
    readMaze(Input,Rows).

printMazeGame([]).
printMazeGame([Row|Rows]):-
    writeln(Row),
    printMazeGame(Rows).
