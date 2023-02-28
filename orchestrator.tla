---- MODULE orchestrator ----
EXTENDS TLC, Integers, FiniteSets

Servers == {"s1", "s2"}

(* --algorithm threads

variable 
    online = Servers;

process orchestrator = "orchestrator"
begin
    Change:
        while TRUE do
            with s \in Servers do 
                either
                    await s \notin online;
                    online := online \union {s};
                or
                    await s \in online;
                    await Cardinality(online) > 1;
                    online := online \ {s};
                end either;
            end with;
        end while;
end process;

end algorithm;*)

====