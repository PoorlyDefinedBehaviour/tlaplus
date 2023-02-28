---- MODULE process_sets ----
EXTENDS TLC, Integers, Sequences

Writers == {1, 2, 3}

(* --algorithm process_sets

VARIABLES 
    queue = <<>>;
    total = 0;

process writer \in Writers
VARIABLES 
    i = 0;
begin
    AddToQueue:
        while i < 2 do
            queue := append(queue, self);
            i := i + 1;
        end while;
end process;

process reader = 0
begin
    ReadFromQueue:
        if queue # <<>> then 
            total := total + Head(queue);
            queue := Tail(queue);
        end if;
        goto ReadFromQueue;
end process;

end algorithm;*)

====