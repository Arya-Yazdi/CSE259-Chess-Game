% Code only focuses on Task 1 (printing the chess board) of the chess game. 

main :-
    init_board(Board), % Initialize board with starting position.
    draw_board(8,8, Board).
main.

% Base case. Prints the last row of the grid, including  file characters at the very bottom.
draw_board(0, Col, Board) :- drawSymbol(' ', 1), % Print space before start of bottom line in grid.
                      draw_up_bot_border(Col),
                      nl,
                      draw_pair. % Prints file characters (a, b, c, d ...)

% Prints each row of the chess board (except the last, which is handled by the base case).
draw_board(Line, Col, Board):- Line > 0, % Print space below "1" in grid
                        drawSymbol(' ',1), % Print space before start of top line in grid
                        draw_up_bot_border(Col), % Draw horizonta line grid.
                        draw_content_line(Line, Col, Board), % Draw box sides. |    |
                        Line1 is Line-1,
                        draw_board(Line1, Col, Board).


% Stands for - draw up bottom border. 
% Base case. draw_up_bot_border() draws the horizontal line grids. +---+---+---+ 
draw_up_bot_border(0):- drawSymbol('+', 1), nl.
draw_up_bot_border(N):- N>0,
                        write('+'),
                        drawSymbol('-', 4),
                        N1 is N-1,
                        draw_up_bot_border(N1).


% Draws line number then calls the draw_content_cell() function to draw content of grid in each grid spot.
draw_content_line(Line, Col, Board):- drawSymbol(Line, 1),
                               draw_content_cell(Line, Col, Board),
                               nl.

% Function draws content inside of each square. Prints abbreviated piece name and * if piece color is black. 
draw_cell(Line, Col, Board):- pair(Name, Col), % Get file name of given column.
                              mymember(piece(Name-Line, Color, Piece), Board), % Check if piece is still on the board...
                              drawSymbol(' ', 1),
                              (
                                (Color == black, drawSymbol('*', 1)); % Print * to indicate piece is black.
                                (Color == white, drawSymbol(' ', 1))  % Don't print anything for white pieces.
                              ),
                              pair(Piece, Cap), % find abbreviation of piece name.
                              drawSymbol(Cap, 1),
                              drawSymbol(' ', 1).

% Function draws content inside of each square. Prints blank (4 spaces) when square has no pieces. 
draw_cell(Line, Col, Board):- pair(Name, Col), % Get file name of given column.
                              \+ (mymember(piece(Name-Line, Color, Piece), Board)), % \+ means negation. If piece is not on board...
                              drawSymbol(' ', 4).

% Draws left right grid lines and content of the given grid spot. 
draw_content_cell(Line, 0, Board):- drawSymbol('|', 1).
draw_content_cell(Line, C, Board):- C>0,
                             drawSymbol('|', 1),
                             % drawSymbol(' ', 4),
                             draw_cell(Line, C, Board), % Draw actual content inside the square.
                             C1 is C-1,
                             draw_content_cell(Line, C1, Board).

% Draws all File characters.
draw_pair:- 
            drawSymbol(' ', 4),
            drawSymbol('a', 1),
            drawSymbol(' ', 4),
            drawSymbol('b', 1),
            drawSymbol(' ', 4),
            drawSymbol('c', 1),
            drawSymbol(' ', 4),
            drawSymbol('d', 1),
            drawSymbol(' ', 4),
            drawSymbol('e', 1),
            drawSymbol(' ', 4),
            drawSymbol('f', 1),
            drawSymbol(' ', 4),
            drawSymbol('g', 1),
            drawSymbol(' ', 4),
            drawSymbol('h', 1).


% Links Rank with File. Line is usually used instead of Rank in the code.
pair(a, 8).
pair(b, 7).
pair(c, 6).
pair(d, 5).
pair(e, 4).
pair(f, 3).
pair(g, 2).
pair(h, 1).

% Links piece name with abbreviation.
pair(rook, r).
pair(bishop, b).
pair(king, k).
pair(pawn, p).
pair(queen, q).
pair(night, n).


%%  HELPER FUNCTION: DRAWING N NUMBER OF SYMBOLS  %%
% Base case.
drawSymbol(_, 0). 
% Recursion Step.
drawSymbol(Symbol, N) :- 
    N>0,
    write(Symbol),
    N1 is N-1,
    drawSymbol(Symbol, N1).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code below is taken from chess.pl %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to check if element is in a given list
mymember(X, [X|_]).
mymember(X, [_|L]) :-
	mymember(X, L).

init_board( [
 	state(white, WhiteKing, WhiteKingRook, WhiteQueenRook),
	state(black, BlackKing, BlackKingRook, BlackQueenRook),
	piece(a-8, black, rook  ), piece(b-8, black, night ),
	piece(c-8, black, bishop), piece(d-8, black, queen ),
	piece(e-8, black, king  ), piece(f-8, black, bishop),
	piece(g-8, black, night ), piece(h-8, black, rook  ),
	piece(a-7, black, pawn  ), piece(b-7, black, pawn  ),
	piece(c-7, black, pawn  ), piece(d-7, black, pawn  ),
	piece(e-7, black, pawn  ), piece(f-7, black, pawn  ),
	piece(g-7, black, pawn  ), piece(h-7, black, pawn  ),
	piece(a-1, white, rook  ), piece(b-1, white, night ),
	piece(c-1, white, bishop), piece(d-1, white, queen ),
	piece(e-1, white, king  ), piece(f-1, white, bishop),
	piece(g-1, white, night ), piece(h-1, white, rook  ),
	piece(a-2, white, pawn  ), piece(b-2, white, pawn  ),
	piece(c-2, white, pawn  ), piece(d-2, white, pawn  ),
	piece(e-2, white, pawn  ), piece(f-2, white, pawn  ),
	piece(g-2, white, pawn  ), piece(h-2, white, pawn  ) ]).