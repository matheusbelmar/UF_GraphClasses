-- Matérias
INSERT INTO silver.classes (Class_Code, Class_Name)
SELECT
	   "SIGLA"
	  ,"DISCIPLINA"
FROM bronze.classes;

-- Bibliografia básica
INSERT INTO silver.bibliography_basic (Class_Code, Basic_Bibliography)
SELECT *
FROM bronze.biliography_basic
WHERE 
	"BIBLIOGRAFIA BÁSICA"<>'';

-- Bibliografia complementar
INSERT INTO silver.Biliography_Complementary (Class_Code, Complementary_Bibliography)
SELECT *
FROM bronze."Biliography_Complementary"
WHERE 
	"BIBLIOGRAFIA COMPLEMENTAR"<>'';

-- Recomendações
WITH 
Data_ST1 AS (
	SELECT 
		   "SIGLA" 												 AS Class_Code
		  ,regexp_replace(trim("RECOMENDAÇÃO"), '\s+', ' ', 'g') AS Dependencies
	FROM bronze."Dependencies"
	),
Data_ST2 AS (
SELECT
	   Class_Code
	  ,CASE
	  	WHEN Dependencies = 'Não há' THEN 'None'
		ELSE Dependencies
	   END
FROM Data_ST1)

INSERT INTO silver.Dependencies (Class_Code, Dependencies)
SELECT 
	   *
FROM Data_ST2;


-- Propriedades
INSERT INTO silver.Properties (Class_Code, Properties)
SELECT 
	   sigla
	  ,json_build_object(
	  'tpei', tpei,
	  'objectives', objetivos,
	  'Methodology', metodologia_extensionista,
	  'Syllabus', ementa)	AS properties
FROM bronze.classes;