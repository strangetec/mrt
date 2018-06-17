MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Mission Ready'                                   AS CONFIG_VALUE,
           'Personnel is available for mission'              AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'On Mission'                                      AS CONFIG_VALUE,
           'Personnel is currently on mission'               AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Profile - Mission Capable'                       AS CONFIG_VALUE,
           'Personnel has a profile but mission capable'     AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Profile - Mission Incapable'                     AS CONFIG_VALUE,
           'Personnel has a profile and not mission capable' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'On Leave'                                        AS CONFIG_VALUE,
           'Personnel is currently on leave status'          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Equipment Maintenance'                           AS CONFIG_VALUE,
           'Personnel is maintaining equipment'              AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Rest Period'                                     AS CONFIG_VALUE,
           'Personnel is on post-mission rest period'        AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0';