create database if not exists sakila_dwh;

use sakila_dwh;

 

CREATE TABLE IF NOT EXISTS `dim_tiempo` (

  `date_key` INT NOT NULL,

  `date_value` DATE NOT NULL,

  `month_number` INT NOT NULL,

  `month_name` VARCHAR(45) NOT NULL,

  `year4` INT NOT NULL,

  `day_of_week` INT NOT NULL,

  `day_of_week_name` VARCHAR(45) NOT NULL,

  PRIMARY KEY (`date_key`)

);

 

 

-- -----------------------------------------------------

-- Table `fac_rental`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `fac_rental` (

  `rental_key` INT NOT NULL AUTO_INCREMENT,

  `rental_id` VARCHAR(45) NOT NULL,

  `date_key` INT NOT NULL,

  `count_rental` INT NOT NULL,

  PRIMARY KEY (`rental_key`),

  INDEX `dim_time_and_fac_rental_idx` (`date_key` ASC) VISIBLE,

  UNIQUE INDEX `date_value_constraint` (`date_key` ASC) VISIBLE,

  CONSTRAINT `dim_time_and_fac_rental`

    FOREIGN KEY (`date_key`)

    REFERENCES `dim_tiempo` (`date_key`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB