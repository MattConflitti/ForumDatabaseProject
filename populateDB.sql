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
