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

CREATE TABLE IF NOT EXISTS `address`(
	`a_id`			INT				NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `line1`			VARCHAR(255)	NOT NULL,
    `line2`			VARCHAR(255)	NULL,
	`city`			VARCHAR(50)		NOT NULL,
    `state`			VARCHAR(2)		NOT NULL,
    `zip`			TINYINT(5)		NOT NULL,
    unique(`line1`,`line2`,`city`,`state`,`zip`)
);

CREATE TABLE IF NOT EXISTS `rel_panels`(
	`qq_id`					INT			NOT NULL PRIMARY KEY	AUTO_INCREMENT,
    `rep_id`				INT			NOT NULL,
    `take_off_type_id`		INT			NOT NULL,
    `est_num`				VARCHAR(13)	NOT NULL,
	`included_structures`	VARCHAR(75) NOT NULL,
    ``
);
