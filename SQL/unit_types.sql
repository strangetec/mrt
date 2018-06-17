MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                AS PARENT_ID,
           'Army Unit Type'         AS CONFIG_VALUE,
           'Types of US Army units' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Unit Type'
    UNION ALL
    SELECT CONFIG_ID                AS PARENT_ID,
           'Air Force Unit Type'         AS CONFIG_VALUE,
           'Types of US Air Force units' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Unit Type';
    
-- Army Unit Types
MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Field Army'                   AS CONFIG_VALUE,
           'US Field Army Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Corps'                   AS CONFIG_VALUE,
           'US Army Corps Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Division'                AS CONFIG_VALUE,
           'US Army Division Unit Type'   AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Brigade'                 AS CONFIG_VALUE,
           'US Army Brigade Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Regiment'                AS CONFIG_VALUE,
           'US Army Regiment Unit Type'   AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Group'                   AS CONFIG_VALUE,
           'US Army Group Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Battalion'               AS CONFIG_VALUE,
           'US Army Battalion Unit Type'  AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Squadron'                AS CONFIG_VALUE,
           'US Army Squadron Unit Type'   AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Company'                 AS CONFIG_VALUE,
           'US Army Company Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Battery'                 AS CONFIG_VALUE,
           'US Army Battery Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Troop'                   AS CONFIG_VALUE,
           'US Army Troop Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Detachment'              AS CONFIG_VALUE,
           'US Army Detachment Unit Type' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Platoon'                 AS CONFIG_VALUE,
           'US Army Platoon Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type');