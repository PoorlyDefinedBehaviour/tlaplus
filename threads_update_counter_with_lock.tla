---- MODULE threads_update_counter_with_lock ----
EXTENDS TLC, Sequences, Integers

CONSTANT NULL

NumThreads == 2
Threads == 1..NumThreads

(* --algorithm threads_update_counter_with_lock

variable 
    counter = 0;
    lock = NULL;

define 
    AllDone == \A thread \in Threads: pc[thread] = "Done"
    
    Correct == AllDone => counter = NumThreads
end define;

process thread \in Threads
variable 
    tmp = 0;
begin
    GetLock:
        await lock = NULL;
        lock := self;
    LoadCounter:
        tmp := counter;
    IncCounter:
        counter := tmp + 1;
    ReleaseLock:
        lock := NULL;
end process;

end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "2300262f" /\ chksum(tla) = "d23f15c1")
VARIABLES counter, lock, pc

(* define statement *)
AllDone == \A thread \in Threads: pc[thread] = "Done"

Correct == AllDone => counter = NumThreads

VARIABLE tmp

vars == << counter, lock, pc, tmp >>

ProcSet == (Threads)

Init == (* Global variables *)
        /\ counter = 0
        /\ lock = NULL
        (* Process thread *)
        /\ tmp = [self \in Threads |-> 0]
        /\ pc = [self \in ProcSet |-> "GetLock"]

GetLock(self) == /\ pc[self] = "GetLock"
                 /\ lock = NULL
                 /\ lock' = self
                 /\ pc' = [pc EXCEPT ![self] = "LoadCounter"]
                 /\ UNCHANGED << counter, tmp >>

LoadCounter(self) == /\ pc[self] = "LoadCounter"
                     /\ tmp' = [tmp EXCEPT ![self] = counter]
                     /\ pc' = [pc EXCEPT ![self] = "IncCounter"]
                     /\ UNCHANGED << counter, lock >>

IncCounter(self) == /\ pc[self] = "IncCounter"
                    /\ counter' = tmp[self] + 1
                    /\ pc' = [pc EXCEPT ![self] = "ReleaseLock"]
                    /\ UNCHANGED << lock, tmp >>

ReleaseLock(self) == /\ pc[self] = "ReleaseLock"
                     /\ lock' = NULL
                     /\ pc' = [pc EXCEPT ![self] = "Done"]
                     /\ UNCHANGED << counter, tmp >>

thread(self) == GetLock(self) \/ LoadCounter(self) \/ IncCounter(self)
                   \/ ReleaseLock(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in Threads: thread(self))
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION 
====
