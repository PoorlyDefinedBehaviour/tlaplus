---- MODULE reader_writer ----
EXTENDS TLC, Integers, Sequences

(* --algorithm reader_writer

VARIABLES 
    queue = <<>>;
    total = 0;

process writer = 1
VARIABLES 
    i = 0;
begin
    AddToQueue:
        while i < 2 do
            queue := append(queue, 1);
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
end process;

end algorithm;*)

====