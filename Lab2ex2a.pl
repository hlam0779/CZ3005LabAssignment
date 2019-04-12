male(charles).
male(andrew).
male(edward).

female(ann).

older(charles, ann).
older(ann, andrew).
older(andrew,edward).

olderThan(A,B) :- older(A,B).
olderThan(A,B) :-
	older(A,C),
	older(C,B).

sameGender(A,B) :- male(A),male(B).
sameGender(A,B) :- female(A),female(B).
		
larger(A,B) :- male(A),female(B).
larger(A,B) :- 
		sameGender(A,B),
		A \= B,
		olderThan(A,B).

successionList([A,B,C,D]) :- 
		larger(A,B),
		larger(B,C),
		larger(C,D).
		
	
		