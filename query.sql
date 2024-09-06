-- Operador PIVOT o Similar
SELECT 
	models_id,
	SUM(CASE WHEN colors_id=1 THEN price ELSE 0 END) AS price_for_red,
	SUM(CASE WHEN colors_id=2 THEN price ELSE 0 END) AS price_for_blue
FROM
	sales_details
GROUP BY
	models_id
ORDER BY
	models_id;

-- Operador MERGE
CREATE TABLE sales_details_new AS TABLE sales_details;

TRUNCATE TABLE sales_details_new;

DELETE FROM sales_details_new
WHERE id = 3


MERGE INTO sales_details_new AS a
USING sales_details AS b
ON (a.id = b.id)
-- WHEN MATCHED THEN
--	UPDATE SET sales_id=99999 
WHEN NOT MATCHED THEN
	INSERT 
	VALUES (b.id, b.sales_id, b.models_id, b.colors_id, b.size_id, b.quantity, b.unit_measure_id, b.price, b.created_at, b.updated_at, b.deleted_at)

-- Bucles con Cursor
-- Sin Bucle
DO $$
DECLARE
    cursor_admins CURSOR FOR SELECT * FROM admins WHERE state = 'active';
    adm_id INT;
    adm_name TEXT;
BEGIN
    OPEN cursor_admins;
    FETCH cursor_admins INTO adm_id, adm_name;
    IF FOUND THEN
        RAISE NOTICE 'ID: %, Name: %', adm_id, adm_name;
    END IF;
    CLOSE cursor_admins;
END $$;

-- Con Bucle LOOP
DO $$
DECLARE
    cursor_admins CURSOR FOR SELECT * FROM admins WHERE state = 'active';
    adm_id INT;
    adm_name TEXT;
BEGIN
    OPEN cursor_admins;
    LOOP
        FETCH cursor_admins INTO adm_id, adm_name;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %, Name: %', adm_id, adm_name;
    END LOOP;
    CLOSE cursor_admins;
END $$;

-- Con Bucle While
DO $$
DECLARE
    cursor_admins CURSOR FOR SELECT * FROM admins WHERE state = 'active';
    adm_id INT;
    adm_name TEXT;
    fetch_status BOOLEAN := TRUE;
BEGIN
    OPEN cursor_admins;
    WHILE fetch_status LOOP
        FETCH cursor_admins INTO adm_id, adm_name;
        IF NOT FOUND THEN
            fetch_status := FALSE;
        ELSE
            RAISE NOTICE 'ID: %, Name: %', adm_id, adm_name;
        END IF;
    END LOOP;
    CLOSE cursor_admins;
END $$;

-- Con Bucle For
DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT * FROM admins WHERE state = 'active'
    LOOP
        RAISE NOTICE 'ID: %, Name: %', rec.id, rec.name;
    END LOOP;
END $$;
