DROP DATABASE IF EXISTS SHCB_Blog_demo;

CREATE DATABASE SHCB_Blog_demo;

USE SHCB_Blog_demo;

CREATE TABLE IF NOT EXISTS PostStatuses
(
	status_id INT NOT NULL AUTO_INCREMENT,
    status_desc VARCHAR(20) NOT NULL,
    PRIMARY KEY (status_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS Posts
(
	post_id INT NOT NULL AUTO_INCREMENT,
    post_html TEXT NOT NULL,
	post_title VARCHAR(100) NOT NULL,
    post_header_img VARCHAR(175) NOT NULL,
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


INSERT INTO Tags (tag_name)
VALUES ("MarioBros"),("TI-81"),("CheatCodes"),("Walkthrough"),("Games"),("GameSystems"),("Calculators");

INSERT INTO Categories (cat_name)
VALUES ("Games"),("GameSystems"),("Calculators");

INSERT INTO PostStatuses(status_desc)
VALUES ("pending"),("approved"),("unapproved");

INSERT INTO Posts (post_status,post_title, post_html, post_header_img, post_pub_date)
VALUES (2,"You Got Smashed, Bro!","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i0.wp.com/www.ti89.com/img/super-smash-bros-ti-83-84.jpg?resize=618%2C412","2015-1-15 6:45:00"),
(2,"Where'd You Go?","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://img.gadgethacks.com/img/68/94/63490312960744/0/inconspicuously-play-portal-during-class-your-graphic-calculator.w1456.jpg","2015-6-14 4:45:00"),
(2,"Look Out Below!","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","http://www.calculatorti.com/media/images/programs/phoenix-ion.jpg","2015-10-16 6:45:00"),
(1,"It's a Race!","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/8ZGyYgdB1O0/hqdefault.jpg","2015-10-25 5:45:00"),
(3,"It's a Snake Out!","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/1AqUMlKtNuI/hqdefault.jpg","2015-4-11 6:45:00"),
(2,"Skyrim","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/rN58_svR8nk/maxresdefault.jpg","2015-5-21 14:45:00"),
(2,"Crushin' Roulette","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i2.wp.com/www.calculatorti.com/media/images/programs/casino-games.jpg?resize=568%2C408","2016-1-13 6:45:00"),
(2,"Kong is Still King","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","http://www.calculatorti.com/media/images/programs/donkey-kong.jpg","2016-2-15 17:45:00"),
(3,"TI Horror Stories","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/TuupoxmeQ6U/hqdefault.jpg","2016-2-28 6:45:00"),
(2,"Do the Worm","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/5jTd9szphpw/hqdefault.jpg","2016-5-6 6:45:00"),
(1,"Tetris, an All-Time Classic","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://static1.squarespace.com/static/581ce76ae58c62bd097454ba/t/584cb9debebafb9fcadd08f3/1481423431708/tetriscalculator.jpg","2016-7-15 20:45:00"),
(2,"Calculated","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://media.makeameme.org/created/do-you-remember-ofch27.jpg","2016-8-8 6:45:00"),
(2,"I've Got 99 Problems, but a Bit Ain't One","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","http://mangotron.com/wp-content/uploads/2015/03/texas-679x479.jpg","2016-12-14 6:45:00"),
(2,"More Bits More Problems","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/TuupoxmeQ6U/hqdefault.jpg","2017-3-7 6:45:00"),
(2,"Guess Who's Pac","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/_tHrhYcCGFc/hqdefault.jpg","2017-4-20 15:45:00"),
(2,"Bits, Please.","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/8ZGyYgdB1O0/hqdefault.jpg","2017-4-29 6:45:00"),
(1,"Numbers Never Lie","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/TuupoxmeQ6U/hqdefault.jpg","2017-6-20 15:45:00"),
(3,"For the Love of Numbers","<p>Bacon ipsum dolor amet venison pastrami kevin ribeye shank meatloaf picanha. Meatball andouille picanha short loin, pancetta tongue tenderloin jerky pastrami drumstick. Tenderloin filet mignon prosciutto jowl drumstick biltong short ribs pork loin rump cow ground round picanha andouille. Turkey kevin jerky pig boudin.</p><p>Turkey tri-tip fatback picanha pork loin, strip steak sirloin. Filet mignon <i>pork belly</i> pancetta, tongue ham t-bone pastrami prosciutto. Porchetta sausage spare ribs brisket boudin kielbasa prosciutto meatball swine. Filet mignon strip steak spare ribs meatloaf ham kevin pork t-bone shank pig ground round. Hamburger porchetta landjaeger tongue jowl pork belly tail pancetta pig andouille. Alcatra filet mignon flank tri-tip short ribs jerky spare ribs brisket.</p><p>Drumstick pork chop brisket, t-bone beef capicola chuck pork belly biltong shank landjaeger fatback kielbasa pork. <b>Beef ribs</b> tongue short loin venison kielbasa landjaeger, cow strip steak prosciutto chicken sausage tri-tip ribeye. Tail tongue turkey ground round meatball cupim chuck ribeye. Tenderloin chicken venison salami swine short loin shankle, strip steak filet mignon hamburger ribeye burgdoggen jowl sirloin. Tri-tip ham turducken venison, pastrami boudin drumstick jerky kielbasa porchetta capicola sirloin doner prosciutto pork loin.</p>","https://i.ytimg.com/vi/8ZGyYgdB1O0/hqdefault.jpg","2017-10-25 6:45:00");

INSERT INTO Post_Tags (post_id, tag_id)
VALUES (1,7),(1,3),(2,2),(2,4),(3,6),(4,2),(4,4),(4,7),(5,3),(5,5),(6,1),(6,5),(7,2),(7,3),(7,4),(8,2),(8,1),(9,2),(9,3),(9,7),
(10,2),(10,4),(11,2),(11,6),(12,1),(12,3),(13,2),(14,3),(14,4),(14,6),(15,4),(15,5),(16,1),(16,4),(17,2),(17,4),(17,5),(18,2),(18,5);

INSERT INTO Post_Categories (post_id, cat_id)
VALUES (1,1),(2,2),(2,3),(3,1),(4,1),(5,3),(6,2),(7,2),(8,3),(9,1),(10,2),(10,3),
(11,1),(12,1),(13,2),(13,1),(14,3),(15,2),(16,2),(16,3),(17,1),(18,2);

INSERT INTO Games (game_name, game_release_date)
VALUES ("Pong","1990-12-1"),("Mine Field","1991-04-07"),("Tic-Tac-To","1990-09-10"),
("Snake","1990-04-28"),("Simon Says","1993-11-18"),("Mancala","1992-10-25"),("Connect-4","1993-07-17");

INSERT INTO Users (user_name, user_password, user_enabled)
VALUES ("BossMan","password",1),("MagnumTI","password",1),("GamerGirl","password",1),("TwoPlusTwo","password",1),("CalcFan42","password",0),
("NumsLie17","password",1),("jared","jared",1),("ted","ted",1);

INSERT INTO Post_Authors(post_id, user_id)
VALUES (1,1),(2,2),(3,3),(4,1),(5,2),(6,1),(7,2),(8,4),(9,2),(10,1),(11,3),(12,4),(13,3),(14,3),(15,2),(16,1),(17,4),(18,3);


INSERT INTO Comments (post_id, user_id, comment_body, comment_time) VALUES 
(18, 3, 'et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet', '2017-07-17 22:26:17'),
(14, 4, 'luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida', '2017-10-04 22:26:17'),
(9, 4, 'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis', '2017-05-15 22:26:17'),
(11, 5, 'tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim', '2016-12-25 22:26:17'),
(18, 2, 'a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices', '2017-07-05 22:26:17'),
(2, 1, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat', '2017-04-27 22:26:17'),
(7, 5, 'elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget', '2017-03-30 22:26:17'),
(11, 2, 'at nulla suspendisse potenti cras in purus eu magna vulputate luctus', '2017-11-05 22:26:17'),
(4, 1, 'vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra', '2017-06-21 22:26:17'),
(11, 4, 'leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at', '2017-11-05 22:26:17'),
(7, 1, 'mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu', '2017-10-23 22:26:17'),
(14, 5, 'lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt', '2017-10-22 22:26:17'),
(2, 5, 'donec semper sapien a libero nam dui proin leo odio porttitor id', '2017-02-21 22:26:17'),
(10, 3, 'nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante', '2016-11-11 22:26:17'),
(12, 2, 'nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non', '2017-02-24 22:26:17'),
(14, 2, 'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus', '2017-09-30 22:26:17'),
(15, 2, 'eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum', '2017-02-23 22:26:17'),
(10, 2, 'est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi', '2017-10-29 22:26:17'),
(1, 3, 'augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis', '2017-06-02 22:26:17'),
(3, 3, 'vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue', '2017-04-05 22:26:17'),
(2, 5, 'tristique est et tempus semper est quam pharetra magna ac consequat metus sapien', '2017-08-18 22:26:17'),
(11, 4, 'id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas', '2017-09-08 22:26:17'),
(6, 3, 'hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel', '2017-09-13 22:26:17'),
(3, 2, 'vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis', '2017-07-01 22:26:17'),
(10, 4, 'primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae', '2016-12-30 22:26:17'),
(9, 3, 'dictumst a-- liquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel', '2017-01-06 22:26:17'),
(13, 1, 'sit amet cursus id tur-- pis integer aliquet massa id lobortis', '2017-02-19 22:26:17'),
(8, 2, 'ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor', '2017-02-23 22:26:17'),
(17, 4, 'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', '2017-05-25 22:26:17'),
(8, 1, 'fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam', '2017-03-05 22:26:17');


INSERT INTO Authorities (user_name, authority)
VALUES ("CalcFan42","ROLE_USER"),("NumsLie17", "ROLE_USER"),
("BossMan","ROLE_USER"),("BossMan","ROLE_CONTRIBUTOR"),("BossMan","ROLE_ADMIN"),
("MagnumTI","ROLE_USER"),("MagnumTI","ROLE_CONTRIBUTOR"),
("GamerGirl","ROLE_USER"),("GamerGirl","ROLE_CONTRIBUTOR"),
("TwoPlusTwo","ROLE_USER"),("TwoPlusTwo","ROLE_CONTRIBUTOR"),
("jared","ROLE_USER"),("jared","ROLE_CONTRIBUTOR"),("jared","ROLE_ADMIN"),
("ted","ROLE_USER"),("ted","ROLE_CONTRIBUTOR");

