CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;


DROP TABLE IF EXISTS bronze.classes;

CREATE TABLE IF NOT EXISTS bronze.classes
(
    SIGLA text COLLATE pg_catalog."default" NOT NULL,
    DISCIPLINA text COLLATE pg_catalog."default",
    TPEI text COLLATE pg_catalog."default",
    RECOMENDACAO text COLLATE pg_catalog."default",
    OBJETIVOS text COLLATE pg_catalog."default",
    METODOLOGIA_EXTENSIONISTA text COLLATE pg_catalog."default",
    EMENTA text COLLATE pg_catalog."default",
    BIBLIOGRAFIA_BASICA text COLLATE pg_catalog."default",
    BIBLIOGRAFIA_COMPLEMENTAR text COLLATE pg_catalog."default",
    CONSTRAINT classes_pkey PRIMARY KEY (SIGLA)
);

DROP TABLE IF EXISTS bronze.Biliography_Basic;

CREATE TABLE IF NOT EXISTS bronze.Biliography_Basic
(
    SIGLA text COLLATE pg_catalog."default" NOT NULL,
    BIBLIOGRAFIA_BASICA text COLLATE pg_catalog."default"
);
DROP TABLE IF EXISTS bronze."Biliography_Complementary";

CREATE TABLE IF NOT EXISTS bronze."Biliography_Complementary"
(
    "SIGLA" text COLLATE pg_catalog."default",
    "BIBLIOGRAFIA COMPLEMENTAR" text COLLATE pg_catalog."default"
);

----------------------- COMMENT: SILVER
DROP TABLE IF EXISTS silver.classes;
CREATE TABLE IF NOT EXISTS silver.classes
(
    Class_Code TEXT COLLATE pg_catalog."default" NOT NULL,
    Class_Name TEXT COLLATE pg_catalog."default",
    CONSTRAINT classes_pkey PRIMARY KEY (Class_Code)
);


DROP TABLE IF EXISTS silver.Biliography_Basic;
CREATE TABLE IF NOT EXISTS silver.Biliography_Basic
(
    Class_Code text COLLATE pg_catalog."default" NOT NULL,
    Basic_Bibliography text COLLATE pg_catalog."default",
	CONSTRAINT basic_readings 
		FOREIGN KEY (Class_Code) REFERENCES silver.classes(Class_Code) 
);

DROP TABLE IF EXISTS silver.Dependencies;
CREATE TABLE IF NOT EXISTS silver.Dependencies
(
    Class_Code text COLLATE pg_catalog."default" NOT NULL,
    Dependencies text COLLATE pg_catalog."default",
	CONSTRAINT ct_dependencies 
		FOREIGN KEY (Class_Code) REFERENCES silver.classes(Class_Code) 
);

DROP TABLE IF EXISTS silver.Properties;
CREATE TABLE IF NOT EXISTS silver.Properties
(
    Class_Code text COLLATE pg_catalog."default" NOT NULL,
    Properties text COLLATE pg_catalog."default",
	CONSTRAINT ct_properties 
		FOREIGN KEY (Class_Code) REFERENCES silver.classes(Class_Code) 
);

----------------------- COMMENT: GOLDEN LAYER

DROP TYPE gold.vertex_type;
CREATE TYPE gold.vertex_type 
AS ENUM (
	 'Class'
	,'Basic_Bibliography'
	,'Complementary_Bibliography'
);


DROP TABLE IF EXISTS gold.vertices;
CREATE TABLE gold.vertices 
	(
    identifier TEXT, 
	type	   gold.vertex_type,
	properties JSON
);	
