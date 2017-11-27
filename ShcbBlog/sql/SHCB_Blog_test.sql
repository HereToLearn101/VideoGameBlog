DROP DATABASE IF EXISTS SHCB_Blog_test;

CREATE DATABASE SHCB_Blog_test;

USE SHCB_Blog_test;

CREATE TABLE IF NOT EXISTS PostStatuses
(
	status_id INT NOT NULL AUTO_INCREMENT,
    status_desc VARCHAR(20) NOT NULL,
    PRIMARY KEY (status_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Posts
(
	post_id INT NOT NULL AUTO_INCREMENT,
    -- post_approved BOOL NOT NULL,
    post_html TEXT NOT NULL,
	post_title VARCHAR(100) NOT NULL,
    post_header_img VARCHAR(125) NOT NULL,
    post_pub_date DATETIME NOT NULL,
    post_status INT NOT NULL,
    PRIMARY KEY (post_id),
    FOREIGN KEY (post_status) REFERENCES PostStatuses(status_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Tags
(
	tag_id INT NOT NULL AUTO_INCREMENT,
    tag_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Categories
(
	cat_id INT NOT NULL AUTO_INCREMENT,
    cat_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (cat_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Users
(
	user_id INT NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(20) NOT NULL,
    user_password VARCHAR(20) NOT NULL,
    user_enabled BOOL NOT NULL default 0,
    PRIMARY KEY (user_id),
    KEY (user_name)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE Users ADD UNIQUE(user_name);

CREATE TABLE IF NOT EXISTS Comments
(
	comment_id INT NOT NULL AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_body VARCHAR(300) NOT NULL,
    comment_time DATETIME NOT NULL,
    PRIMARY KEY (comment_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Post_Tags
(
	post_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY(post_id, tag_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Post_Categories
(
	post_id INT NOT NULL,
    cat_id INT NOT NULL,
    PRIMARY KEY (post_id, cat_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (cat_id) REFERENCES Categories(cat_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Post_Authors
(
	post_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Authorities
(
	user_name VARCHAR(20) NOT NULL,
    -- authority ENUM('ROLE_USER', 'ROLE_CONTRIBUTOR', 'ROLE_ADMIN') NOT NULL,
    authority VARCHAR(30) NOT NULL,
    FOREIGN KEY (user_name) REFERENCES Users(user_name)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Games
(
	game_id INT NOT NULL AUTO_INCREMENT,
    game_name VARCHAR(50) NOT NULL,
    game_release_date DATE NOT NULL,
    PRIMARY KEY (game_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*

INSERT INTO PostStatuses(status_desc)
VALUES ("pending"),("approved"),("unapproved");

INSERT INTO Posts (post_title,post_html, post_header_img, post_pub_date, post_status)
VALUES ("Title of the Post","<h1>Title of the Post</h1><p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","www.google.com/image234","2016-10-15 6:45:00",1),
("Different Title","<h1>Title of the Post</h1><p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","www.google.com/image-of-stuff","2015-12-5 13:23:00",2);

INSERT INTO Tags (tag_name)
VALUES ("OldSchool"),("Atari"),("Nintendo64");

INSERT INTO Categories (cat_name)
VALUES ("OldSchool"),("Arcade"),("Playstation");

INSERT INTO Users (user_name, user_password, user_enabled)
VALUES ("user1","password",1),("user2","guest",1),("user3","my-password",0);

INSERT INTO Comments (post_id, user_id, comment_body, comment_time)
VALUES (1,1,"This is great!","2017-10-25 10;10:00"),
(2,1,"I completely disagree.","2017-10-25 16:25:09"),
(1,2,"My opinions are important and should be taken into consideration!","2016-05-21 22:26:17");

INSERT INTO Post_Tags (post_id, tag_id)
VALUES (1,1),(1,2),(2,2),(2,3);

INSERT INTO Post_Categories (post_id, cat_id)
VALUES (1,1),(2,1),(2,2);

INSERT INTO Post_Authors(post_id, user_id)
VALUES (1,1),(2,2);

INSERT INTO Games (game_name, game_release_date)
VALUES ("Test Game 1", "1990-01-01"),("Test Game 2", "1988-6-4");

INSERT INTO Authorities (user_name, authority)
VALUES ("user1", "ROLE_USER"),("user2", "ROLE_USER"),("user2", "ROLE_CONTRIBUTOR"),
("user3", "ROLE_USER"),("user3", "ROLE_CONTRIBUTOR"),("user3", "ROLE_ADMIN");

-- */

INSERT INTO PostStatuses(status_desc)
VALUES ("pending"),("approved"),("unapproved");


/*
	Error Code: 1364. Field 'post_header_img' doesn't have a default value

*/