MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army'                        AS CONFIG_VALUE,
           'US Active Duty Army'         AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Air Force'                   AS CONFIG_VALUE,
           'US Active Duty Air Force'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Navy'                        AS CONFIG_VALUE,
           'US Active Duty Navy'         AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Marine Corps'                AS CONFIG_VALUE,
           'US Active Duty Marine Corps' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Coast Guard'                 AS CONFIG_VALUE,
           'US Coast Guard'              AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army Reserves'               AS CONFIG_VALUE,
           'US Army Reserves'            AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army Guard'                  AS CONFIG_VALUE,
           'US State Army Guard'         AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Air Force Reserves'          AS CONFIG_VALUE,
           'US Air Force Reserves'       AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Air Guard'                   AS CONFIG_VALUE,
           'US State Air Force Guard'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Marine Reserves'             AS CONFIG_VALUE,
           'US Marine Reserves'          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Navy Reserves'               AS CONFIG_VALUE,
           'US Navy Reserves'            AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Coast Guard Reserves'        AS CONFIG_VALUE,
           'US Coast Guard Reserves'     AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type';