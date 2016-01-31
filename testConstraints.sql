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
