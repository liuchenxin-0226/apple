老蔡经验：
1、读一下题目，找"的"，他的右边就是我们要的字段，select出来
2、这些字段来自什么表，找出来，from一下
3、如果是多表，马上写出他们的关系，这个关系一般是a.id=b.id
	 既两表中有相同字段的马上相等
4、再读一下题目，用拍大腿的精神想问题，自然翻译

1、如果你不写任何关系，那么结果是2个表的无序相乘（笛卡尔积） hash算法  全连接
select * from emp,dept;  -- 56条数据 
emp：14  dept：4

x:{1,2,3,4,5}
y:{7,8,9}
两个集合的无序相乘：3*5   笛卡尔积


2、内链接(inner join)
select * from emp,dept where emp.deptno=dept.deptno;

也可以写成：
	select * from emp inner join dept on emp.deptno=dept.deptno;


3、 left join、 right join ：以左表为参考就是左连接，反之右连接
a		b
id	id
1		2
2		3
3		7
4		10
5

select * from a,b;--20条数据
select * from a,b where a.id=b.id;--2条
select * from a left join b on a.id=b.id;
a		b
id	id
1		
2		2
3		3
4		
5	

select * from a right join b on a.id=b.id;
a		b
id	id
2		2
3		3
		7
		10



题目：
1. 列出至少有1个雇员的所有部门名
select dname from dept where deptno in(
select distinct deptno from emp);

2. 列出薪金比"SMITH"多的所有雇员
-- 知道什么求什么
-- 一列对一列
select ename from emp
where sal>(select sal from emp where ename='SMITH');


3. 列出所有雇员的姓名及其直接上级的姓名

select e.ename,ee.ename
from emp e left join emp ee
on e.mgr=ee.empno;


4. 列出入职日期早于其直接上级的所有雇员
select e.ename
from emp e
where e.hiredate<(select ee.hiredate from emp ee where e.mgr=ee.empno);



5. 列出部门名称和这些部门的雇员,同时列出那些没有雇员的部门

SELECT dname,ename 
FROM dept LEFT JOIN emp on dept.deptno=emp.deptno ORDER BY dname;

6. 列出所有“CLERK”（办事员）的姓名及其部门名称
select ename,dname
from emp,dept
where emp.deptno=dept.deptno
and job='CLERK';



7. 列出各种工作类别的最低薪金，显示最低薪金大于1500的记录

SELECT job,MIN(sal) FROM emp GROUP BY job HAVING MIN(sal)>1500;

8. 列出从事“SALES”（销售）工作的雇员的姓名，假定不知道销售部的部门编号
 
select ename from emp where deptno=(select deptno from dept where dname='SALES');


9. 列出薪金高于公司平均水平的所有雇员

SELECT ename FROM emp WHERE sal>(SELECT AVG(sal) FROM emp);

10. 列出与“SCOTT”从事相同工作的所有雇员
select ename
from emp
where job=(select job from emp where ename='SCOTT');

11. 列出某些雇员的姓名和薪金，条件是他们的薪金等于部门30中任何一个雇员的薪金
select ename,sal
from emp
where sal in (select sal from emp where deptno=30);

12. 列出某些雇员的姓名和薪金，条件是他们的薪金高于部门30中所有雇员的薪金
select ename,sal
from emp
where sal>(select max(sal) from emp where deptno=30);


13. 列出每个部门的信息以及该部门中雇员的数量

select d.*,count(e.ename)
from dept d left join emp e
on d.deptno=e.deptno
group by d.deptno,d.dname,d.loc;




14. 列出所有雇员的雇员名称、部门名称和薪

SELECT ename,dname,sal
FROM emp,dept WHERE emp.deptno=dept.deptno;



15. 列出各种类别工作的最低工资

SELECT job,MIN(sal+IFNULL(COMM,0)) newsal FROM emp GROUP BY job;



16. 列出各个部门的MANAGER（经理）的最低薪金 

SELECT deptno,MIN(sal)
FROM emp WHERE job='MANAGER' GROUP BY deptno;


17. 列出按年薪排序的所有雇员的年薪

SELECT sal*12 year_sal FROM emp ORDER BY year_sal ;

18. 列出按年薪排名的所有雇员的年薪


SELECT  DISTINCT sal*12 year_sal FROM emp ORDER BY year_sal ;



19. 列出按年薪排序的第四名雇员的年薪

SELECT (sal+IFNULL(comm,0)*12) year_sal
FROM emp ORDER BY year_sal DESC
LIMIT 3,1;

20. 列出薪金水平处于第四位的雇员
SELECT  ename 
FROM emp 
WHERE sal=(SELECT DISTINCT sal FROM emp ORDER BY sal DESC LIMIT 3,1)；


