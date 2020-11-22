:- use_module(rules).
:- begin_tests(rules).

test('Can remove adjacent tiles of same type') :-
  board:init_board([
    % 1  2  3  4
    [ ♢, ♢, ♢, ♢ ], % 1
    [ ♢, ♣, ♣, ♢ ], % 2
    [ ♢, ♣, ♢, ♢ ], % 3
    [ ♢, ♢, ♢, ♢ ]  % 4
  ]),
  rules:can_remove_tiles([2, 2], [2, 3]),
  rules:can_remove_tiles([2, 2], [3, 2]).

test('Cannot remove tiles of different type') :-
  board:init_board([
    % 1  2
    [ ♣, ♥ ] % 1
  ]),
  \+ rules:can_remove_tiles([1, 1], [1, 2]).

test('Can remove tiles connected by straight path') :-
  board:init_board([
    % 1  2  3  4  5
    [ ♢, ♢, ♢, ♥, ♢ ], % 1
    [ ♣, -, -, -, ♣ ], % 2
    [ ♢, ♢, ♢, ♥, ♢ ]  % 3
  ]),
  rules:can_remove_tiles([1, 2], [5, 2]),
  rules:can_remove_tiles([4, 1], [4, 3]).

test('Can remove tiles connected by path with 1 turn') :-
  board:init_board([
    % 1  2  3  4  5
    [ ♢, ♣, ♢, ♢, ♢ ], % 1
    [ ♢, -, ♢, ♢, ♢ ], % 2
    [ ♢, -, -, -, ♣ ], % 3
    [ ♢, ♢, ♢, ♢, ♢ ]  % 4
  ]),
  rules:can_remove_tiles([2, 1], [5, 3]).

test('Can remove tiles connected by path with 2 turns') :-
  board:init_board([
    % 1  2  3  4  5
    [ ♢, ♢, ♢, ♢, ♢ ], % 1
    [ ♢, ♣, ♢, ♢, ♢ ], % 2
    [ ♢, -, ♢, ♣, ♢ ], % 3
    [ ♢, -, -, -, ♢ ], % 4
    [ ♢, ♢, ♢, ♢, ♢ ]  % 5
  ]),
  rules:can_remove_tiles([2, 2], [4, 3]).

test('Can remove tiles connected by path with 2 turns outside board') :-
  board:init_board([
    % 1  2  3  4 
    [ ♣, ♢, ♢, ♣ ], % 1
    [ ♢, ♢, ♢, ♢ ], % 2
    [ ♣, ♢, ♣, ♢ ]  % 3
  ]),
  rules:can_remove_tiles([1, 1], [4, 1]),
  rules:can_remove_tiles([1, 1], [1, 3]),
  rules:can_remove_tiles([1, 3], [3, 3]).

test('Cannot remove not connected tiles') :-
  board:init_board([
    % 1  2  3  4 
    [ ♢, ♣, ♢, ♢ ], % 1
    [ ♢, ♢, ♢, ♢ ], % 2
    [ ♢, ♣, ♢, ♣ ], % 3
    [ ♢, ♢, ♢, ♢ ]  % 4
  ]),
  \+ rules:can_remove_tiles([2, 1], [2, 3]),
  \+ rules:can_remove_tiles([2, 1], [4, 3]),
  \+ rules:can_remove_tiles([2, 3], [4, 3]).

:- end_tests(rules).
