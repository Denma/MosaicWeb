--
-- 이전 TABLE DROP 
--

DROP TABLE tbl_gattach;
DROP TABLE tbl_gboard;
DROP TABLE tbl_gmessage;
DROP TABLE tbl_greply;
DROP TABLE tbl_user;

ALTER TABLE tbl_gmessage DROP FOREIGN KEY frk_usertarget;
ALTER TABLE tbl_gmessage DROP FOREIGN KEY frk_usersender;


--
-- DROP TABLE
--

DROP TABLE tbl_board_game;
DROP TABLE tbl_reply_game;

--
-- CREATE table
--

CREATE TABLE tbl_user
(
   uid            VARCHAR(50) NOT NULL,
   upw            VARCHAR(50) NOT NULL,
   uname          VARCHAR(100) NOT NULL,
   upoint         int NOT NULL DEFAULT 0,
   email		  varchar(50),
   regdate        TIMESTAMP DEFAULT now(),
   sessionkey     varchar(50) NOT NULL DEFAULT 'none',
   sessionlimit   timestamp NOT NULL DEFAULT now(),
   PRIMARY KEY(uid)
);

CREATE TABLE tbl_board_game (
   bno        int NOT NULL AUTO_INCREMENT,
   title      varchar(200) NOT NULL,
   content    text NULL,
   writer     varchar(50) NOT NULL,
   regdate    timestamp NOT NULL DEFAULT now(),
   viewcnt    int DEFAULT 0,
   replycnt   int DEFAULT 0,
   PRIMARY KEY(bno)
);

CREATE TABLE tbl_reply_game (
   rno          int NOT NULL AUTO_INCREMENT,
   bno          int NOT NULL DEFAULT 0,
   replytext    varchar(1000) NOT NULL,
   replyer      varchar(50) NOT NULL,
   regdate      timestamp NOT NULL DEFAULT now(),
   updatedate   timestamp NOT NULL DEFAULT now(),
   PRIMARY KEY(rno)
);

ALTER TABLE tbl_reply_game
ADD CONSTRAINT frk_board_reply FOREIGN KEY(bno) REFERENCES tbl_board_game(bno);

CREATE TABLE tbl_attach_game
(
   fullName   VARCHAR(150) NOT NULL,
   bno        INT NOT NULL,
   regdate    TIMESTAMP DEFAULT now(),
   PRIMARY KEY(fullName)
);

ALTER TABLE tbl_attach_game
ADD CONSTRAINT fk_borad_attach_game FOREIGN KEY(bno) REFERENCES tbl_board_game(bno);

create table tbl_message_game (
	mno			int not null AUTO_INCREMENT,
	targetid	varchar(50) not null,
	sender		varchar(50) not null,
	message		text not null,
	opendate	timestamp not null,
	senddate timestamp NOT NULL DEFAULT now(),
	PRIMARY KEY(mno)
);

ALTER TABLE tbl_message_game ADD CONSTRAINT frk_usertarget
FOREIGN KEY (targetid) REFERENCES tbl_user (uid);

ALTER TABLE tbl_message_game ADD CONSTRAINT frk_usersender
FOREIGN KEY (sender) REFERENCES tbl_user (uid);


INSERT INTO tbl_user(UID, upw, uname)
VALUES ('Ronaldo', '1234', 'CR7');

INSERT INTO tbl_user(UID, upw, uname)
VALUES ('Android', '1234', 'Android_1');

INSERT INTO tbl_user(UID, upw, uname)
     VALUES ('user00', 'user00', 'IRON MAN');

INSERT INTO tbl_user(UID, upw, uname)
     VALUES ('user01', 'user01', 'CAPTAIN');

INSERT INTO tbl_user(UID, upw, uname)
     VALUES ('user02', 'user02', 'HULK');

INSERT INTO tbl_user(UID, upw, uname)
     VALUES ('user03', 'user03', 'Thor');

