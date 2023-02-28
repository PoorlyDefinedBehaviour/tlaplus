---- MODULE threads_update_counter_atomic ----
EXTENDS TLC, Sequences, Integers

NumThreads == 2
Threads == 1..NumThreads

(* --algorithm threads_update_counter_atomic

variable 
    counter = 0;

define 
    AllDone == \A thread \in Threads: pc[thread] = "Done"
    
    Correct == AllDone => counter = NumThreads
end define;

process thread \in Threads
begin
    IncCounter:
        counter := counter + 1;
end process;

end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "976fb528" /\ chksum(tla) = "2d848943")
VARIABLES counter, pc

(* define statement *)
AllDone == \A thread \in Threads: pc[thread] = "Done"

Correct == AllDone => counter = NumThreads


vars == << counter, pc >>

ProcSet == (Threads)

Init == (* Global variables *)
        /\ counter = 0
        /\ pc = [self \in ProcSet |-> "IncCounter"]

IncCounter(self) == /\ pc[self] = "IncCounter"
                    /\ counter' = counter + 1
                    /\ pc' = [pc EXCEPT ![self] = "Done"]

thread(self) == IncCounter(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in Threads: thread(self))
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION 

====
