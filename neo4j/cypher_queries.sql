--Q1

MATCH (n) RETURN n LIMIT 25

--Q2
MATCH (u:User) 
RETURN count(u) as UserCount

MATCH (t:Target) 
RETURN count(t) as TargetCount

MATCH ()-[a:Action]->() 
RETURN count(a) as ActionCount

--Q3

MATCH (U:User {USERID: "4"})-[A:Action]->(T:Target)
RETURN U.USERID as UserID, A.ACTIONID as ActionID, T.TARGETID as TargetID

--Q4

MATCH (U:User)-[A:Action]->()
RETURN U.USERID as UserID, count(A) as ActionCount


--Q5

MATCH (U:User)-[:Action]->(T:Target)
RETURN T.TARGETID as TargetID, count(distinct U) as UserCount

--Q6

MATCH (u:User)-[a:Action]->()
WITH count(a) as totalActions, count(distinct u) as totalUsers
RETURN totalActions * 1.0 / totalUsers as AvgActionsPerUser


--Q7

MATCH (U:User)-[A:Action]->(T:Target)
WHERE A.FEATURE2 > "0"
RETURN U.USERID as UserID, T.TARGETID as TargetID

--Q8

MATCH (T:Target)<-[A:Action]-()
WHERE A.LABEL = "1"
RETURN T.TARGETID as TargetID, count(A) as ActionCount


