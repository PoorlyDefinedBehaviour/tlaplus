---- MODULE quantifiers ----
EXTENDS TLC

(* --algorithm quantifiers

\A x \in {1, 2, 3}: x < 2

IsComposite(num) ==
    \E m, n \in 2..num:
        m * n = num

Contains(seq, elem) ==
    \E i \in 1..Len(seq):
        seq[i] = elem

BrokenIsUnique(s) ==
    \A i, j \in 1..Len(s):
        s[i] # s[j]

IsUnique(s) ==
    \A i, j \in 1..Len(s):
        i # j => s[i] # s[j]

end algorithm; *)

====