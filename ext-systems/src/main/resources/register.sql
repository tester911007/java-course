
IF OBJECT_ID('cr_address_person', 'U') IS NOT NULL
  DROP TABLE cr_address_person;
IF OBJECT_ID('cr_person', 'U') IS NOT NULL
  DROP TABLE cr_person;
IF OBJECT_ID('cr_address', 'U') IS NOT NULL
  DROP TABLE cr_address;
IF OBJECT_ID('cr_street', 'U') IS NOT NULL
  DROP TABLE cr_street;
IF OBJECT_ID('cr_district', 'U') IS NOT NULL
  DROP TABLE cr_district;

CREATE TABLE cr_district (
    district_code [int] NOT NULL,
    district_name [nvarchar](300) NULL,
    PRIMARY KEY (district_code)
);

INSERT INTO cr_district (district_code, district_name)
VALUES (1, 'Выборгский');


CREATE TABLE cr_street
(
    street_code [int] NOT NULL,
    street_name [nvarchar](300) NULL,
    PRIMARY KEY (street_code)
);

INSERT INTO cr_street (street_code, street_name)
VALUES (1, 'Сампсоньевский проспект');


CREATE TABLE cr_address (
    address_id [int] IDENTITY(1,1) NOT NULL,
    district_code [int] NOT NULL,
    street_code [int] NOT NULL,
    building [nvarchar](10) NOT NULL,
    extension [nvarchar](10) NULL,
    apartment [nvarchar](10) NULL,
    PRIMARY KEY (address_id),
    FOREIGN KEY (district_code) REFERENCES cr_district(district_code) ON DELETE NO ACTION,
    FOREIGN KEY (street_code) REFERENCES cr_street(street_code) ON DELETE NO ACTION
);

INSERT INTO cr_address (district_code, street_code, building, extension, apartment)
VALUES (1, 1, '10', '2', '121');
INSERT INTO cr_address (district_code, street_code, building, extension, apartment)
VALUES (1, 1, '271', NULL, '4');


CREATE TABLE cr_person (
    person_id [int] IDENTITY(1,1) NOT NULL,
    sur_name [nvarchar](100) NOT NULL,
    given_name [nvarchar](100) NOT NULL,
    patronymic [nvarchar](100) NOT NULL,
    date_of_birth [date] NOT NULL,
    passport_seria [nvarchar](10) NULL,
    passport_number [nvarchar](10) NULL,
    passport_date [date] NULL,
    certificate_number [nvarchar](10) NULL,
    certificate_date [date] NULL,
    PRIMARY KEY (person_id)
);

INSERT INTO cr_person (sur_name, given_name, patronymic, date_of_birth,
passport_seria, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильев', 'Павел', 'Николаевич', '1995-03-18', '1234', '123456', '2015-04-11',
null, null);

INSERT INTO cr_person (sur_name, given_name, patronymic, date_of_birth,
passport_seria, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильева', 'Ирина', 'Петровна', '1997-08-21', '4321', '654321', '2017-09-19',
null, null);

INSERT INTO cr_person (sur_name, given_name, patronymic, date_of_birth,
passport_seria, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильева', 'Евгения', 'Павловна', '2016-01-11', NULL, NULL, NULL, '456123', '2016-01-21');

INSERT INTO cr_person (sur_name, given_name, patronymic, date_of_birth,
passport_seria, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильев', 'Александр', 'Павлович', '2018-10-24', NULL, NULL, NULL, '321654', '2018-11-09');


CREATE TABLE cr_address_person (
    person_address_id [int] IDENTITY(1,1) NOT NULL,
    address_id [int] NOT NULL,
    person_id [int] NOT NULL,
    start_date [date] NOT NULL,
    end_date [date],
    temporal [bit] DEFAULT 0,
    PRIMARY KEY (person_address_id),
    FOREIGN KEY (address_id) REFERENCES cr_address(address_id) ON DELETE NO ACTION,
    FOREIGN KEY (person_id) REFERENCES cr_person(person_id) ON DELETE NO ACTION
);

INSERT INTO cr_address_person (address_id, person_id, start_date, end_date, temporal)
VALUES (1, 1, '2014-10-12', NULL, 0);

INSERT INTO cr_address_person (address_id, person_id, start_date, end_date)
VALUES (1, 2, '2014-10-12', NULL);

INSERT INTO cr_address_person (address_id, person_id, start_date, end_date)
VALUES (1, 3, '2016-02-05', NULL);

INSERT INTO cr_address_person (address_id, person_id, start_date, end_date)
VALUES (1, 4, '2018-12-11', NULL);