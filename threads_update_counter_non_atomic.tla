---- MODULE threads_update_counter_non_atomic ----
EXTENDS TLC, Sequences, Integers

NumThreads == 2
Threads == 1..NumThreads

(* --algorithm threads_update_counter_non_atomic

variable 
    counter = 0;

define 
    AllDone == \A thread \in Threads: pc[thread] = "Done"
    
    Correct == AllDone => counter = NumThreads
end define;

process thread \in Threads
variable 
    tmp = 0;
begin
    LoadCounter:
        tmp := counter;
    IncCounter:
        counter := tmp + 1;
end process;

end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "58521225" /\ chksum(tla) = "be15280c")
VARIABLES counter, pc

(* define statement *)
AllDone == \A thread \in Threads: pc[thread] = "Done"

Correct == AllDone => counter = NumThreads

VARIABLE tmp

vars == << counter, pc, tmp >>

ProcSet == (Threads)

Init == (* Global variables *)
        /\ counter = 0
        (* Process thread *)
        /\ tmp = [self \in Threads |-> 0]
        /\ pc = [self \in ProcSet |-> "LoadCounter"]

LoadCounter(self) == /\ pc[self] = "LoadCounter"
                     /\ tmp' = [tmp EXCEPT ![self] = counter]
                     /\ pc' = [pc EXCEPT ![self] = "IncCounter"]
                     /\ UNCHANGED counter

IncCounter(self) == /\ pc[self] = "IncCounter"
                    /\ counter' = tmp[self] + 1
                    /\ pc' = [pc EXCEPT ![self] = "Done"]
                    /\ tmp' = tmp

thread(self) == LoadCounter(self) \/ IncCounter(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in Threads: thread(self))
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION 
====
