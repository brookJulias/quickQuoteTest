USE `quickQuote`;

CREATE TABLE IF NOT EXISTS `user_type`(
    `ut_id`     INT     		NOT NULL    PRIMARY KEY auto_increment,
    `type_name` VARCHAR(9)     NOT NULL,
    UNIQUE(`type_name`)
);

INSERT INTO `user_type` (`type_name`) VALUES ("SALES REP"),("CAD TECH");

CREATE TABLE IF NOT EXISTS `users`(
    `u_id`        INT             NOT NULL    PRIMARY KEY auto_increment,
    `username`  VARCHAR(255)    NOT NULL,
    `password`  VARCHAR(72)     NOT NULL,
    UNIQUE(`username`)
);

CREATE TABLE IF NOT EXISTS `user_detail`(
    `ud_id`         INT             NOT NULL    PRIMARY KEY auto_increment,
    `u_id`			INT				NOT NULL,
    `first_name`    VARCHAR(40)      NOT NULL,
    `middle_initial`CHAR(1)         NULL,
    `last_name`     VARCHAR(40)     NOT NULL,
    `initials`      VARCHAR(3)      NOT NULL,
    foreign key (`u_id`) REFERENCES `users`(`u_id`),
    UNIQUE(`u_id`,`first_name`,`middle_initial`,`last_name`),
    UNIQUE(`initials`)
);

CREATE TABLE IF NOT EXISTS `user_permissions`(
    `up_id`         INT         NOT NULL    PRIMARY KEY auto_increment,
    `ut_id`         INT         NOT NULL,
    `u_id`          INT         NOT NULL,
    `read_c`        TINYINT(1)  NOT NULL,
    `add_c`         TINYINT(1)  NOT NULL,
    `read_admin_c`  TINYINT(1)  NOT NULL,
    `add_admin_c`   TINYINT(1)  NOT NULL
);

CREATE TABLE IF NOT EXISTS `take_off_type`(
	`tot_id`		INT			NOT NULL	PRIMARY KEY		AUTO_INCREMENT,
    `type_name`		VARCHAR(13)	NOT NULL,
    UNIQUE(`type_name`)
);

INSERT INTO `take_off_type` (`type_name`) VALUES 
('Address Only'),
('Aerial Report'),
('Blueprint'),
('Plan Sketch'),
('Revision');

Drop table if exists `roof_panel_width`;

CREATE TABLE IF NOT EXISTS `roof_panel_width` (
	`rpw_id`			INT				NOT NULL	PRIMARY KEY		auto_increment,
    `width_in_inches`	DECIMAL(3,1)	NOT NULL,
    unique(`width_in_inches`)
);

SHOW CREATE TABLE `roof_panel_width`;

INSERT INTO `roof_panel_width` (`width_in_inches`) 
VALUES (12),(14),(16),(18),(24),(29.5),(36);

CREATE TABLE IF NOT EXISTS `roofing_panels`(
	`rp_id`			INT			NOT NULL		PRIMARY KEY		auto_increment,
    `rp_name`		VARCHAR(20)	NOT NULL,
	unique(`rp_name`)
);

INSERT INTO `roofing_panels` (`rp_name`) VALUES
('5VCrimp'),
('GulfLok'),
('GulfPBR'),
('GulfRib'),
('GulfSeam'),
('GulfWave'),
('VersaLoc');

DROP TABLE IF EXISTS `rel_panels`;

CREATE TABLE IF NOT EXISTS `panel_hem_length`(
	`phl_id`			INT			NOT NULL		PRIMARY KEY		auto_increment,
    `hem_length`		TINYINT(1)	NOT NULL,
    unique(`hem_length`)
);

INSERT INTO `panel_hem_length` (`hem_length`) VALUES (0),(1),(2),(3),(4);

CREATE TABLE IF NOT EXISTS `rel_panels`(
	`relP_id`			INT		NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `rp_id`				INT 	NOT NULL,
    `rpw_id`			INT		NOT NULL,
    UNIQUE(`rp_id`,`rpw_id`),
    FOREIGN KEY (`rp_id`) REFERENCES `roofing_panels` (`rp_id`),
    foreign key (`rpw_id`) REFERENCES `roof_panel_width` (`rpw_id`)
);

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "5VCrimp"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "24"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfLok"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "12"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfLok"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "14"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfLok"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "16"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfLok"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "18"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfPBR"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "36"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfSeam"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "16"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfSeam"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "18"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfWave"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "30"));

INSERT INTO `rel_panels` (`rp_id`,`rpw_id`) VALUES
((SELECT `rp_id` FROM `roofing_panels` WHERE `rp_name` = "GulfWave"),
(SELECT `rpw_id` FROM `roof_panel_width` WHERE `width_in_inches` = "36"));

CREATE VIEW `roof_panel_list` AS SELECT rp.rp_name AS 'Panel Name', rpw.width_in_inches 'Panel Width' FROM `rel_panels` AS rel
INNER JOIN `roofing_panels` AS rp ON rel.rp_id = rp.rp_id
INNER JOIN `roof_panel_width` AS rpw ON rel.rpw_id = rpw.rpw_id
ORDER BY rp.rp_name, rpw.width_in_inches;

CREATE TABLE IF NOT EXISTS `qq_status`(
	`qqs_id`			INT				NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `status_value`		VARCHAR(18)		NOT NULL,
    unique(`status_value`)
);

INSERT INTO `qq_status` (`status_value`) VALUES ('Open'),('Grabbed'),('Corrections Needed'),('Pending Review'),('Review In Progress'),('Released'),('Closed');

CREATE TABLE IF NOT EXISTS `address`(
	`a_id`			INT				NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `line1`			VARCHAR(255)	NOT NULL,
    `line2`			VARCHAR(255)	NULL,
	`city`			VARCHAR(50)		NOT NULL,
    `state`			VARCHAR(2)		NOT NULL,
    `zip`			TINYINT(5)		NOT NULL,
    unique(`line1`,`line2`,`city`,`state`,`zip`)
);

CREATE TABLE IF NOT EXISTS `customer`(
	`c_id`			INT				NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `c_name`		VARCHAR(100)	NOT NULL,
    UNIQUE (`c_name`)
);

CREATE TABLE IF NOT EXISTS `quick_quote`(
	`qq_id`			INT				NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `salesRep_id`	INT				NOT NULL,
    `CADTech_id`	INT				NULL,
    `tot_id`				INT				NOT NULL,
    `address_id`			INT				NULL,
    `c_id`					INT				NOT NULL,
    `job_name`				VARCHAR(50)		NOT NULL,
    `included_stuctures`	VARCHAR(100)	NOT NULL
    
/*
 *
 *	Awaiting more information to finish the panel relationship table
 *
 */
);

CREATE TABLE IF NOT EXISTS `nested_quickQuote`(
	`nQQ_id`			INT		NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `qq_id`				INT		NOT NULL,
    `lft`				INT		NOT NULL,
    `rgt`				INT		NOT NULL,
    UNIQUE(`lft`),
    UNIQUE(`rgt`),
    FOREIGN KEY (`qq_id`) REFERENCES `quick_quote` (`qq_id`)
);

CREATE TABLE IF NOT EXISTS `quickQuote_data`(
	`qqD_dT_id`			INT				NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `qq_id`				int				NOT NULL,
    `label`				VARCHAR(100)	NOT NULL,
    `qq_dT`				DATETIME		NOT NULL,
    `msg`				VARCHAR(255)	NOT NULL,
    UNIQUE (`qq_id`,`label`,`qq_dT`,`msg`),
    FOREIGN KEY (`qq_id`) REFERENCES `quick_quote` (`qq_id`)
);

CREATE TABLE IF NOT EXISTS `qq_comment`(
	`qqC_id`	INT				NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `qq_id`		INT				NOT NULL,
    `u_id`		INT				NOT NULL,
    `msg`		VARCHAR(255)	NOT NULL,
    UNIQUE(`qq_id`,`u_id`,`msg`)
);