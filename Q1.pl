:- dynamic has/1, is/1.


sports([football, badminton_single, swimming, basketball, taekwondo]).

teamsize(football, 11).
teamsize(badminton_single, 1).
teamsize(swimming, 1).
teamsize(basketball, 5).
teamsize(taekwondo, 1).


numberOfTeamPerGame(football, 2).
numberOfTeamPerGame(badminton_single, 2).
numberOfTeamPerGame(swimming, many).
numberOfTeamPerGame(basketball, 2).
numberOfTeamPerGame(taekwondo, 2).

arenaType(football, field).
arenaType(badminton_single, court).
arenaType(swimming, pool).
arenaType(basketball, court).
arenaType(taekwondo, mats).

playDevice(football, ball).
playDevice(badminton_single, shuttleCock).
playDevice(badminton_single, racket).
playDevice(basketball, ball).
playDevice(swimming, water).
playDevice(taekwondo, nothing).

gameMode(football, timed).
gameMode(badminton_single, timed).
gameMode(basketball, timed).
gameMode(swimming, timed).
gameMode(taekwondo, timed).
gameMode(taekwondo, knock_out).

winCondition(football, higher_score).
winCondition(badminton_single, higher_score).
winCondition(basketball, higher_score).
winCondition(swimming, shortest_time).
winCondition(taekwondo, knock_out).
winCondition(taekwondo, higher_score).

numberOfRoundPerGame(football, 2).
numberOfRoundPerGame(football, 3).
numberOfRoundPerGame(badminton_single, 3).
numberOfRoundPerGame(basketball, 4).
numberOfRoundPerGame(swimming, 1).
numberOfRoundPerGame(taekwondo, 3).


team_size([1,5,11]).
numberOfTeamPerGame([2, many]).
arena_type([field, court, pool, mats]).
play_device([ball, racket, shuttleCock, water, nothing]).
game_mode([knock_out, timed]).
win_condition([higher_score, shortest_time, knock_out]).
numberOfRoundPerGame([1,2,3,4]).

has(nothing).
is(nothing).