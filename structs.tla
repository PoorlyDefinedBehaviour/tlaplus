---- MODULE structs ----
EXTENDS TLC, Integers, Sequences

struct == [a |-> 1, b |-> {}]

Accounts == {"ana", "bob"}

Amount == 1..10

\*This is the set of all structures where s.acct \in Accounts, s.amnt \in 1..10, etc.
BankTransactionType == [
    account: Accounts,
    amount: Amount,
    type: {"deposit", "withdraw"}
]

\*Find all values of a sequence
RangeSeq(seq) == {seq[i]: i \in 1..Len(seq)}

\*Find all keys of a struct
RangeStruct(s) == {s[key]: key \in DOMAIN s}

(* --algorithm structs
end algorithm;*)

====