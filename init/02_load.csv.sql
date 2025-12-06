SET search_path TO lab, public;

COPY all_mock_data
FROM '/data/all_mock_data.csv'
WITH (FORMAT csv, HEADER true, QUOTE '"', ESCAPE '"');
