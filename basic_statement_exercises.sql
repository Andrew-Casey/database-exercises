show databases;
-- 1. Use the albums_db database.
use albums_db;
select database();

-- 2. What is the primary key for the albums table?
show tables;
show create table albums;
/*CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 */

select id
from albums;

-- The primary key for the albums table is `id`

-- 3. What does the column named 'name' represent?
Select *
from albums;
-- The name of the album. 

-- 4. What do you think the sales column represents?
Select sales
from albums;

-- How many times the album has been sold in millions.

-- 5. Find the name of all albums by Pink Floyd.
Select * 
from albums
where artist = "pink floyd";

-- 'The Dark Side of the Moon' and 'The Wall' are the only albums by Pink Floyd.

-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
Select name, release_date
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";

-- The album was released in 1967

-- 7. What is the genre for the album Nevermind?
Select name, genre
from albums
where name = "Nevermind";
-- Nevermind is Grunge, Alternative rock

-- 8. Which albums were released in the 1990s?
Select name, release_date
from albums
where release_date between 1990 and 1999;

-- 9. Which albums had less than 20 million certified sales?
select name, sales
from albums
where sales < 20.0;