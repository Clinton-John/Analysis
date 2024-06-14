-- THE KABARAK ROTARY CLUB

drop database if exists `kabarak_rotary_club`;charity_members
CREATE DATABASE `kabarak_rotary_club`;
use `kabarak_rotary_club`;

create table charity_members(
	member_id int not null auto_increment,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    occupation varchar(100),
    gender varchar(50),
    pwd varchar(100),
    primary key(member_id)
    
);