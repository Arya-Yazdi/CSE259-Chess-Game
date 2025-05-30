%%  HELPER FUNCTION: DRAWING N NUMBER OF SYMBOLS  %%
% Base case.
drawSymbol(_, 0). 
% Recursion Step.
drawSymbol(Symbol, N) :- 
    N>0,
    write(Symbol),
    N1 is N-1,
    drawSymbol(Symbol, N1).



main.
main :- draw_board(8,8).

% Base case. Prints the last row of the grid, including  file characters at the very bottom.
draw_board(0, Col) :- drawSymbol(' ', 1), % Print space before start of bottom line in grid.
                      draw_up_bot_border(Col),
                      nl,
                      draw_pair. % Prints file characters (a, b, c, d ...)

draw_board(Line, Col):- Line > 0, % Print space below "1" in grid
                        drawSymbol(' ',1), % Print space before start of top line in grid
                        draw_up_bot_border(Col), % Draw horizonta line grid.
                        draw_content_line(Line, Col), % Draw box sides. |    |
                        Line1 is Line-1,
                        draw_board(Line1, Col).


% Stands for - draw up bottom border. 
% Base case. draw_up_bot_border() draws the horizontal line grids. +---+---+---+ 
draw_up_bot_border(0):- drawSymbol('+', 1), nl.
draw_up_bot_border(N):- N>0,
                        write('+'),
                        drawSymbol('-', 4),
                        N1 is N-1,
                        draw_up_bot_border(N1).


% Draws line number then calls the draw_content_cell() function to draw content of grid in each grid spot.
draw_content_line(Line, Col):- drawSymbol(Line, 1),
                               draw_content_cell(Line, Col),
                               nl.

draw_cell(Line, C):- pair(File, C),
                     drawSymbol(' ', 1),
                     drawSymbol(File, 1),
                     drawSymbol(Line, 1),
                     drawSymbol(' ', 1).

% Draws content of the given grid spot. 
draw_content_cell(Line, 0):- drawSymbol('|', 1).
draw_content_cell(Line, C):- C>0,
                             drawSymbol('|', 1),
                             % drawSymbol(' ', 4),
                             draw_cell(Line, C),
                             C1 is C-1,
                             draw_content_cell(Line, C1).

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