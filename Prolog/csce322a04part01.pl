colsAndPlayers([Row|Rows]):- 
	length(Row, NumOfCols),numberOfPlayers([Row|Rows], Playa), (even(NumOfCols) -> even(Playa) ; odd(Playa)).

even(N):- N rem 2 =:= 0.
odd(N):- N rem 2 =:= 1.

isValidPlayer(Num):- member(Num,[1,2,3,4]).

addNumbers(X,Y,Z):- Z is X+Y.

numberOfPlayersHelper([],0).
numberOfPlayersHelper([Y|T],N1):- isValidPlayer(Y),numberOfPlayersHelper(T,N2),N1 is N2+1,!.
numberOfPlayersHelper([_|T],N1):- numberOfPlayersHelper(T,N1).

numberOfPlayers([],0).
numberOfPlayers([X|T],FinalNum):- 
	numberOfPlayersHelper(X,NewNum),
	numberOfPlayers(T,TempNum),
	addNumbers(NewNum, TempNum, Sum),
	FinalNum is Sum.