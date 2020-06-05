IF OBJECT_ID('jc_student_child', 'U') IS NOT NULL
  DROP TABLE jc_student_child;
IF OBJECT_ID('jc_student_order', 'U') IS NOT NULL
  DROP TABLE jc_student_order;
IF OBJECT_ID('jc_passport_office', 'U') IS NOT NULL
  DROP TABLE jc_passport_office;
IF OBJECT_ID('jc_register_office', 'U') IS NOT NULL
  DROP TABLE jc_register_office;
IF OBJECT_ID('jc_country_struct', 'U') IS NOT NULL
  DROP TABLE jc_country_struct;
IF OBJECT_ID('jc_university', 'U') IS NOT NULL
  DROP TABLE jc_university;
IF OBJECT_ID('jc_street', 'U') IS NOT NULL
  DROP TABLE jc_street;
IF OBJECT_ID('st_address', 'U') IS NOT NULL
  DROP TABLE st_address;


CREATE TABLE [dbo].[st_address](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[post_code] [nvarchar](15) NULL,
	[street] [nvarchar](100) NULL,
	[building] [nvarchar](10) NULL,
	[extension] [nvarchar](10) NULL,
	[apartment] [nvarchar](10) NULL
) ON [PRIMARY]

CREATE TABLE jc_street (
	street_code [int] not null,
	street_name [nvarchar](300) NULL,
	PRIMARY KEY (street_code)
);

CREATE TABLE jc_university (
	university_id [int] not null,
	university_name [nvarchar](300) NULL,
	PRIMARY KEY (university_id)
);

CREATE TABLE jc_country_struct (
	area_id [char](12) not null,
	area_name [nvarchar](200) NULL,
	PRIMARY KEY (area_id)
);

CREATE TABLE jc_passport_office (
	p_office_id [int] not null,
	p_office_area_id [char](12) NULL,
	p_office_name [nvarchar] (200) NULL,
	PRIMARY KEY (p_office_id),
	FOREIGN KEY (p_office_area_id) REFERENCES jc_country_struct(area_id) ON DELETE CASCADE
);

CREATE TABLE jc_register_office (
	r_office_id [int] not null,
	r_office_area_id [char](12) NULL,
	r_office_name [nvarchar] (200) NULL,
	PRIMARY KEY (r_office_id),
	FOREIGN KEY (r_office_area_id) REFERENCES jc_country_struct(area_id) ON DELETE CASCADE
)

CREATE TABLE jc_student_order
(
    student_order_id [int] IDENTITY(1,1) NOT NULL,
    student_order_status [int] not null,
    student_order_date [date] not null,
    h_sur_name [nvarchar] (100) not null,
    h_given_name [nvarchar] (100) not null,
    h_patronymic [nvarchar](100) not null,
    h_date_of_birth [date] not null,
    h_passport_seria [nvarchar](10) not null,
    h_passport_number [nvarchar](10) not null,
    h_passport_date [date] not null,
    h_passport_office_id [int] not null,
    h_post_index [nvarchar](10),
    h_street_code [int] not null,
    h_building [nvarchar](10) not null,
    h_extension [nvarchar](10),
    h_apartment [nvarchar](10),
    h_university_id [int] not null,
    h_student_number [nvarchar](30) not null,
    w_sur_name [nvarchar](100) not null,
    w_given_name [nvarchar](100) not null,
    w_patronymic [nvarchar](100) not null,
    w_date_of_birth [date] not null,
    w_passport_seria [nvarchar](10) not null,
    w_passport_number [nvarchar](10) not null,
    w_passport_date [date] not null,
    w_passport_office_id [int] not null,
    w_post_index [nvarchar](10),
    w_street_code [int] not null,
    w_building [nvarchar](10) not null,
    w_extension [nvarchar](10),
    w_apartment [nvarchar](10),
    w_university_id [int] not null,
    w_student_number [nvarchar](30) not null,
    certificate_id [nvarchar](20) not null,
    register_office_id [int] not null,
    marriage_date [date] not null,
    PRIMARY KEY (student_order_id),
    FOREIGN KEY (h_street_code) REFERENCES jc_street(street_code),
    FOREIGN KEY (h_passport_office_id) REFERENCES jc_passport_office(p_office_id) ON DELETE NO ACTION,
    FOREIGN KEY (h_university_id) REFERENCES jc_university(university_id) ON DELETE NO ACTION,
    FOREIGN KEY (w_street_code) REFERENCES jc_street(street_code),
    FOREIGN KEY (w_passport_office_id) REFERENCES jc_passport_office(p_office_id) ON DELETE NO ACTION,
    FOREIGN KEY (w_university_id) REFERENCES jc_university(university_id) ON DELETE NO ACTION,
    FOREIGN KEY (register_office_id) REFERENCES jc_register_office(r_office_id) ON DELETE CASCADE
)

CREATE TABLE jc_student_child
(
    student_child_id [int] IDENTITY(1,1) NOT NULL,
    student_order_id [int] not null,
    c_sur_name [nvarchar](100) not null,
    c_given_name [nvarchar](100) not null,
    c_patronymic [nvarchar](100) not null,
    c_date_of_birth [date] not null,
    c_certificate_number [nvarchar](10) not null,
    c_certificate_date [date] not null,
    c_register_office_id [int] not null,
    c_post_index [nvarchar](10),
    c_street_code [int] not null,
    c_building [nvarchar](10) not null,
    c_extension [nvarchar](10),
    c_apartment [nvarchar](10),
    PRIMARY KEY (student_child_id),
    FOREIGN KEY (c_street_code) REFERENCES jc_street(street_code) ON DELETE CASCADE,
    FOREIGN KEY (c_register_office_id) REFERENCES jc_register_office(r_office_id) ON DELETE CASCADE
)

CREATE INDEX idx_student_order_status ON jc_student_order(student_order_status);

CREATE INDEX idx_student_order_id ON jc_student_child(student_order_id);