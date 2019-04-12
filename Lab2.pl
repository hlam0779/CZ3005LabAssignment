competitor(sumSum, appy).
smartPhoneTech(galacticaS3).
develop(sumSum, galacticaS3).
boss(stevey).
steal(stevey, galacticaS3).
rival(X) :- competitor(X, appy).

unethical(X) :- boss(X), 
		rival(Y), 
		business(Z), 
		develop(Y,Z), 
		steal(X,Z).

business(X) :- smartPhoneTech(X).