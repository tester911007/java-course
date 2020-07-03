IF OBJECT_ID('person', 'U') IS NOT NULL
  DROP TABLE person;

CREATE TABLE person (
    person_id [int] IDENTITY(1,1),
    first_name [nvarchar](100) NULL,
	last_name [nvarchar](100) NULL,
    PRIMARY KEY (person_id)
);