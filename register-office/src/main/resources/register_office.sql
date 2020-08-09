IF OBJECT_ID('ro_marriage_certificate', 'U') IS NOT NULL
    drop table ro_marriage_certificate;
IF OBJECT_ID('ro_birth_certificate', 'U') IS NOT NULL
    drop table ro_birth_certificate;
IF OBJECT_ID('ro_passport', 'U') IS NOT NULL
    drop table ro_passport;
IF OBJECT_ID('ro_person', 'U') IS NOT NULL
  drop table ro_person;

create TABLE ro_person (
    person_id [int] IDENTITY(1,1),
    sex [smallint] not null,
    first_name [nvarchar](100) NOT NULL,
	last_name [nvarchar](100) NOT NULL,
	patronymic [nvarchar](100) NULL,
	date_birth [date] NOT NULL,
    PRIMARY KEY (person_id)
);

CREATE TABLE ro_passport (
    passport_id [int] IDENTITY(1,1),
    person_id [int] NOT NULL,
    seria [nvarchar](10) NOT NULL,
    number [nvarchar](10) NOT NULL,
    date_issue [date] NOT NULL,
    issue_department [nvarchar](200),
    PRIMARY KEY (passport_id),
    FOREIGN KEY (person_id) REFERENCES ro_person(person_id) ON DELETE CASCADE
);

CREATE TABLE ro_birth_certificate (
    birth_certificate_id [int] IDENTITY(1,1),
    number_certificate [nvarchar](20) NOT NULL,
    date_issue [date] NOT NULL,
    person_id [int] NOT NULL,
    father_id [int],
    mother_id [int],
    PRIMARY KEY (birth_certificate_id),
    FOREIGN KEY (person_id) REFERENCES ro_person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (father_id) REFERENCES ro_person(person_id) ON DELETE NO ACTION,
    FOREIGN KEY (mother_id) REFERENCES ro_person(person_id) ON DELETE NO ACTION
);

CREATE TABLE ro_marriage_certificate (
    marriage_certificate_id [int] IDENTITY(1,1),
    number_certificate [nvarchar](20) NOT NULL,
    date_issue [date] NOT NULL,
    husband_id [int] NOT NULL,
    wife_id [int] NOT NULL,
    active [bit] DEFAULT 0,
    end_date [date],
    PRIMARY KEY (marriage_certificate_id),
    FOREIGN KEY (husband_id) REFERENCES ro_person(person_id) ON DELETE NO ACTION,
    FOREIGN KEY (wife_id) REFERENCES ro_person(person_id) ON DELETE NO ACTION
);

INSERT INTO ro_person (sex, first_name, last_name, patronymic, date_birth)
VALUES (1, 'Елена', 'Васильева', 'Сергеевна', '1998-03-24'),
(2, 'Олег', 'Васильев', 'Петрович', '1997-10-16'),
(2, 'Николай', 'Васильев', 'Олегович', '2018-10-21');

INSERT INTO ro_passport (person_id, seria, number, date_issue, issue_department)
VALUES (1, '40000', '123456', '2018-04-10', 'Department Passport');

INSERT INTO ro_birth_certificate(number_certificate, date_issue, person_id,
mother_id, father_id)
VALUES('123 Birth', '2018-1-01', 3, 1, 2);