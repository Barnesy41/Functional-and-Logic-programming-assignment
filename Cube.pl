main :-
    generator4(XS), tester4(XS), write(XS).

%generator function
generator4(N) :-
	permutation([1,2,3,4,5,6,7,8,9,0], P),
	arrangeRun(P, N).

% returns true if a number is prime, 
% false otherwise
isPrime(2).
isPrime(3).
isPrime(N) :-
    N > 1,
    \+ hasFactor(N, 2).

% checks if a number has a factor between W and sqrt(N)
hasFactor(N, W) :-
    W * W =< N,
    N mod W =:= 0.
hasFactor(N, W) :-
    W * W < N,
    W1 is W + 1,
    hasFactor(N, W1).

% converts a list of integers to a singular
% integer
toInt([], 0).
toInt([H|T], R) :-
    toInt(T, R1),
    length(T, TLength),
    Acc is 10^TLength,
    R is H*Acc + R1.

% checks if a list begins with the digit 0
startsZero([H|_]) :-
    H =\= 0.

% arrange 10 ints into runs
arrangeRun([], []).
arrangeRun(X, [P | T]) :-
    append(P, R, X),
    length(P, L),
    startsZero(P), % doesn't start with a zero
    L =< 4,
    toInt(P, N),
    isPrime(N),
    arrangeRun(R, T).

% generator test function
x_generator4(N) :-
    x_generator4_loop(
        [
            [[9, 6, 7], [4, 0, 1], [2, 8, 3], [5]],
            [[9, 8, 3], [6, 0, 1], [5], [4, 7], [2]],
            [[9, 8, 3], [6, 7], [4, 2, 0, 1], [5]],
            [[9, 8, 5, 1], [2], [4, 3], [6, 0, 7]],
            [[9, 8, 5, 1], [2], [3], [6, 0, 4, 7]],
            [[9, 8, 5, 1], [2], [7], [4, 6, 0, 3]],
            [[8, 9], [7], [6, 0, 1], [2, 5, 4, 3]],
            [[8, 9], [7], [5, 6, 3], [4, 0, 2, 1]],
            [[8, 9], [5], [4, 7], [6, 0, 1], [3], [2]],
            [[3], [5], [6, 0, 7], [2], [4, 1], [8, 9]]
        ],
        0,
        N
    ).

x_generator4_loop([], C, C).
x_generator4_loop([T | TS], C, N) :-
    generator4(T),
    C1 is C + 1,
    x_generator4_loop(TS, C1, N).
x_generator4_loop([_ | TS], C, N) :-
    x_generator4_loop(TS, C, N).



% Q 4.2
tester4(N) :-
    runToInts(N, Ints),
	discardSmallestPrime(Ints, R),
    revSort(R, RDesc), % sort in descending order
    digits(RDesc, Run),
    arrangeTRun(Run, _).

% Converts a run into a list of ints,
runToInts([],[]).
runToInts([H|T], R) :-
    toInt(H, Int),
    runToInts(T, R1),
    append([Int], R1, R).
    
% discards the run that contains the smallest prime
discardSmallestPrime(List, R) :-   
	min_list(List, Min),
    delete(List, Min, R).

% returns true if a number is cube,
% false otherwise.
% The helper function for hasCubes
isCube(N) :-
    CubeRoot is round(N^(1/3)),
    Cube is CubeRoot^3,
    Cube =:= N.

% arrange the runs
% arrange 10 ints into runs
arrangeTRun([], []).
arrangeTRun(X, [P | T]) :-
    append(P, R, X),
    length(P, L),
    startsZero(P), % doesn't start with a zero
    L =< 4,
    toInt(P, N),
    isCube(N),
    arrangeTRun(R, T).

% takes in a list i.e. [827, 409, 61] and
% converts it to a list of digits i.e.
% [8, 2, 7, 4, 0, 9, 6, 1]
digits([], []).
digits([H|T], R) :-
    intToList(H, Ints),
    append(Ints, R1, R),
    digits(T, R1).

% Sort a list in reverse order
revSort(UnsortedList, RevSortedList) :-
    sort(UnsortedList, SortedList),
    reverse(SortedList, RevSortedList).

% Converts an integer to an array of digits
% IN REVERSE ORDER
intToRevList(0, []).
intToRevList(Int, [H|T]) :-
    Int > 0,
    H is Int mod 10,
    Int2 is Int div 10,
    intToRevList(Int2, T).

% Converts an integer to an array of digits
intToList(0, []).
intToList(Int, List) :-
    intToRevList(Int, RevList),
    reverse(RevList, List).

%tester test function
x_tester4( N ) :-
x_tester4_loop(
[ [[8 ,2 ,7] ,[6 ,1] ,[5 ,3] ,[4 ,0 ,9]]
, [[8 ,2 ,7] ,[6 ,1] ,[4 ,0 ,9] ,[5 ,3]]
, [[8 ,2 ,7] ,[5 ,3] ,[6 ,1] ,[4 ,0 ,9]]
, [[8 ,2 ,7] ,[4 ,0 ,9] ,[6 ,1] ,[5 ,3]]
, [[6 ,1] ,[8 ,2 ,7] ,[4 ,0 ,9] ,[5 ,3]]
, [[6 ,1] ,[4 ,0 ,9] ,[5 ,3] ,[8 ,2 ,7]]
, [[5 ,3] ,[6 ,1] ,[4 ,0 ,9] ,[8 ,2 ,7]]
, [[5 ,3] ,[4 ,0 ,9] ,[6 ,1] ,[8 ,2 ,7]]
, [[4 ,0 ,9] ,[5 ,3] ,[8 ,2 ,7] ,[6 ,1]]
, [[4 ,0 ,9] ,[8 ,2 ,7] ,[6 ,1] ,[5 ,3]] ] , 0 , N ) .
x_tester4_loop( [] , C , C ) .
x_tester4_loop( [ T | TS ] , C , N ) :-
tester4( T ) ,
C1 is C + 1 ,
x_tester4_loop( TS , C1 , N ) .
x_tester4_loop( [ _ | TS ] , C , N ) :-
x_tester4_loop( TS , C , N ) .