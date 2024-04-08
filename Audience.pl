main :-
    generator3(X), tester3(X), write(X).

% Generator 3
generator3(N) :-
	between(1000, 1000000, N),
    find_root_as_int(N, Root),
    RootSquared is Root * Root,
    N = RootSquared.

% finds the square root of a number
% then converts the answer to an integer
find_root_as_int(Number, Root) :-
    Root is floor(sqrt(Number)),
    Root * Root =:= Number.

% generator3 tester
x_generator3(N) :-
x_generator3_loop(
[ 1024 , 9409 , 23716 , 51529
, 123904 , 185761 , 868624 , 962361
, 982081 , 1000000 ] , 0 , N ) .
x_generator3_loop( [] , C , C ) .
x_generator3_loop( [ T | TS ] , C , N ) :-
generator3( T ) ,
C1 is C + 1 ,
x_generator3_loop( TS , C1 , N ) .
x_generator3_loop( [ _ | TS ] , C , N ) :-
x_generator3_loop( TS , C , N ) .

% tester3
tester3(N) :-
    digits(N, NS),
    different(NS),
    length(NS, Len), % find the length of NS
    lastDigit(NS, LD), %find the last digit of NS
    LD =:= Len,
    LastButOne is Len - 1,
    getDigit(LastButOne, NS, LDB1),
    isOdd(LDB1),
    containsZero(NS),
    getDigit(1, NS, D1),
    getDigit(2, NS, D2),
    getDigit(3, NS, D3),
    isMultipleOf(D2,D1),
    isMultipleOf(D3,D1),
    isMultipleOf(LDB1,D1).

% divmod predicate
div_mod(A, B, C, R) :-
    C is A div B,
    R is A mod B.

% convert an integer to a list of digits
digits(N, [N]) :-
    N < 10.
digits(N, X) :-
    N >= 10,
    div_mod(N, 10, D, M),
    digits(D,R),
    append(R, [M], X).

% Checks that the digits are different
different([]).
different([H|T]) :-
    \+ member(H,T), different(T).
   
% Finds the last digit of a list
lastDigit([D], D).
lastDigit([_|T], D) :-
    lastDigit(T, D).
    
% Gets the lastButOneDigit
lastButOneDigit([D, _], D).
lastButOneDigit([H|T], _) :-
    lastButOneDigit(T, H).

% Gets the digit in the specified index of a list
% (1 indexed)
getDigit(N,[_|T], D) :-
    N1 is N - 1,
    N1>0,
    getDigit(N1, T, D).
getDigit(N, [H|_], D) :-
    N1 is N - 1, 
    N1 =:= 0,
    D is H.

% Checks if a given digit is odd
isOdd(D) :-
    D mod 2 =:= 1.
    
% returns if a list of integers contains a zero
% returns 1 if true, and 0 if false.
containsZero([]) :-
    false.
containsZero([H|_]) :-
    H =:= 0,
    !.
containsZero([_|T]) :-
    containsZero(T).

% returns if A is a multiple of B
isMultipleOf(A, B) :-
    0 is A mod B,
    A>0. %0 is not a multiple

% tester3 tester
x_tester3( N ) :-
x_tester3_loop(
[ 123056 , 128036 , 139076 , 142076
, 148056 , 159076 , 173096 , 189036
, 193056 , 198076 ] , 0 , N ) .
x_tester3_loop( [] , C , C ) .
x_tester3_loop( [ T | TS ] , C , N ) :-
tester3( T ) ,
C1 is C + 1 ,
x_tester3_loop( TS , C1 , N ) .
x_tester3_loop( [ _ | TS ] , C , N ) :-
x_tester3_loop( TS , C , N ) .