MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army Ranks'                  AS CONFIG_VALUE,
           'US Army Ranks'               AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Rank Type';

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E1 - Private'                 AS CONFIG_VALUE,
           'PVT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E2 - Private Second Class'    AS CONFIG_VALUE,
           'PV2'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E3 - Private First Class'     AS CONFIG_VALUE,
           'PFC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E4 - Corporal'                AS CONFIG_VALUE,
           'CPL'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E4 - Specialist'              AS CONFIG_VALUE,
           'SPC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E5 - Sergeant'                AS CONFIG_VALUE,
           'SGT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E6 - Staff Sergeant'          AS CONFIG_VALUE,
           'SSG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E7 - Sergeant First Class'    AS CONFIG_VALUE,
           'SFC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E8 - Master Sergeant'         AS CONFIG_VALUE,
           'MSG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E8 - First Sergeant'          AS CONFIG_VALUE,
           '1SG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E9 - Sergeant Major'          AS CONFIG_VALUE,
           'SGM'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E9 - Command Sergeant Major'  AS CONFIG_VALUE,
           'CSM'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W1 - Warrant Officer 1'       AS CONFIG_VALUE,
           'WO1'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W2 - Chief Warrant Officer 2' AS CONFIG_VALUE,
           'CW2'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W3 - Chief Warrant Officer 3' AS CONFIG_VALUE,
           'CW3'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W4 - Chief Warrant Officer 4' AS CONFIG_VALUE,
           'CW4'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W5 - Chief Warrant Officer 5' AS CONFIG_VALUE,
           'CW5'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O1 - Second Lieutenant'       AS CONFIG_VALUE,
           '2LT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O2 - First Lieutenant'        AS CONFIG_VALUE,
           '1LT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O3 - Captain'                 AS CONFIG_VALUE,
           'CPT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O4 - Major'                   AS CONFIG_VALUE,
           'MAJ'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O5 - Lieutenant Colonel'      AS CONFIG_VALUE,
           'LTC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O6 - Colonel'                 AS CONFIG_VALUE,
           'COL'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O7 - Brigadier General'       AS CONFIG_VALUE,
           'BG'                           AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O8 - Major General'           AS CONFIG_VALUE,
           'MG'                           AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O9 - Lieutenant General'      AS CONFIG_VALUE,
           'LTG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O10 - General'                AS CONFIG_VALUE,
           'GEN'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type');