IF OBJECT_ID('person', 'U') IS NOT NULL
  drop table person;

create TABLE ro_person (
    person_id [int] IDENTITY(1,1),
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
    PRIMARY KEY (passport_id)
    FOREIGN KEY (person_id) REFERENCES ro_person(person_id) ON DELETE CASCADE
)