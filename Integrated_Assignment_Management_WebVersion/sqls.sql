--btw check constraints are not supported in mysql, we can use posgresql instead or some other dbms engines

CREATE TABLE inst
(
	iid			CHAR(9)			NOT NULL PRIMARY KEY,
	--similar to student ids
	name		VARCHAR(30)		NOT NULL,
	pass		VARCHAR(30)		NOT NULL
	--CHECK (LENGTH(pass) >= 8),
	--id REGEXP '^[:digit:]{2}[:alpha:]{2}[:digit:]{5}$'),
);

CREATE TABLE stud
(
	sid			CHAR(9)			NOT NULL PRIMARY KEY,
	name		VARCHAR(30)		NOT NULL,
	pass		VARCHAR(30)		NOT NULL
	--CHECK (LENGTH(pass) >= 8),
	--id REGEXP '^[:digit:]{2}[:alpha:]{2}[:digit:]{5}$'),
);

CREATE TABLE csem
(
	cid			CHAR(7)			NOT NULL,
	semid		CHAR(6)			NOT NULL,
	name		VARCHAR(30)		NOT NULL,
	PRIMARY KEY (cid, semid),
	--id REGEXP '^[:alpha:]{2}[:digit:]{5}$'),
);

CREATE TABLE teaches
(
	iid			CHAR(9)			NOT NULL,
	cid			CHAR(7)			NOT NULL,
	semid		CHAR(6)			NOT NULL,
	PRIMARY KEY (iid,cid,semid),
	FOREIGN KEY (iid)			REFERENCES inst(iid),
	FOREIGN KEY (cid,semid)		REFERENCES csem(cid,semid)
);

CREATE TABLE ass
(
	ps			VARCHAR(1000)	NOT NULL,
	subbyi		CHAR(9)			NOT NULL,
	cid			CHAR(7)			NOT NULL,
	semid		CHAR(6)			NOT NULL,
	ano			INT				NOT NULL,
	duedt		TIMESTAMP		NOT NULL,
	maxmks		INT				NOT NULL DEFAULT 100,
	wtge		DECIMAL(5,2),
	avgmks		INT,
	avgdifi		INT,
	avgdifs		INT,		-- out of 5
	PRIMARY KEY (cid, semid, ano),
	FOREIGN KEY (subbyi,cid,semid)		REFERENCES teaches(iid,cid,semid)
);

CREATE TABLE studass
(
	sid			CHAR(9)			NOT NULL,
	cid			CHAR(7)			NOT NULL,
	semid		CHAR(6)			NOT NULL,
	ano			INT				NOT NULL,
	mks			INT,
	dif			INT,
	PRIMARY KEY (sid,cid,semid,ano),
	FOREIGN KEY (sid)			REFERENCES stud(sid),
	FOREIGN KEY (cid,semid,ano)	REFERENCES ass(cid,semid,ano)
);

CREATE TABLE reg
(
	sid			CHAR(9)			NOT NULL,
	cid			CHAR(7)			NOT NULL,
	semid		CHAR(6)			NOT NULL,
	--semid will contain both sem and year in the form 'SPyyyy' OR 'AUyyyy'
	PRIMARY KEY (sid,cid,semid),
	FOREIGN KEY (sid) 			REFERENCES stud(sid),
	FOREIGN KEY (cid,semid) REFERENCES csem(cid,semid)
);

CREATE TABLE teaches
(
	iid			CHAR(9)			NOT NULL,
	cid			CHAR(7)			NOT NULL,
	semid		CHAR(6)			NOT NULL,
	PRIMARY KEY (iid,cid,semid),
	FOREIGN KEY (iid)			REFERENCES inst(iid),
	FOREIGN KEY (cid,semid)		REFERENCES csem(cid,semid)
);

CREATE TABLE instass
(
	iid			CHAR(9)			NOT NULL,
	cid			CHAR(7)			NOT NULL,
	semid		CHAR(6)			NOT NULL,
	ano			INT				NOT NULL,
	dif			INT,
	PRIMARY KEY (iid,cid,semid,ano),
	FOREIGN KEY (iid)			REFERENCES inst(iid),
	FOREIGN KEY (cid,semid,ano)		REFERENCES ass(cid,semid,ano)
);

--calendar of instr, chooses a course from a dropdown menu to see the due dates of asses of other courses taken by the studs of that course

--dropdown menu of currently taught courses for instructor

SELECT cs.cid, c.name
FROM csem cs INNER JOIN teaches t ON (cs.cid = t.cid AND cs.semid = t.semid)
WHERE t.iid = giveniid AND t.semid = currsemid;

--assignment details of other courses of students enrolled in this course
--cid2 is the course chosen by the instructor from the drop down menu that is the given cid

CREATE VIEW cidcid(cid1,cid2,semid) AS
SELECT DISTINCT r1.cid,r2.cid,r1.semid
FROM reg r1 INNER JOIN reg r2 ON (r1.sid=r2.sid AND r1.semid=r2.semid);

CREATE VIEW nstudbycid(cid,semid,nstuds) AS
SELECT r.cid,r.semid, COUNT(r.sid)
FROM reg r
GROUP BY r.cid,r.semid;

SELECT a.ps, a.ano, a.cid, a.duedt, a.avgdifi, n.nstuds
FROM cidcid c INNER JOIN (ass a, nstudbycid n) ON (c.cid1 = a.cid AND c.semid = a.semid AND c.cid1 = n.cid AND c.semid = n.semid)
WHERE c.cid2 = givencid AND c.semid = currsemid;

--students calendar showing all the due assignments

SELECT a.ps, a.ano, a.cid, a.duedt, a.avgdifi, sa.mks, a.maxmks, sa.dif
FROM ass a INNER JOIN studass sa ON (a.cid = sa.cid AND a.semid = sa.semid AND a.ano = sa.ano)
WHERE sa.sid = givensid AND a.semid = currsemid;

--password of instructor

SELECT i.pass
FROM inst i
WHERE i.iid = giveniid;

--password of student

SELECT s.pass
FROM stud s
WHERE s.sid = givensid;

--insertion

INSERT INTO inst VALUES
('10CSKGP01','Lxtaustvhoowx','12345678'),
('10CSKGP02','Kkctzqeqjujbfv','12345678'),
('10CSKGP03','Qockzdayvvgpmiex','12345678'),
('10CSKGP04','Ifzndlovsfmvmnmjietd','12345678'),
('10CSKGP05','Kfxcobjggecy','12345678'),
('10CSKGP06','Drzxkicjwyooempzww','12345678'),
('10CSKGP07','Ryoprmbehphqoeo','12345678'),
('10CSKGP08','Zhovghzqdwvmu','12345678'),
('10CSKGP09','Oklpusfxouxsaua','12345678'),
('10CSKGP10','Pvcvyrwolicgtltq','12345678'),
('10CSKGP11','Roxejriprxmxsdnhnm','12345678'),
('10CSKGP12','Jrlezhajioujrarbzy','12345678'),
('10CSKGP13','Bhxcgjhmvmfoc','12345678'),
('10CSKGP14','Ktucvhiqxw','12345678'),
('10CSKGP15','Gokbfmfrlr','12345678'),
('10CSKGP16','Glzjejhqbizsbfbszu','12345678'),
('10CSKGP17','Wutjtxnjxjsq','12345678'),
('10CSKGP18','Opwhwjummjoxc','12345678'),
('10CSKGP19','Sbinmdvpja','12345678'),
('10CSKGP20','Erraafqtxsgzyb','12345678'),
('10CSKGP21','Wpzpmeyvmaurb','12345678'),
('10CSKGP22','Bdspyazikjpfqc','12345678'),
('10CSKGP23','Qrtavtlcswripjzfl','12345678'),
('10CSKGP24','Qbrzowutqp','12345678');

INSERT INTO stud VALUES
('15CS10001','Uxoxrftnusqk','12345678'),
('15CS10002','Zpcnbxhdaays','12345678'),
('15CS10003','Qdshsixgcklqrcsuoymt','12345678'),
('15CS10004','Mecrnxipqpifgzv','12345678'),
('15CS10005','Xtnxrmxbetjseej','12345678'),
('15CS10006','Qhzdzchrtsruktwrifz','12345678'),
('15CS10007','Ubudpxgutkygydvmhg','12345678'),
('15CS10008','Wlnqdxdcmvfta','12345678'),
('15CS10009','Qstkctvafiv','12345678'),
('15CS10010','Zyzftxrqoyckaqop','12345678'),
('15CS10011','Njonnyxnkvvqrvi','12345678'),
('15CS10012','Jdrezlsstbbjmqmhf','12345678'),
('15CS10013','Fcprcagthadathzik','12345678'),
('15CS10014','Cbkhnokjvtgqip','12345678'),
('15CS10015','Fsqbkfknoyxsnpixdee','12345678'),
('15CS10016','Qlijfdslmoutzt','12345678'),
('15CS10017','Aimsxybgksacx','12345678'),
('15CS10018','Iuuaovnljlsffxxcgwyk','12345678'),
('15CS10019','Rzpbdccouvxutfzljjbu','12345678'),
('15CS10020','Vixdaegdihzlhea','12345678'),
('15CS10021','Csmjrkfzur','12345678'),
('15CS10022','Tmwpuxgahtfrqpjhvd','12345678'),
('15CS10023','Vzznlcghcqmdxmz','12345678'),
('15CS10024','Hjzzzufxincaxxadk','12345678'),
('15CS10025','Zefvrsjsiitccjjsw','12345678');

INSERT INTO csem VALUES
('CS10001','SP2018','Eujcvkcaceykkzu'),
('CS10002','SP2018','Qswztzycxvvkovufx'),
('CS10003','SP2018','Zbreznojlnkvpazlu'),
('CS10004','SP2018','Vgzgfydcevfrk'),
('CS10005','SP2018','Royaozjwxtng'),
('CS10006','SP2018','Nwxnhtkdmfthgw'),
('CS10007','SP2018','Vqtkjolvmihz'),
('CS10008','SP2018','Ihabothbwpkmraz'),
('CS10009','SP2018','Daodkknfxkhnbqasrzz'),
('CS10010','SP2018','Tohjfgkwdiquskfxfud'),
('CS10011','SP2018','Showkrvqkgdwodio'),
('CS10012','SP2018','Nqfcwrylwuylr');

INSERT INTO teaches VALUES
('10CSKGP01','CS10001','SP2018'),
('10CSKGP02','CS10001','SP2018'),
('10CSKGP03','CS10002','SP2018'),
('10CSKGP04','CS10002','SP2018'),
('10CSKGP05','CS10003','SP2018'),
('10CSKGP06','CS10003','SP2018'),
('10CSKGP07','CS10004','SP2018'),
('10CSKGP08','CS10004','SP2018'),
('10CSKGP09','CS10005','SP2018'),
('10CSKGP10','CS10005','SP2018'),
('10CSKGP11','CS10006','SP2018'),
('10CSKGP12','CS10006','SP2018'),
('10CSKGP13','CS10007','SP2018'),
('10CSKGP14','CS10007','SP2018'),
('10CSKGP15','CS10008','SP2018'),
('10CSKGP16','CS10008','SP2018'),
('10CSKGP17','CS10009','SP2018'),
('10CSKGP18','CS10009','SP2018'),
('10CSKGP19','CS10010','SP2018'),
('10CSKGP20','CS10010','SP2018'),
('10CSKGP21','CS10011','SP2018'),
('10CSKGP22','CS10011','SP2018'),
('10CSKGP23','CS10012','SP2018'),
('10CSKGP24','CS10012','SP2018');

INSERT INTO ass(ps,cid,semid,ano,subbyi,duedt) VALUES
('Assignment 1','CS10001','SP2018','1','10CSKGP01','2018-03-27 23:59:59'),
('Assignment 2','CS10001','SP2018','2','10CSKGP01','2018-03-17 23:59:59'),
('Assignment 3','CS10001','SP2018','3','10CSKGP01','2018-03-25 23:59:59'),
('Assignment 4','CS10001','SP2018','4','10CSKGP01','2018-03-24 23:59:59'),
('Assignment 5','CS10001','SP2018','5','10CSKGP02','2018-03-25 23:59:59'),
('Assignment 6','CS10001','SP2018','6','10CSKGP02','2018-03-08 23:59:59'),
('Assignment 7','CS10001','SP2018','7','10CSKGP02','2018-03-04 23:59:59'),
('Assignment 8','CS10001','SP2018','8','10CSKGP02','2018-03-14 23:59:59'),
('Assignment 1','CS10002','SP2018','1','10CSKGP03','2018-03-05 23:59:59'),
('Assignment 2','CS10002','SP2018','2','10CSKGP03','2018-03-15 23:59:59'),
('Assignment 3','CS10002','SP2018','3','10CSKGP03','2018-03-19 23:59:59'),
('Assignment 4','CS10002','SP2018','4','10CSKGP03','2018-03-10 23:59:59'),
('Assignment 5','CS10002','SP2018','5','10CSKGP04','2018-03-22 23:59:59'),
('Assignment 6','CS10002','SP2018','6','10CSKGP04','2018-03-11 23:59:59'),
('Assignment 7','CS10002','SP2018','7','10CSKGP04','2018-03-26 23:59:59'),
('Assignment 8','CS10002','SP2018','8','10CSKGP04','2018-03-27 23:59:59'),
('Assignment 1','CS10003','SP2018','1','10CSKGP05','2018-03-04 23:59:59'),
('Assignment 2','CS10003','SP2018','2','10CSKGP05','2018-03-16 23:59:59'),
('Assignment 3','CS10003','SP2018','3','10CSKGP05','2018-03-05 23:59:59'),
('Assignment 4','CS10003','SP2018','4','10CSKGP05','2018-03-21 23:59:59'),
('Assignment 5','CS10003','SP2018','5','10CSKGP06','2018-03-17 23:59:59'),
('Assignment 6','CS10003','SP2018','6','10CSKGP06','2018-03-03 23:59:59'),
('Assignment 7','CS10003','SP2018','7','10CSKGP06','2018-03-01 23:59:59'),
('Assignment 8','CS10003','SP2018','8','10CSKGP06','2018-03-12 23:59:59'),
('Assignment 1','CS10004','SP2018','1','10CSKGP07','2018-03-08 23:59:59'),
('Assignment 2','CS10004','SP2018','2','10CSKGP07','2018-03-23 23:59:59'),
('Assignment 3','CS10004','SP2018','3','10CSKGP07','2018-03-19 23:59:59'),
('Assignment 4','CS10004','SP2018','4','10CSKGP07','2018-03-05 23:59:59'),
('Assignment 5','CS10004','SP2018','5','10CSKGP08','2018-03-15 23:59:59'),
('Assignment 6','CS10004','SP2018','6','10CSKGP08','2018-03-23 23:59:59'),
('Assignment 7','CS10004','SP2018','7','10CSKGP08','2018-03-17 23:59:59'),
('Assignment 8','CS10004','SP2018','8','10CSKGP08','2018-03-04 23:59:59'),
('Assignment 1','CS10005','SP2018','1','10CSKGP09','2018-03-18 23:59:59'),
('Assignment 2','CS10005','SP2018','2','10CSKGP09','2018-03-13 23:59:59'),
('Assignment 3','CS10005','SP2018','3','10CSKGP09','2018-03-16 23:59:59'),
('Assignment 4','CS10005','SP2018','4','10CSKGP09','2018-03-17 23:59:59'),
('Assignment 5','CS10005','SP2018','5','10CSKGP10','2018-03-26 23:59:59'),
('Assignment 6','CS10005','SP2018','6','10CSKGP10','2018-03-25 23:59:59'),
('Assignment 7','CS10005','SP2018','7','10CSKGP10','2018-03-06 23:59:59'),
('Assignment 8','CS10005','SP2018','8','10CSKGP10','2018-03-04 23:59:59'),
('Assignment 1','CS10006','SP2018','1','10CSKGP11','2018-03-02 23:59:59'),
('Assignment 2','CS10006','SP2018','2','10CSKGP11','2018-03-20 23:59:59'),
('Assignment 3','CS10006','SP2018','3','10CSKGP11','2018-03-01 23:59:59'),
('Assignment 4','CS10006','SP2018','4','10CSKGP11','2018-03-03 23:59:59'),
('Assignment 5','CS10006','SP2018','5','10CSKGP12','2018-03-28 23:59:59'),
('Assignment 6','CS10006','SP2018','6','10CSKGP12','2018-03-23 23:59:59'),
('Assignment 7','CS10006','SP2018','7','10CSKGP12','2018-03-23 23:59:59'),
('Assignment 8','CS10006','SP2018','8','10CSKGP12','2018-03-15 23:59:59'),
('Assignment 1','CS10007','SP2018','1','10CSKGP01','2018-03-27 23:59:59'),
('Assignment 2','CS10007','SP2018','2','10CSKGP01','2018-03-09 23:59:59'),
('Assignment 3','CS10007','SP2018','3','10CSKGP01','2018-03-05 23:59:59'),
('Assignment 4','CS10007','SP2018','4','10CSKGP01','2018-03-23 23:59:59'),
('Assignment 5','CS10007','SP2018','5','10CSKGP02','2018-03-09 23:59:59'),
('Assignment 6','CS10007','SP2018','6','10CSKGP02','2018-03-14 23:59:59'),
('Assignment 7','CS10007','SP2018','7','10CSKGP02','2018-03-02 23:59:59'),
('Assignment 8','CS10007','SP2018','8','10CSKGP02','2018-03-24 23:59:59'),
('Assignment 1','CS10008','SP2018','1','10CSKGP03','2018-03-28 23:59:59'),
('Assignment 2','CS10008','SP2018','2','10CSKGP03','2018-03-16 23:59:59'),
('Assignment 3','CS10008','SP2018','3','10CSKGP03','2018-03-13 23:59:59'),
('Assignment 4','CS10008','SP2018','4','10CSKGP03','2018-03-04 23:59:59'),
('Assignment 5','CS10008','SP2018','5','10CSKGP04','2018-03-17 23:59:59'),
('Assignment 6','CS10008','SP2018','6','10CSKGP04','2018-03-15 23:59:59'),
('Assignment 7','CS10008','SP2018','7','10CSKGP04','2018-03-24 23:59:59'),
('Assignment 8','CS10008','SP2018','8','10CSKGP04','2018-03-23 23:59:59'),
('Assignment 1','CS10009','SP2018','1','10CSKGP05','2018-03-18 23:59:59'),
('Assignment 2','CS10009','SP2018','2','10CSKGP05','2018-03-21 23:59:59'),
('Assignment 3','CS10009','SP2018','3','10CSKGP05','2018-03-11 23:59:59'),
('Assignment 4','CS10009','SP2018','4','10CSKGP05','2018-03-15 23:59:59'),
('Assignment 5','CS10009','SP2018','5','10CSKGP06','2018-03-26 23:59:59'),
('Assignment 6','CS10009','SP2018','6','10CSKGP06','2018-03-23 23:59:59'),
('Assignment 7','CS10009','SP2018','7','10CSKGP06','2018-03-19 23:59:59'),
('Assignment 8','CS10009','SP2018','8','10CSKGP06','2018-03-27 23:59:59'),
('Assignment 1','CS10010','SP2018','1','10CSKGP07','2018-03-30 23:59:59'),
('Assignment 2','CS10010','SP2018','2','10CSKGP07','2018-03-14 23:59:59'),
('Assignment 3','CS10010','SP2018','3','10CSKGP07','2018-03-22 23:59:59'),
('Assignment 4','CS10010','SP2018','4','10CSKGP07','2018-03-15 23:59:59'),
('Assignment 5','CS10010','SP2018','5','10CSKGP08','2018-03-15 23:59:59'),
('Assignment 6','CS10010','SP2018','6','10CSKGP08','2018-03-22 23:59:59'),
('Assignment 7','CS10010','SP2018','7','10CSKGP08','2018-03-10 23:59:59'),
('Assignment 8','CS10010','SP2018','8','10CSKGP08','2018-03-12 23:59:59'),
('Assignment 1','CS10011','SP2018','1','10CSKGP09','2018-03-25 23:59:59'),
('Assignment 2','CS10011','SP2018','2','10CSKGP09','2018-03-29 23:59:59'),
('Assignment 3','CS10011','SP2018','3','10CSKGP09','2018-03-20 23:59:59'),
('Assignment 4','CS10011','SP2018','4','10CSKGP09','2018-03-22 23:59:59'),
('Assignment 5','CS10011','SP2018','5','10CSKGP10','2018-03-21 23:59:59'),
('Assignment 6','CS10011','SP2018','6','10CSKGP10','2018-03-10 23:59:59'),
('Assignment 7','CS10011','SP2018','7','10CSKGP10','2018-03-12 23:59:59'),
('Assignment 8','CS10011','SP2018','8','10CSKGP10','2018-03-07 23:59:59'),
('Assignment 1','CS10012','SP2018','1','10CSKGP11','2018-03-04 23:59:59'),
('Assignment 2','CS10012','SP2018','2','10CSKGP11','2018-03-15 23:59:59'),
('Assignment 3','CS10012','SP2018','3','10CSKGP11','2018-03-19 23:59:59'),
('Assignment 4','CS10012','SP2018','4','10CSKGP11','2018-03-24 23:59:59'),
('Assignment 5','CS10012','SP2018','5','10CSKGP12','2018-03-08 23:59:59'),
('Assignment 6','CS10012','SP2018','6','10CSKGP12','2018-03-11 23:59:59'),
('Assignment 7','CS10012','SP2018','7','10CSKGP12','2018-03-13 23:59:59'),
('Assignment 8','CS10012','SP2018','8','10CSKGP12','2018-03-23 23:59:59');

INSERT INTO teaches VALUES
('10CSKGP01','CS10001','SP2018'),
('10CSKGP02','CS10001','SP2018'),
('10CSKGP03','CS10002','SP2018'),
('10CSKGP04','CS10002','SP2018'),
('10CSKGP05','CS10003','SP2018'),
('10CSKGP06','CS10003','SP2018'),
('10CSKGP07','CS10004','SP2018'),
('10CSKGP08','CS10004','SP2018'),
('10CSKGP09','CS10005','SP2018'),
('10CSKGP10','CS10005','SP2018'),
('10CSKGP11','CS10006','SP2018'),
('10CSKGP12','CS10006','SP2018'),
('10CSKGP01','CS10007','SP2018'),
('10CSKGP02','CS10007','SP2018'),
('10CSKGP03','CS10008','SP2018'),
('10CSKGP04','CS10008','SP2018'),
('10CSKGP05','CS10009','SP2018'),
('10CSKGP06','CS10009','SP2018'),
('10CSKGP07','CS10010','SP2018'),
('10CSKGP08','CS10010','SP2018'),
('10CSKGP09','CS10011','SP2018'),
('10CSKGP10','CS10011','SP2018'),
('10CSKGP11','CS10012','SP2018'),
('10CSKGP12','CS10012','SP2018');
