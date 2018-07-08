MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                     AS PARENT_ID,
           'M1 Abrams'                   AS CONFIG_VALUE,
           'Battle Tank'                 AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Vehicle Type'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Bradley Fighting Vehicle'    AS CONFIG_VALUE,
           'Infantry Fighting Vehicle'   AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Vehicle Type'
      AND PARENT_ID = '0';

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                      AS PARENT_ID,
           'M1A1 SA/M1A1FEP'              AS CONFIG_VALUE,
           'Battle Tank'                  AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'M1 Abrams'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Vehicle Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'M1A2 SEP v2'                  AS CONFIG_VALUE,
           'Battle Tank'                  AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'M1 Abrams'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Vehicle Type');

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                      AS PARENT_ID,
           'M3A3 Bradley'                 AS CONFIG_VALUE,
           'Infantry Fighting Vehicle'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Bradley Fighting Vehicle'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Vehicle Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'M7 Bradley FiST'              AS CONFIG_VALUE,
           'Fire Support Vehicle'         AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Bradley Fighting Vehicle'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Vehicle Type');