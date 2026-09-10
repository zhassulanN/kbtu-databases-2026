\# Design Decision: Modeling Officer Positions



One design decision with multiple valid options was how to model officer

positions (president, treasurer, secretary).



\*\*Option A:\*\* Create a separate OfficerPosition entity with its own ID,

linked to Student and Club.



\*\*Option B (chosen):\*\* Model it as a `Role` attribute on the `MemberOf`

relationship between Student and Club.



I chose Option B because a position only has meaning in the context of a

specific student's membership in a specific club, and a student's role can

differ across different clubs (e.g. president in one club, regular member

in another). This keeps the schema simpler and avoids an extra table for

what is fundamentally a property of the membership relationship, not an

independent entity.

