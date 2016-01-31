SPOOL project.out
SET ECHO ON
/*
CIS 353 - Database Design Project
Kevin Harrison
Matt Conflitti
Conner Toney
Tim Meese
*/
--
-- CREATING THE TABLES
-- --------------------------------------------------------------------
CREATE TABLE ForumUser(
UserID INTEGER,
username CHAR(15) NOT NULL,
password CHAR(25) NOT NULL,
email CHAR(28) NOT NULL,
groupID INTEGER DEFAULT 1 NOT NULL,
pic_id INTEGER NOT NULL,
star_power INTEGER DEFAULT 0 NOT NULL,
--
--uIC1 : userID is primary key
CONSTRAINT uIC1 PRIMARY KEY(UserID)
);
--
CREATE TABLE UserGroup(
GroupID INTEGER,
GroupName CHAR(12) NOT NULL,
AdminFlag INTEGER,
--
--ugIC1 : GroupID is primary key
CONSTRAINT ugIC1 PRIMARY KEY (GroupID)
);
--
CREATE TABLE Forum(
ForumID INTEGER NOT NULL,
forumName CHAR(35) NOT NULL,
--
--fIC1 : ForumID is primary key
CONSTRAINT fIC1 PRIMARY KEY (ForumID)
);
--
--
---
CREATE TABLE Thread(
ThreadID INTEGER,
CloseFlag INTEGER DEFAULT 0 NOT NULL,
CreatorID INTEGER NOT NULL,
ParentThreadID INTEGER,
Title CHAR(60) NOT NULL,
--
--tIC1 : threadID is primary key
CONSTRAINT tIC1 PRIMARY KEY (ThreadID)
);
--
--
CREATE TABLE Post(
PostID INTEGER NOT NULL,
ThreadID INTEGER NOT NULL,
Body CHAR(60) NOT NULL,
TimeStamp TIMESTAMP NOT NULL,
Flag INTEGER NOT NULL,
PostedByID INTEGER NOT NULL,
ParentPostID INTEGER,
ParentThreadID INTEGER,
--
--pIC1 : PostID is primary key
CONSTRAINT pIC1 PRIMARY KEY (PostID,ThreadID)
);
--
CREATE TABLE Moderators(
ForumID INTEGER,
ModeratorID INTEGER,
--
--mIC1 : forumID and ModeratorID composite key
CONSTRAINT mIC1 PRIMARY KEY(ForumID,ModeratorID)
);
--
--
CREATE TABLE ForumHasThread(
ForumID INTEGER,
ThreadID INTEGER,
TimeStamp TIMESTAMP NOT NULL,
--
--fhtIC1 : forumID and ThreadID is primary key
CONSTRAINT fhtIC1 PRIMARY KEY (ForumID, ThreadID)
);
--
CREATE TABLE ProfilePic(
PicID INTEGER,
FilePath CHAR(15) NOT NULL,
--
--ppIC1 : PicID is primary key
CONSTRAINT ppIC1 PRIMARY KEY (PicID)
);
--
-- --------------------------------------------------------------------
--ADD CHECKS,FOREIGN KEYS, ETC
--
ALTER TABLE ForumUser
ADD(
--uIC2 : groupID must be in userGroup table
CONSTRAINT uIC2 FOREIGN KEY(groupID) REFERENCES UserGroup(groupID),
--uIC3 : picID must be a picture
CONSTRAINT uIC3 FOREIGN KEY(pic_id) REFERENCES ProfilePic(PicID),
--uIC5 : username must be unique
CONSTRAINT uIC5 UNIQUE(username)
);
--
ALTER TABLE UserGroup ADD(
--ugIC2 : AdminFlag contains a value between 0 and 5
CONSTRAINT ugIC2 CHECK (AdminFlag >= 0 AND AdminFlag <= 5)
);
--
ALTER TABLE Thread
ADD(
--tIC2 : closeFlag must be 0 or 1
CONSTRAINT tIC2 CHECK (CloseFlag >= 0 AND CloseFlag <= 1),
--tIC3 : creator must be in user table
CONSTRAINT tIC3 FOREIGN KEY (CreatorID) REFERENCES ForumUser(UserID),
--tIC4 : parentthread must in thread table
CONSTRAINT tIC4 FOREIGN KEY (ParentThreadID) REFERENCES Thread(ThreadID)
    DEFERRABLE INITIALLY DEFERRED,
--tIC5 : threadID cannot equal ParentThreadID **two attr. 1 row check**
CONSTRAINT tIC5 CHECK(ThreadID != ParentThreadID)
);
--
ALTER TABLE Post
ADD(
--pIC2 : PostedByID is foreign key to UserID
CONSTRAINT pIC2 FOREIGN KEY (PostedByID) REFERENCES ForumUser(UserID),
--pIC3 : ParentPostID,ParentThreadID is foreign key to PostID,ThreadID
CONSTRAINT pIC3 FOREIGN KEY (ParentPostID,ParentThreadID) REFERENCES Post(PostID,ThreadID)
    ON DELETE CASCADE,
--pic4 : thread that post is in must exist
CONSTRAINT pIC4 FOREIGN KEY(ThreadID) REFERENCES Thread(ThreadID)
);
--
ALTER TABLE Moderators
ADD(
--mIC2 : forumID must be a forum
CONSTRAINT mIC2 FOREIGN KEY (ForumID) REFERENCES Forum(ForumID),
--mIC3 : moderatorID must be user
CONSTRAINT mIC3 FOREIGN KEY (ModeratorID) REFERENCES ForumUser(UserID)
);
--
ALTER TABLE ForumHasThread
ADD(
--fhtIC2 : forumID must be in forum table
CONSTRAINT fhtIC2 FOREIGN KEY (ForumID) REFERENCES Forum(ForumID),
--fhtIC3 : threadID must be in thread table
CONSTRAINT fhtIC3 FOREIGN KEY (ThreadID) REFERENCES Thread(ThreadID)
);
--
ALTER TABLE ProfilePic ADD(
--ppIC2: filepath must be unique
CONSTRAINT ppIC2 UNIQUE(FilePath)
);
--
SET FEEDBACK OFF
--=========================================
--POPULATE DB
--populate static usergroups
INSERT INTO UserGroup VALUES (0,'RootAdmin',1);
INSERT INTO UserGroup VALUES (1,'ForumAdmin',2);
INSERT INTO UserGroup VALUES (2,'ThreadAdmin',3);
INSERT INTO UserGroup VALUES (3,'PostAdmin',4);
INSERT INTO UserGroup VALUES (4,'Normal',5);
--
--
--populate profile pics
INSERT INTO ProfilePic VALUES(1,'pic1.jpg');
INSERT INTO ProfilePic VALUES(2,'pic2.jpg');
INSERT INTO ProfilePic VALUES(3,'pic3.jpg');
INSERT INTO ProfilePic VALUES(4,'pic4.jpg');
INSERT INTO ProfilePic VALUES(5,'pic5.jpg');
INSERT INTO ProfilePic VALUES(6,'pic6.jpg');
INSERT INTO ProfilePic VALUES(7,'pic7.jpg');
INSERT INTO ProfilePic VALUES(8,'pic8.jpg');
INSERT INTO ProfilePic VALUES(9,'pic9.jpg');
INSERT INTO ProfilePic VALUES(10,'pic10.jpg');
--
--
--populate users
INSERT INTO ForumUser VALUES (1,'conflitm','p@assword','conflittimat@gmail.com',0,1,1);
INSERT INTO ForumUser VALUES (2,'harrisonkev','p@assword','harrisonkev@gmail.com',0,2,1);
INSERT INTO ForumUser VALUES (3,'conrad','p@assword','toneyCon@gmail.com',1,3,3);
INSERT INTO ForumUser VALUES (4,'meesetim','p@assword','meesetim@gmail.com',1,4,7);
INSERT INTO ForumUser VALUES (5,'jill123','p@assword','jill123@gmail.com',4,5,9);
INSERT INTO ForumUser VALUES (6,'benjamin','p@assword','benny@gmail.com',4,6,3);
INSERT INTO ForumUser VALUES (7,'alexM','p@assword','martina@gmail.com',3,7,1);
INSERT INTO ForumUser VALUES (8,'robertB','p@assword','Brob@gmail.com',3,8,19);
INSERT INTO ForumUser VALUES (9,'jimmyJoe','p@assword','jimmyJoe@gmail.com',2,9,17);
INSERT INTO ForumUser VALUES (10,'sweetCaroline','p@assword','carolineS@gmail.com',1,10,13);
--
--
--populate forums
INSERT INTO Forum VALUES (1,'General Discussion');
INSERT INTO Forum VALUES (2,'Ask/Tell');
INSERT INTO Forum VALUES (3,'Sports');
INSERT INTO Forum VALUES (4,'Events');
INSERT INTO Forum VALUES (5,'Questions, Comments and Suggestions');
--
--
--populate threads
INSERT INTO Thread VALUES(1, 0, 1, NULL, 'Announcement: Welcome to betaBoards!');
INSERT INTO Thread VALUES(2, 1,  3, 1, 'Thread Rules');
INSERT INTO Thread VALUES(3, 1, 1, NULL, 'Ask/Tell SubThread Rules');
INSERT INTO Thread VALUES(4, 0, 4, NULL, 'NHL General Thread: November');
INSERT INTO Thread VALUES(5, 0, 4, 4, 'NHL Gameday Thread 11/30');
INSERT INTO Thread VALUES(20, 0, 10, NULL, 'Hello, I am new here!');
--
--
--populate Post
INSERT INTO Post VALUES(1,1,'This place is awesome!','15-Dec-01 07:03:08',1,1,NULL,NULL);
INSERT INTO Post VALUES(2,1,'I like it here, too!','15-Dec-02 08:08:08',1,1,1,1);
INSERT INTO Post VALUES(1,4,'Who caught that game?','15-Dec-02 08:18:48',1,2,3,NULL);
INSERT INTO Post VALUES(2,4,'This place is awesome!','15-Dec-03 12:00:01',1,3,1,4);
INSERT INTO Post VALUES(1,5,'This place is awesome!','15-Dec-04 02:33:44',1,4,2,NULL);
INSERT INTO Post VALUES(2,5,'This place is awesome!','15-Dec-03 11:08:08',1,4,7,NULL);
INSERT INTO Post VALUES(3,5,'This place is awesome!','15-Dec-05 05:48:38',1,5,1,5);
INSERT INTO Post VALUES(4,5,'This place is awesome!','15-Dec-05 05:49:58',1,5,3,5);
INSERT INTO Post VALUES(1,20,'This place is awesome!','15-Dec-03 12:03:48',1,5,NULL,NULL);
INSERT INTO Post VALUES(2,20,'This place is awesome!','15-Dec-04 08:08:08',1,6,NULL,NULL);
INSERT INTO Post VALUES(3,20,'This place is awesome!','15-Dec-04 08:08:08',1,7,NULL,NULL);
INSERT INTO Post VALUES(3,1,'This place is awesome!','15-Dec-04 08:08:08',1,7,NULL,NULL);
INSERT INTO Post VALUES(4,1,'This place is awesome!','15-Dec-04 08:08:08',1,8,1,1);
INSERT INTO Post VALUES(3,4,'This place is awesome!','15-Dec-04 08:08:08',1,8,2,4);
INSERT INTO Post VALUES(4,4,'This place is awesome!','15-Dec-04 08:08:08',1,8,NULL,NULL);
INSERT INTO Post VALUES(5,5,'This place is awesome!','15-Dec-04 08:08:08',1,9,Null,NULL);
INSERT INTO Post VALUES(4,20,'This place is awesome!','15-Dec-04 08:08:08',1,9,3,20);
INSERT INTO Post VALUES(5,20,'This place is awesome!','15-Dec-04 08:08:08',1,10,4,20);
--
--
--
--populate Moderators
INSERT INTO Moderators VALUES(1,3);
INSERT INTO Moderators VALUES(1,4);
INSERT INTO Moderators VALUES(2,3);
INSERT INTO Moderators VALUES(3,3);
INSERT INTO Moderators VALUES(4,10);
INSERT INTO Moderators VALUES(5,10);
INSERT INTO Moderators VALUES(5,4);
--
--
--populate forumhasthread
INSERT INTO ForumHasThread VALUES(1,1,'15-Dec-01 08:08:08');
INSERT INTO ForumHasThread VALUES(1,2,'15-Dec-02 08:08:08');
INSERT INTO ForumHasThread VALUES(2,3,'15-Dec-03 08:08:08');
INSERT INTO ForumHasThread VALUES(3,4,'15-Dec-04 08:08:08');
INSERT INTO ForumHasThread VALUES(3,5,'15-Dec-05 08:08:08');
INSERT INTO ForumHasThread VALUES(1,20,'15-Dec-06 08:08:08');
--
SET FEEDBACK ON
COMMIT;
--==========================================
--SELECT ALL
--
SELECT * FROM ForumUser;
SELECT * FROM UserGroup;
SELECT * FROM Forum;
SELECT * FROM Thread;
SELECT * FROM Post;
SELECT * FROM Moderators;
SELECT * FROM ForumHasThread;
SELECT * FROM ProfilePic;
--
--===========================================
--QUERIES
--
-- 1.A join involving at least four relations.
-- 5. GROUP BY , HA VING, and ORDER BY , all appearing in the same query
--Get Usernames and ForumNames of Users that moderate the forums in order of most to least threads > 0.
SELECT U.username,F.forumName,COUNT(*) as "# of Threads" FROM ForumUser U, Forum F, Moderators M, ForumHasThread T
  WHERE U.userID = M.ModeratorID AND M.ForumID = F.ForumID AND F.ForumID = T.ForumID
  GROUP BY U.username,F.forumName
  HAVING COUNT(*) > 0
  ORDER BY COUNT(*) DESC;
--
-- 2. A self-join.
--Find all users with same star_power below 8
SELECT DISTINCT U.Username,U2.Username,U.star_power
  FROM ForumUser U, ForumUser U2
  WHERE U.star_power < 8 AND
    U.star_power = U2.star_power AND
    U.UserID < U2.UserID;
--
-- 3. UNION, INTERSECT, and/or MINUS.
--Find all users who have star power above 8 and
--have made a post
SELECT U.UserID,U.username
  FROM ForumUser U
  WHERE U.star_power > 8
  INTERSECT
SELECT U.UserID,U.username
  FROM ForumUser U, Post P
  WHERE U.UserID = P.PostedByID;
--
-- 4. SUM, AVG, MAX, and/or MIN.
--Find average user star power.
SELECT AVG(star_power) as "AVG Star Power"
  FROM ForumUser;
--
--
-- 6. A correlated subquery.
--Users that have star_power > 8 and is a moderator
SELECT U.userID,U.username,U.star_power
  FROM ForumUser U
  WHERE U.star_power > 8 AND U.userID IN
  (SELECT ModeratorID
   FROM Moderators
    WHERE ModeratorID = U.userId);
--
-- 7. A non-correlated subquery.
--Users that have star_power > 8 and not a moderator
SELECT U.userID,U.username,U.star_power
  FROM ForumUser U
  WHERE U.star_power > 8 AND U.userID NOT IN
  (SELECT ModeratorID
   FROM Moderators);
--
-- 6. A correlated subquery.
-- 8. A relational DIVISION query.
--Find all users that have not posted in Thread 5
SELECT U.UserID,U.Username
  FROM ForumUser U
  WHERE EXISTS (
    SELECT T.ThreadID
    FROM Thread T
    WHERE T.ThreadID = 5
    MINUS
    SELECT T.ThreadID
    FROM Thread T,Post P
--Here is the correlated part
    WHERE U.UserID = P.PostedByID
    AND P.ThreadID = T.ThreadID
    AND T.ThreadID = 5
  );
--
-- 9. An outer join query.
--Show all users and the thread they've created for those who
--have created one.
SELECT U.username,U.userID,T.ThreadID
  FROM ForumUser U LEFT OUTER JOIN Thread T
  ON T.CreatorID = U.userID;
--
--=====================================
--TEST CONSTRAINTS
--
--Testing : uIC1 : userID is primary key
INSERT INTO ForumUser VALUES (2,'conflitm','p@assword','conflittimat@gmail.com',0,1,2);
--
--Testing : ugIC2 : AdminFlag contains a value between 0 and 5
UPDATE UserGroup
SET AdminFlag=6
WHERE GroupID=3;
--
UPDATE UserGroup
SET AdminFlag=-1
WHERE GroupID=3;
--
--ppIC2: filepath must be unique
INSERT INTO ProfilePic VALUES(20,'pic1.jpg');
--
--uIC2 : groupID must be in userGroup table
UPDATE ForumUser SET groupID=99 WHERE UserID=1;
--
--tIC3 : creator must be in user table
INSERT INTO Thread VALUES(12, 0, 99, NULL, 'Announcement: Welcome to betaBoards!');
--
--tIC4 : parentthread must in thread table
--WILL GET CAUGHT ON COMMIT BECAUSE DEFERRED
INSERT INTO Thread VALUES(15,0, 1, 99, 'Announcement: Welcome to betaBoards!');
--
--pIC3 : ParentPostID is foreign key to PostID, cascade deletion
INSERT INTO Post VALUES(45,1,'This place is awesome!','15-Dec-01 08:08:08',1,1,2,99);
DELETE FROM Post WHERE PostID=1 AND ThreadID=1;
--shouldn't exist
SELECT postID FROM POST WHERE PostID=1 AND ThreadID=1;
--
--testing tIC5 : parentthread cannot equal itself
INSERT INTO Thread VALUES (50,1,2,50,'New Thread');
--
COMMIT;
--
SPOOL OFF
