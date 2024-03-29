--insert into

insert into 學生(學號,生日,電話,姓名,性別)
values('S010','1999-8-5','07-5845826','東方不敗','男')

--沒選擇該欄位就不用填資料內容,到資料表內未選填的欄位會自動存成null
insert into 學生(學號,姓名,性別)
values('S011','王小明','男')

--如果選了該欄位，輸入空值，該欄位資料顯示空白是為空值
insert into 學生(學號,姓名,電話,性別)
values('S012','鄭花花','','女')

--但日期時間欄位因為值域完整性的關係，所以如果設空值會顯示初始值1990-01-01
insert into 學生(學號,姓名,生日,性別)
values('S013','雷青青','','女')
--如果想存null可直接打null或直接不選欄位

--篩選時，要找空值資料
Select*from 學生 where 電話=''

--篩選null資料
Select*from 學生 where 電話 is null

--省略欄位
--沒寫欄位表示全部欄位，所以資料表有幾格欄位就要給幾個值，欄位要與原資料表順序相同
insert into 學生
values('S020','任我行','男','','2022-2-6')

insert into 學生
values('S021','任我行','男','07-5656545',null)

--一次新增多筆資料
--只要key不同，內容相同也能新增
insert into 學生
values('S030','任我行','女','07-5365643','2022-2-6'),
('S031','任我行','女','07-5365643','2022-2-6'),
('S032','任我行','女','07-5365643','2022-2-6'),
('S033','任我行','女','07-5365643','2022-2-6'),
('S034','任我行','女','07-5365643','2022-2-6')

--從原資料表產生新資料表，但不會協助定義主索引鍵
--select * into 沒有的資料表 from 舊資料表
select* into 學生2 from 學生

--從舊資料表老資料欄內容存放進去已存在的資料表內
--insert 要存放的資料表 select 欄位 from 資料表
insert into 學生2 
select* from 學生
