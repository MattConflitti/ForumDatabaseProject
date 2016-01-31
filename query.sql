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
