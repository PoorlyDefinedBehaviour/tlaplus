---- MODULE operators_and_values ----

Abs(x) == IF x < 0 THEN -x ELSE x

Xor(A, B) == A = ~B

ClockType == (0..23) \X (0..59) \X (0..59)

Squares == {x * x: x \in 1..4}

Evens == {x \in 1..4: x % 2 = 0}

TimesInTheSecondHalfOfEachOur == {t \in ClockType: t[2] >= 30 /\ t[3] = 0}

Range(seq) == {seq[i]: i \in 1..Len(seq)}

ToClock(seconds) == CHOOSE x \in ClockType: ToSeconds(x) = seconds % 86400

ToClock(seconds) ==
    LET seconds_per_day == 86400
    IN CHOOSE x \in ClockType: ToSeconds(x) = seconds % seconds_per_day

ThreeMax(a, b, c) ==
    LET 
        Max(x, y) == IF x > y THEN x ELSE y
        maxab == Max(a, b)
    IN 
        Max(maxab, c)
====