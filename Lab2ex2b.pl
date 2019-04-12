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

successionList([A,B,C,D]) :- 
		olderThan(A,B),
		olderThan(B,C),
		olderThan(C,D).
		
	
		