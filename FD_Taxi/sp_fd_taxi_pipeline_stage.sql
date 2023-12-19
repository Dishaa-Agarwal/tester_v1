USE DATABASE FEATURESTORE_DB; -- noqa: PRS
USE SCHEMA FEATURESTORE_SCHEMA;
USE ROLE FEATURESTORE_ROLE;

CREATE OR REPLACE PROCEDURE SP_FD_TAXI_PIPELINE_STAGE(OBJECTIVE VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS '
BEGIN
    IF (UPPER(objective) IN (''STAGES'', ''STAGES & PIPES'')) THEN
        CREATE OR REPLACE STAGE FD_TAXI_DATA_STAGE
	        DIRECTORY = ( ENABLE = true );
    END IF;
    IF (UPPER(objective) IN (''PIPES'', ''STAGES & PIPES'')) THEN
        CREATE OR REPLACE PIPE FD_TAXI_DATA_PIPE
            auto_ingest=false
        AS
        COPY INTO BRONZE_FD_TAXI_RAW FROM @FD_TAXI_DATA_STAGE FILE_FORMAT=(FORMAT_NAME=''CSV_FORMAT'');
    END IF;
END';
