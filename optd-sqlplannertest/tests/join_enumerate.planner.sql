-- (no id or description)
create table t1(t1v1 int, t1v2 int);
create table t2(t2v1 int);
create table t3(t3v2 int);
insert into t1 values (0, 0), (1, 1), (2, 2);
insert into t2 values (0), (1), (2);
insert into t3 values (0), (1), (2);

/*
3
3
3
*/

-- Test whether the optimizer enumerates all join orders.
select * from t2, t1, t3 where t1v1 = t2v1 and t1v2 = t3v2;

/*
(Join (Join t3 t1) t2)
(Join t2 (Join t3 t1))
(Join t2 (Join t1 t3))
(Join (Join t1 t2) t3)
(Join t3 (Join t2 t1))
(Join (Join t2 t1) t3)
(Join t3 (Join t1 t2))
(Join (Join t1 t3) t2)
*/

-- Test whether the optimizer enumerates all join orders.
select * from t1, t2, t3 where t1v1 = t2v1 and t1v2 = t3v2;

/*
(Join (Join t2 t1) t3)
(Join (Join t1 t2) t3)
(Join t3 (Join t2 t1))
(Join t3 (Join t1 t2))
*/

