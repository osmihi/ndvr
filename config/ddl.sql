-- ndvr Data Definition Language script
DROP TABLE IF EXISTS `smihi83_ndvr`.`ProjectSkill`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`WorkSkill`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`EducationSkill`;

DROP TABLE IF EXISTS `smihi83_ndvr`.`Example`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`Task`;

DROP TABLE IF EXISTS `smihi83_ndvr`.`Project`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`Work`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`Education`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`Skill`;

DROP TABLE IF EXISTS `smihi83_ndvr`.`Contact`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`Profile`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`Portfolio`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`SkillCategory`;
DROP TABLE IF EXISTS `smihi83_ndvr`.`User`;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`User` (
	`userID` INT NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(30) NOT NULL,
	`password` VARCHAR(256) NOT NULL,
	`email` VARCHAR(256) NULL,
	`role` VARCHAR(32) NOT NULL DEFAULT 'User',

	PRIMARY KEY (`userID`),
	UNIQUE (`username`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`SkillCategory` (
  `skillCategoryID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `type` VARCHAR(128) NOT NULL,

  PRIMARY KEY (`skillCategoryID`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Portfolio` (
	`portfolioID` INT NOT NULL AUTO_INCREMENT,
	`userID` INT NOT NULL,
	`name` VARCHAR(256) NOT NULL,
	`createdDate` TIMESTAMP NOT NULL DEFAULT 0,
	`modifiedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	PRIMARY KEY (`portfolioID`),
	CONSTRAINT `Portfolio_User` FOREIGN KEY (`userID`) REFERENCES `smihi83_ndvr`.`User` (`userID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Profile` (
	`portfolioID` INT NOT NULL,
	`firstName` VARCHAR(128) NOT NULL,
  `middleName` VARCHAR(128) NULL,
  `lastName` VARCHAR(128) NOT NULL,
	`title` VARCHAR(128) NULL,
  `location` VARCHAR(128) NULL,
  `statement` VARCHAR(4096) NULL,

	PRIMARY KEY (`portfolioID`),
	CONSTRAINT `Profile_Portfolio` FOREIGN KEY (`portfolioID`) REFERENCES `smihi83_ndvr`.`Portfolio` (`portfolioID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Contact` (
	`contactID` INT NOT NULL AUTO_INCREMENT,
	`portfolioID` INT NOT NULL,
  `type` VARCHAR(64) NOT NULL,
  `subType` VARCHAR(64) NULL,
  `contact` VARCHAR(512) NULL,
  `label` VARCHAR(128) NULL,

	PRIMARY KEY (`contactID`),
	CONSTRAINT `Contact_Portfolio` FOREIGN KEY (`portfolioID`) REFERENCES `smihi83_ndvr`.`Portfolio` (`portfolioID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Skill` (
  `skillID` INT NOT NULL AUTO_INCREMENT,
  `portfolioID` INT NOT NULL,
  `skillCategoryID` INT NOT NULL,
  `seq` INT NULL,
  `name` VARCHAR(512) NOT NULL,

  PRIMARY KEY (`skillID`),
  CONSTRAINT `Skill_Portfolio` FOREIGN KEY (`portfolioID`) REFERENCES `smihi83_ndvr`.`Portfolio` (`portfolioID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Skill_SkillCategory` FOREIGN KEY (`skillCategoryID`) REFERENCES `smihi83_ndvr`.`SkillCategory` (`skillCategoryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Education` (
  `educationID` INT NOT NULL AUTO_INCREMENT,
  `portfolioID` INT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `location` VARCHAR(128) NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  `program` VARCHAR(128) NULL,
  `gpa` DECIMAL(4,2) NULL,
  `honors` VARCHAR(256) NULL,

  PRIMARY KEY (`educationID`),
  CONSTRAINT `Education_Portfolio` FOREIGN KEY (`portfolioID`) REFERENCES `smihi83_ndvr`.`Portfolio` (`portfolioID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Work` (
  `workID` INT NOT NULL AUTO_INCREMENT,
  `portfolioID` INT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `location` VARCHAR(128) NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  `title` VARCHAR(128) NULL,

  PRIMARY KEY (`workID`),
  CONSTRAINT `Work_Portfolio` FOREIGN KEY (`portfolioID`) REFERENCES `smihi83_ndvr`.`Portfolio` (`portfolioID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Project` (
  `projectID` INT NOT NULL AUTO_INCREMENT,
  `portfolioID` INT NOT NULL,
  `educationID` INT NULL,
  `workID` INT NULL,
  `name` VARCHAR(128) NOT NULL,
  `description` TEXT NULL,

  PRIMARY KEY (`projectID`),
  CONSTRAINT `Project_Portfolio` FOREIGN KEY (`portfolioID`) REFERENCES `smihi83_ndvr`.`Portfolio` (`portfolioID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Project_Education` FOREIGN KEY (`educationID`) REFERENCES `smihi83_ndvr`.`Education` (`educationID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Project_Work` FOREIGN KEY (`workID`) REFERENCES `smihi83_ndvr`.`Work` (`workID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Example` (
  `exampleID` INT NOT NULL AUTO_INCREMENT,
  `projectID` INT NOT NULL,
  `type` VARCHAR(64) NOT NULL,
  `seq` INT NULL,
  `link` VARCHAR(512) NULL,
  `description` TEXT NULL,

  PRIMARY KEY (`exampleID`),
  CONSTRAINT `Example_Project` FOREIGN KEY (`projectID`) REFERENCES `smihi83_ndvr`.`Project` (`projectID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`Task` (
  `taskID` INT NOT NULL AUTO_INCREMENT,
  `workID` INT NOT NULL,
  `seq` INT NULL,
  `description` TEXT NULL,

  PRIMARY KEY (`taskID`),
  CONSTRAINT `Task_Work` FOREIGN KEY (`workID`) REFERENCES `smihi83_ndvr`.`Work` (`workID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`EducationSkill` (
  `educationSkillID` INT NOT NULL AUTO_INCREMENT,
  `educationID` INT NOT NULL,
  `skillID` INT NOT NULL,
  `seq` INT NULL,

  PRIMARY KEY (`educationSkillID`),
  CONSTRAINT `EducationSkill_Education` FOREIGN KEY (`educationID`) REFERENCES `smihi83_ndvr`.`Education` (`educationID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `EducationSkill_Skill` FOREIGN KEY (`skillID`) REFERENCES `smihi83_ndvr`.`Skill` (`skillID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`WorkSkill` (
  `workSkillID` INT NOT NULL AUTO_INCREMENT,
  `workID` INT NOT NULL,
  `skillID` INT NOT NULL,
  `seq` INT NULL,

  PRIMARY KEY (`workSkillID`),
  CONSTRAINT `WorkSkill_Work` FOREIGN KEY (`workID`) REFERENCES `smihi83_ndvr`.`Work` (`workID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `WorkSkill_Skill` FOREIGN KEY (`skillID`) REFERENCES `smihi83_ndvr`.`Skill` (`skillID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `smihi83_ndvr`.`ProjectSkill` (
  `projectSkillID` INT NOT NULL AUTO_INCREMENT,
  `projectID` INT NOT NULL,
  `skillID` INT NOT NULL,
  `seq` INT NULL,

  PRIMARY KEY (`projectSkillID`),
  CONSTRAINT `ProjectSkill_Project` FOREIGN KEY (`projectID`) REFERENCES `smihi83_ndvr`.`Project` (`projectID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ProjectSkill_Skill` FOREIGN KEY (`skillID`) REFERENCES `smihi83_ndvr`.`Skill` (`skillID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;
