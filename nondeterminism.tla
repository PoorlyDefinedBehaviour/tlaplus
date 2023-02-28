---- MODULE nondeterminism ----
EXTENDS TLC

Client == {1, 2, 3}

ParamType == {"A", "B", "C"}

RequestType == [
    from: Client,
    type: {"GET", "POST"},
    params: ParamType
]

(* --algorithm nondeterminism

macro request_resource(r) begin
    either
        reserved := reserved \union {r};
        failure_reason := ""
    or
        with reason \in {"unauthorized", "in_use", "other"} do 
            failure_reason := reason;
        end with;
    or 
        \* some other error
        skip;
    end either;
end macro;

with request \in RequestType do
    if request.type = "GET" then 
        \* get logic
    elsif request.type = "POST" then
        \* post logic
    else 
        \* something's wrong with the spec
        assert FALSE;
    end if;
end with;

end algorithm;*)
====