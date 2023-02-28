---- MODULE functions ----
EXTENDS TLC, Integers

Prod ==
    LET S == 1..10 IN 
    [p \in S \X S |-> p[1] * p[2]]

TruthTable == [p, q \in BOOLEAN |-> p => q]

IsSorted(seq) ==
    \A i, j \in 1..Len(seq):
        i < j => seq[i] <= seq[j]
====