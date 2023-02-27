---- MODULE invariant ----
EXTENDS TLC, Integers, Sequences, FiniteSets

S == 1..10

(* --algorithm duplicates

variable
    seq \in S \X S \X S \X S; 
    index = 1;
    seen = {};
    is_unique = TRUE;
    
define
    IsUnique(s) ==
        \A i, j \in 1..Len(s):
            i # j => s[i] # s[j]
    
    IsCorrect == pc = "Done" => is_unique = IsUnique(seq)
end define;

begin
    Iterate:
        while index <= Len(seq) do
            if seq[index] \notin seen then
                seen := seen \union {seq[index]};
            else
                is_unique := FALSE;
            end if;
            index := index + 1;
        end while;
end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "3f37da53" /\ chksum(tla) = "38b3e071")
VARIABLES seq, index, seen, is_unique, pc

(* define statement *)
IsUnique(s) ==
    \A i, j \in 1..Len(s):
        i # j => s[i] # s[j]

IsCorrect == pc = "Done" => is_unique = IsUnique(seq)


vars == << seq, index, seen, is_unique, pc >>

Init == (* Global variables *)
        /\ seq \in S \X S \X S \X S
        /\ index = 1
        /\ seen = {}
        /\ is_unique = TRUE
        /\ pc = "Iterate"

Iterate == /\ pc = "Iterate"
           /\ IF index <= Len(seq)
                 THEN /\ IF seq[index] \notin seen
                            THEN /\ seen' = (seen \union {seq[index]})
                                 /\ UNCHANGED is_unique
                            ELSE /\ is_unique' = FALSE
                                 /\ seen' = seen
                      /\ index' = index + 1
                      /\ pc' = "Iterate"
                 ELSE /\ pc' = "Done"
                      /\ UNCHANGED << index, seen, is_unique >>
           /\ seq' = seq

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Iterate
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 
====
