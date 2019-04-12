:- ['Q1.pl'].



display_options([A]):- write(A), write(', unknown.'), nl.					% write final option in the option list
display_options([A|L]):- write(A), write(', '), display_options(L), !.	% this is to display all the options for player to choose


% query the team_size of the sport from the player
query_teamsize :-
		team_size(Options), 
		write('How many members are there in each team? Please choose from the following options: '), 
		display_options(Options), 
		read(X), 
		(
			member(X,Options)->assert(has(team_size, X)); 	% assert the fact for filtering
			X==unknown->assert(has(team_size, unknown)); 	% if player does not know, they can input unknown
			query_teamsize_loop(Options)
		).

% if the input is invalid, we enter the loop to query again
query_teamsize_loop(Options):- 
		write('Invalid input, Please input again:'), nl, 
		read(X), 
		(	
			member(X,Options)->assert(has(team_size, X)); 
			X==unknown->assert(has(team_size, unknown));
			X==end_of_file -> abort; 						% this is just to avoid the infinite loop situation when suddenly exit the program
			query_teamsize_loop(Options)
		).

% query the numberOfTeamPerGame of the sport from the player
query_numberOfTeamPerGame :-
		numberOfTeamPerGame(Options), 
		write('How many teams are there in each game? Please choose from the following options: '), 
		display_options(Options), 
		read(X), 
		(	
			member(X,Options)->assert(has(numberOfTeamPerGame, X));		% assert the fact for filtering
			X==unknown -> assert(has(numberOfTeamPerGame, unknown)); 	% if player does not know, they can input unknown
			query_numberOfTeamPerGame_loop(Options)
		).

% if the input is invalid, we enter the loop to query again
query_numberOfTeamPerGame_loop(Options):- 
		write('Invalid input, Please input again:'), nl, 
		read(X), 
		(	
			member(X,Options)->assert(has(numberOfTeamPerGame, X)); 
			X==unknown->assert(has(numberOfTeamPerGame, unknown)); 
			X==end_of_file->abort; 
			query_numberOfTeamPerGame_loop(Options)
		).

% query the arena_type of the sport from the player
query_arena_type :-
		arena_type(Options), 
		write('what type is the arena of the sport? Please choose from the following options: '), 
		display_options(Options), 
		read(X), 
		(	
			member(X,Options)->assert(has(arena_type, X)); 
			X==unknown->assert(has(arena_type, unknown)); 
			X==end_of_file->abort; 
			query_arenaType_loop(Options)
		).

% if the input is invalid, we enter the loop to query again
query_arenaType_loop(Options) :-
		write('Invalid input, Please input again:'), nl, 
		read(X), 
		(	
			member(X,Options)->assert(has(arena_type, X)); 
			X==unknown->assert(has(arena_type, unknown)); 
			X==end_of_file->abort; 
			query_arenaType_loop(Options)
		).

% query the arena_type of the sport from the player
% since one sport can have multiple involve playing device, this query keeps asking until player want to stop input
query_play_device :-
		play_device(Options), 
		write('Which pieces of device that the sport require? Please choose from the following options: '), 
		display_options(Options), 
		read(X), 
		(	
			member(X,Options) -> (	
									assert(has(play_device, X)), 
									query_play_device_loop(Options, valid)
								 );
			X==unknown -> assert(has(play_device, unknown)); 
			X==end_of_file -> abort; 
			query_play_device_loop(Options, invalid)
		).

% The Signal variable is to determine whether the loop results from invalid input or not
query_play_device_loop(Options, Signal) :- 
		Signal==valid, 
			write('Anything else? (input e to end question)'), nl, 			% input e whenever player want to stop input for this query
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(play_device, X)), 
										query_play_device_loop(Options, valid)
									 );
				X==unknown -> (
								print_alert,
								query_play_device_loop(Options, valid)
							  );
				X==e -> do_nothing ; 
				X==end_of_file -> abort; 
				query_play_device_loop(Options, invalid)
			);

		Signal==invalid, 
			write('Invalid input, Please input again:'), nl, 
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(play_device, X)),
										query_play_device_loop(Options, valid)
									 );
				X==unknown -> (	
								(has(play_device,Y), !) ->  (	% if the player has already input one option before, then the unknown options is no longer valid
																print_alert,
																query_play_device_loop(Options, valid)
															); 
								 assert(has(play_device, unknown))
							  );
				X==e-> do_nothing;
				X==end_of_file -> abort; 
				query_play_device_loop(Options, invalid)
			).

% query the game_mode of the sport from the player
% since one sport can have multiple mode, this query keeps asking until player want to stop input
query_gameMode :-
		game_mode(Options), 
		write('Which mode does the game follow? Please choose from the following options: '),
		display_options(Options), 
		read(X), 
		(	
			member(X,Options) -> (
									assert(has(game_mode, X)), 
									query_gameMode_loop(Options, valid)
								 );
			X==unknown -> assert(has(game_mode, unknown)); 
			X==end_of_file -> abort; 
			query_gameMode_loop(Options, invalid)
		).

% The Signal variable is to determine whether the loop results from invalid input or not
query_gameMode_loop(Options, Signal) :- 
		Signal==valid, 
			write('Anything else? (input e to end question)'), nl, 
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(game_mode, X)), 
										query_gameMode_loop(Options, valid)
									 );
				X==unknown -> (
								print_alert,
								query_gameMode_loop(Options, valid)
							  );
				X==e -> do_nothing ; 
				X==end_of_file -> abort; 
				query_gameMode_loop(Options, invalid)
			);

		Signal==invalid, 
			write('Invalid input, Please input again:'), nl, 
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(game_mode, X)),
										query_gameMode_loop(Options, valid)
									 );
				X==unknown -> (
								(has(game_mode,Y), !) -> (
															print_alert,
															query_gameMode_loop(Options, valid)
														 ); 
								 assert(has(game_mode, unknown))
							  );
				X==e -> do_nothing;
				X==end_of_file -> abort; 
				query_gameMode_loop(Options, invalid)
			).


% query the winning conditions of the sport from the player
% since one sport can have multiple winning conditions, this query keeps asking until player want to stop input
query_winCondition :-
		win_condition(Options), 
		write('What are the win conditions of the sport? Please choose from the following options: '),
		display_options(Options), 
		read(X), 
		(	
			member(X,Options) -> (
									assert(has(win_condition, X)), 
									query_winCondition_loop(Options, valid)
								 );
			X==unknown -> assert(has(win_condition, unknown)); 
			X==end_of_file -> abort; 
			query_winCondition_loop(Options, invalid)
		).

% The Signal variable is to determine whether the loop results from invalid input or not
query_winCondition_loop(Options, Signal) :-
		Signal==valid, 
			write('Anything else? (input e to end question)'), nl, 
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(win_condition, X)), 
										query_winCondition_loop(Options, valid)
									 );
				X==unknown -> (
								print_alert,
								query_winCondition_loop(Options, valid)
							  );
				X==e -> do_nothing;
				X==end_of_file -> abort;
				query_winCondition_loop(Options, invalid)
			);

		Signal==invalid, 
			write('Invalid input, Please input again:'), nl, 
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(win_condition, X)),
										query_winCondition_loop(Options, valid)
									 );
				X==unknown -> (	
								(has(win_condition,Y), !) -> (
																print_alert,
																query_winCondition_loop(Options, valid)
															 ); 
								 assert(has(win_condition, unknown))
							  );
				X==e -> do_nothing;
				X==end_of_file -> abort; 
				query_winCondition_loop(Options, invalid)
			).

query_numberOfRoundPerGame :-
		numberOfRoundPerGame(Options), 
		write('How many possible rounds are there in each game? Please choose from the following options: '),
		display_options(Options), 
		read(X), 
		(	
			member(X,Options) -> (
									assert(has(numberOfRoundPerGame, X)), 
									query_numberOfRoundPerGame_loop(Options, valid)
								 );
			X==unknown -> assert(has(numberOfRoundPerGame, unknown)); 
			X==end_of_file -> abort; 
			query_numberOfRoundPerGame_loop(Options, invalid)
		).

query_numberOfRoundPerGame_loop(Options, Signal) :-
		Signal==valid, 
			write('Anything else? (input e to end question)'), nl, 
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(numberOfRoundPerGame, X)), 
										query_numberOfRoundPerGame_loop(Options, valid)
									 );
				X==unknown -> (
								print_alert,
								query_numberOfRoundPerGame_loop(Options, valid)
							  );
				X==e -> do_nothing;
				X==end_of_file -> abort;
				query_numberOfRoundPerGame_loop(Options, invalid)
			);

		Signal==invalid, 
			write('Invalid input, Please input again:'), nl, 
			read(X), 
			(	
				member(X,Options) -> (
										assert(has(numberOfRoundPerGame, X)),
										query_numberOfRoundPerGame_loop(Options, valid)
									 );
				X==unknown -> (
								(has(numberOfRoundPerGame,Y), !) -> (
																		print_alert,
																		query_numberOfRoundPerGame_loop(Options, valid)
																	);
								 assert(has(numberOfRoundPerGame, unknown))
							  );
				X==e -> do_nothing;
				X==end_of_file -> abort; 
				query_numberOfRoundPerGame_loop(Options, invalid)
			).

% filter out from the given list the sports that satisfy the asserted fact
filter(Sports) :-
		findnsols(10, X, (member(X,Sports),check(X)), PossibleSports),
		displayPrediction(PossibleSports).

% check whether this sport satisfy all the asserted fact
check(Sport) :-
		forall(
			has(P,Q),
			(
				P==team_size -> (Q\=unknown -> teamsize(Sport, Q); do_nothing);
				P==numberOfTeamPerGame -> (Q\=unknown -> numberOfTeamPerGame(Sport, Q); do_nothing);
				P==arena_type -> (Q\=unknown -> arenaType(Sport, Q); do_nothing);
				P==play_device -> (Q\=unknown -> playDevice(Sport, Q); do_nothing);
				P==game_mode -> (Q\=unknown -> gameMode(Sport, Q); do_nothing);
				P==win_condition -> (Q\=unknown -> winCondition(Sport, Q); do_nothing);
				P==numberOfRoundPerGame -> (Q\=unknown -> numberOfRoundPerGame(Sport, Q); do_nothing)
			)
		),
		assert(is(Sport)).

% display the prediction to players
displayPrediction(PossibleSports) :-
		nl,
		(
			PossibleSports == [] -> write('There is no matched sports, maybe you are thinking of some other sport which is not mentioned on the sport list above!'), nl;
			write('The possible sport(s) that you are thinking of is(are) :'), write(PossibleSports), nl,
			write('------------------------'), nl, nl
		).

% this define the main structure of the game, such as the order of queries being asked.
% the variable I is to keep track of the loop counter. This program has to play five times with the player, hence I has to be from 1 to 5.
start(I) :- 
		I=<0 -> write('Please give command start(1). to start the game');
		I=<5 -> (
					write(I), write('-th time playing the game'), nl,
					write('Please think of one sport in the following list: football, badminton_single, swimming, basketball, taekwondo.'), nl,
					write('I will ask you some questions to guess which sport you are thinking of.'), nl, nl, 
					query_teamsize,
					query_numberOfTeamPerGame,
					query_arena_type,
					query_play_device,
					query_gameMode,
					query_winCondition,
					query_numberOfRoundPerGame,
					sports(Sports),
					filter(Sports),
					flush,
					N is I+1,
					start(N)
				);
		write('----------------------------------END GAME----------------------------------').

% player can input command 'play.' or 'start(1).' to play the game. This is just for convenience when inputting command
play :-
		nl,
		start(1).

% Retract all the asserted fact to play new game
flush :-
		retractall(has(X,Y)),
		retractall(is(Z)).

% When user already choose one option for a query but still input unknown. This should never be the case.
print_alert:-
	write('You already choose at least one option, the input can not be unknown anymore!!!'), nl.

do_nothing.
