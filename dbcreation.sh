#!/bin/sh

# MACROS OF DATABASE NAMES
DB_ANGLE_STEP=angle_step
DB_AUDIT_LOGS=audit_logs
DB_CONFIG_LIST=config_list
DB_EOR_LOGS=eor_logs
DB_EOR_PARAM_LIST=eor_param_list
DB_EVENT_LOGS=event_logs
DB_PROCESS_LIST=process_list
DB_SECURITY=security
DB_SETTINGS=settings
DB_TOOL_DETAILS=tool_details
DB_TOOL_FAULT=tool_fault
DB_TORQUE_STEP=torque_step
DB_TRACE_LOGS=trace_logs
DB_EOR_DATAOUT_PREFERENCES=eor_dataout_preferences
DB_CYCLE_RESULTS_PREFERENCES=cycle_results_preferences
DB_SYSTEM_INFO=system_info
DB_STAT_ALARM=stat_alarm
DB_STATS_SETTINGS=stats_settings
DB_TIMEZONES=timezones
DB_DEVICE_IO_BEHAVIOUR=device_io_behaviour
DB_DIO_ASSIGNMENT=dio_assignment
DB_PREVAILINGTORQUE_STEP=prevailingtorque_step
DB_FIELDBUS_SETTINGS=fieldbus_settings
DB_ACCESS_PERMISSION=access_permission
DB_DEFAULT_CYCLE_LOG_PERMISSION=default_cycle_log_permission
DB_USERS_GLOBAL_SETTING=users_global_settings
DB_MENU_TABLE=menu_table

DB_SECURITY_NEW_USERNAME=admin
DB_SECURITY_NEW_PASSWORD=Ingersoll

DB_SECURITY_OLD_USERNAME=admin
DB_SECURITY_OLD_PASSWORD=Ingersoll

#FUNCTION TO SECURE DATABASE
SecuringDatabase() {
    echo "************************************************************************"
    echo "               SECURING $1 DATABASE                  "
    echo "************************************************************************"
    curl -X PUT http://$DB_SECURITY_NEW_USERNAME:$DB_SECURITY_NEW_PASSWORD@127.0.0.1:5984/$1/_security -d '{"admins":{"names":["$DB_SECURITY_NEW_USERNAME"], "roles":[]}, "members":{"names":["$DB_SECURITY_NEW_USERNAME"],"roles":[]}}'
    
    echo " $1 Database is Secured \n"
}

#DELETING SERVER ADMIN FOR CHANGE IN USERNAME AND PASSWORD
curl -X DELETE http://$DB_SECURITY_OLD_USERNAME:$DB_SECURITY_OLD_PASSWORD@127.0.0.1:5984/_config/admins/$DB_SECURITY_OLD_USERNAME

#CREATING SERVER ADMIN TO SECURE DATABASE
curl -X PUT http://127.0.0.1:5984/_config/admins/$DB_SECURITY_NEW_USERNAME -d '"'$DB_SECURITY_NEW_PASSWORD'"'

if [ "$1" = "factoryreset" ]
then
   echo "reset database to default"
   option=1
else
   echo "**********Database Creation Menu Options********"
   echo "0..........Exit"
   echo "1..........Creates all Databases"
   echo "2..........DBSettingsCreation"
   echo "3..........DBAngleStepsCreation"
   echo "4..........DBTorqueStepsCreation"
   echo "5..........DBConfigListCreation"
   echo "6..........DBProcessCreation"
   echo "7..........DBToolDataCreation"
   echo "8..........DBEorLogsCreation"
   echo "9..........DBAuditLogsCreation"
   echo "10.........DBEventLogsCreation"
   echo "11.........DBSecurityCreation"
   echo "12.........DBMenuTableCreation"
   echo "13.........DBEorParamListCreation"
   echo "14.........DBToolFaultDataCreation"
   echo "15.........DBTraceLogsCreation"
   echo "16.........DBCycleResultsPreferencesCreation"
   echo "17.........DBEorDataoutPreferencesCreation"
   echo "18.........DBStatsSettingsCreation"
   echo "19.........DBSystemInfoCreation"
   echo "20.........DBTimezonesCreation"
   echo "21.........DBDIOBehaviorCreation"
   echo "22.........DBStatsAlarmCreation"
   echo "23.........DBDIOAssignmentCreation"
   echo "24.........DBPrevailingTorqueStepsCreation"
   echo "25.........DBFieldbusSettingsCreation"
   echo "26.........DBAccessPermissionCreation"
   echo "27.........DBDefaultCycleLogPermissionCreation"
   echo "28.........DBUsersGlobalSettingsCreation"
   echo -n "Enter the Option : "
   read option
fi

case $option in 
# Creating DB Settings
0) echo "0. Exiting ..."
   exit
   ;;
# NOTE: case 1 is in the end
2) echo "2. Creating... DBSettingsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBSettingsCreation/DBSettingsCreation &
    sleep 2
    SecuringDatabase "$DB_SETTINGS"
    sleep 1
    ;;
3) echo "3. Creating... DBAngleStepsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBAngleStepsCreation/DBAngleStepsCreation &
    sleep 1
    SecuringDatabase "$DB_ANGLE_STEP"
    sleep 1
    ;;
4) echo "4. Creating... DBTorqueStepsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBTorqueStepsCreation/DBTorqueStepsCreation &
    sleep 1
    SecuringDatabase "$DB_TORQUE_STEP"
    sleep 1
    ;;
5) echo "5. Creating... DBConfigListCreation"
    /root/ESSE/DB_Creation/DBCreation/DBConfigListCreation/DBConfigListCreation &
    sleep 1
    SecuringDatabase "$DB_CONFIG_LIST"
    sleep 1
   ;;
6) echo "6. Creating... DBProcessCreation"
    /root/ESSE/DB_Creation/DBCreation/DBProcessCreation/DBProcessCreation &
    sleep 1
    SecuringDatabase "$DB_PROCESS_LIST"
    sleep 1
   ;;
7) echo "7. Creating... DBToolDataCreation"
    /root/ESSE/DB_Creation/DBCreation/DBToolDataCreation/DBToolDataCreation &
    sleep 1
    SecuringDatabase "$DB_TOOL_DETAILS"
    sleep 1
   ;;
8) echo "8. Creating... DBEorLogsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBEorLogsCreation/DBEorLogsCreation &
    sleep 1
    SecuringDatabase "$DB_EOR_LOGS"
    sleep 1
   ;;
9) echo "9. Creating... DBAuditLogsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBAuditLogsCreation/DBAuditLogsCreation &
    sleep 1
    SecuringDatabase "$DB_AUDIT_LOGS"
    sleep 1
   ;;
10) echo "10.Creating... DBEventLogsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBEventLogsCreation/DBEventLogsCreation &
    sleep 1
    SecuringDatabase "$DB_EVENT_LOGS"
    sleep 1
    ;;
11) echo "11.Creating... DBSecurityCreation"
    /root/ESSE/DB_Creation/DBCreation/DBSecurityCreation/DBSecurityCreation &
    sleep 1
    SecuringDatabase "$DB_SECURITY"
    sleep 1
    ;;
12) echo "12.Creating... DBMenuTableCreation"
    /root/ESSE/DB_Creation/DBCreation/DBMenuTableCreation/DBMenuTableCreation &
    sleep 2
    SecuringDatabase "$DB_MENU_TABLE"
    sleep 1
    ;;
13) echo "13.Creating... DBEorParamListCreation"
    /root/ESSE/DB_Creation/DBCreation/DBEorParamListCreation/DBEorParamListCreation &
    sleep 1    
    SecuringDatabase "$DB_EOR_PARAM_LIST"
    sleep 1
    ;;
14) echo "14.Creating... DBToolFaultDataCreation"
    /root/ESSE/DB_Creation/DBCreation/DBToolFaultDataCreation/DBToolFaultDataCreation &
    sleep 1    
    SecuringDatabase "$DB_TOOL_FAULT"
    sleep 1
    ;;
15) echo "15.Creating... DBTraceLogsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBTraceLogsCreation/DBTraceLogsCreation &
    sleep 1    
    SecuringDatabase "$DB_TRACE_LOGS"
    sleep 1
    ;;
16) echo "16.Creating... DBCycleResultsPreferencesCreation"
    /root/ESSE/DB_Creation/DBCreation/DBCycleResultsPreferencesCreation/DBCycleResultsPreferencesCreation &
    sleep 1    
    SecuringDatabase "$DB_CYCLE_RESULTS_PREFERENCES"
    sleep 1
    ;;
17) echo "17.Creating... DBEorDataoutPreferencesCreation"
    /root/ESSE/DB_Creation/DBCreation/DBEorDataoutPreferencesCreation/DBEorDataoutPreferencesCreation &
    sleep 1    
    SecuringDatabase "$DB_EOR_DATAOUT_PREFERENCES"
    sleep 1
    ;;
18) echo "18.Creating... DBStatsSettingsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBStatsSettingsCreation/DBStatsSettingsCreation &
    sleep 1    
    SecuringDatabase "$DB_STATS_SETTINGS"
    sleep 1
    ;;
19) echo "19.Creating... DBSystemInfoCreation"
    /root/ESSE/DB_Creation/DBCreation/DBSystemInfoCreation/DBSystemInfoCreation &
    sleep 1    
    SecuringDatabase "$DB_SYSTEM_INFO"
    sleep 1
    ;;
20) echo "20.Creating... DBTimezonesCreation"
    /root/ESSE/DB_Creation/DBCreation/DBTimezonesCreation/DBTimezonesCreation &
    sleep 1    
    SecuringDatabase "$DB_TIMEZONES"
    sleep 1
    ;;
21) echo "21.Creating... DBDIOBehaviorCreation"
    /root/ESSE/DB_Creation/DBCreation/DBDIOBehaviorCreation/DBDIOBehaviorCreation &
    sleep 1    
    SecuringDatabase "$DB_DEVICE_IO_BEHAVIOUR"
    sleep 1
    ;;
22) echo "22.Creating... DBStatsAlarmCreation"
    /root/ESSE/DB_Creation/DBCreation/DBStatsAlarmCreation/DBStatsAlarmCreation &
    sleep 1    
    SecuringDatabase "$DB_STAT_ALARM"
    sleep 1
    ;;
23) echo "23.Creating... DBDIOAssignmentCreation"
    /root/ESSE/DB_Creation/DBCreation/DBDIOAssignmentCreation/DBDIOAssignmentCreation &
    sleep 1    
    SecuringDatabase "$DB_DIO_ASSIGNMENT"
    sleep 1
    ;;
24) echo "24.Creating... DBPrevailingTorqueStepsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBPrevailingTorqueStepsCreation/DBPrevailingTorqueStepsCreation &
    sleep 1    
    SecuringDatabase "$DB_PREVAILINGTORQUE_STEP"
    sleep 1
    ;;
25) echo "25.Creating... DBFieldbusSettingsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBFieldbusSettingsCreation/DBFieldbusSettingsCreation &
    sleep 1    
    SecuringDatabase "$DB_FIELDBUS_SETTINGS"
    sleep 1
    ;;
26) echo "26.Creating... DBAccessPermissionCreation"
    /root/ESSE/DB_Creation/DBCreation/DBAccessPermissionCreation/DBAccessPermissionCreation &
    sleep 1    
    SecuringDatabase "$DB_ACCESS_PERMISSION"
    sleep 1
    ;;
27) echo "27.Creating... DBDefaultCycleLogPermissionCreation"
    /root/ESSE/DB_Creation/DBCreation/DBDefaultCycleLogPermissionCreation/DBDefaultCycleLogPermissionCreation &
    sleep 1    
    SecuringDatabase "$DB_DEFAULT_CYCLE_LOG_PERMISSION"
    sleep 1
    ;;
28) echo "28.Creating... DBUsersGlobalSettingsCreation"
    /root/ESSE/DB_Creation/DBCreation/DBUsersGlobalSettingsCreation/DBUsersGlobalSettingsCreation &
    sleep 1    
    SecuringDatabase "$DB_USERS_GLOBAL_SETTING"
    sleep 1
    ;;
1) echo " Creating All Fresh ESSE DataBase"
   echo "2. Creating... DBSettingsCreation"
   if [ "$1" = "factoryreset" ] #check if the factory reset argument is passed
   then
      /root/ESSE/DB_Creation/DBCreation/DBSettingsCreation/DBSettingsCreation factoryreset &
      sleep 2
      SecuringDatabase "$DB_SETTINGS"
      sleep 1
   else     
      /root/ESSE/DB_Creation/DBCreation/DBSettingsCreation/DBSettingsCreation &
      sleep 2
      SecuringDatabase "$DB_SETTINGS"
      sleep 1
   fi
   echo "3. Creating... DBAngleStepsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBAngleStepsCreation/DBAngleStepsCreation &
   sleep 1
   SecuringDatabase "$DB_ANGLE_STEP"
   sleep 1

   echo "4. Creating... DBTorqueStepsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBTorqueStepsCreation/DBTorqueStepsCreation &
   sleep 1
   SecuringDatabase "$DB_TORQUE_STEP"
   sleep 1

   echo "5. Creating... DBConfigListCreation"
   /root/ESSE/DB_Creation/DBCreation/DBConfigListCreation/DBConfigListCreation &
   sleep 1
   SecuringDatabase "$DB_CONFIG_LIST"
   sleep 1

   echo "6. Creating... DBProcessCreation"
   /root/ESSE/DB_Creation/DBCreation/DBProcessCreation/DBProcessCreation &
   sleep 1
   SecuringDatabase "$DB_PROCESS_LIST"
   sleep 1

   echo "7. Creating... DBToolDataCreation"
   /root/ESSE/DB_Creation/DBCreation/DBToolDataCreation/DBToolDataCreation &
   sleep 1
   SecuringDatabase "$DB_TOOL_DETAILS"
   sleep 1

   echo "8. Creating... DBEorLogsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBEorLogsCreation/DBEorLogsCreation &
   sleep 1
   SecuringDatabase "$DB_EOR_LOGS"
   sleep 1

   echo "9. Creating... DBAuditLogsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBAuditLogsCreation/DBAuditLogsCreation &
   sleep 1
   SecuringDatabase "$DB_AUDIT_LOGS"
   sleep 1

   echo "10 Creating... DBEventLogsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBEventLogsCreation/DBEventLogsCreation &
   sleep 1
   SecuringDatabase "$DB_EVENT_LOGS"
   sleep 1

   echo "11. Creating... DBSecurityCreation"
   /root/ESSE/DB_Creation/DBCreation/DBSecurityCreation/DBSecurityCreation &
   sleep 1
   SecuringDatabase "$DB_SECURITY"
   sleep 1

   echo "12. Creating... DBMenuTableCreation"
   /root/ESSE/DB_Creation/DBCreation/DBMenuTableCreation/DBMenuTableCreation &
   sleep 2
   SecuringDatabase "$DB_MENU_TABLE"
   sleep 1

   echo "13. Creating... DBEorParamListCreation"
   /root/ESSE/DB_Creation/DBCreation/DBEorParamListCreation/DBEorParamListCreation &
   sleep 1
   SecuringDatabase "$DB_EOR_PARAM_LIST"
   sleep 1
   
   echo "14. Creating... DBToolFaultDataCreation"
   /root/ESSE/DB_Creation/DBCreation/DBToolFaultDataCreation/DBToolFaultDataCreation &
   sleep 1    
   SecuringDatabase "$DB_TOOL_FAULT"
   sleep 1
   
   echo "15. Creating... DBTraceLogsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBTraceLogsCreation/DBTraceLogsCreation &
   sleep 1    
   SecuringDatabase "$DB_TRACE_LOGS"
   sleep 1
   
   echo "16. Creating... DBCycleResultsPreferencesCreation"
   /root/ESSE/DB_Creation/DBCreation/DBCycleResultsPreferencesCreation/DBCycleResultsPreferencesCreation &
   sleep 1
   SecuringDatabase "$DB_CYCLE_RESULTS_PREFERENCES"
   sleep 1
   
   echo "17. Creating... DBEorDataoutPreferencesCreation"
   /root/ESSE/DB_Creation/DBCreation/DBEorDataoutPreferencesCreation/DBEorDataoutPreferencesCreation &
   sleep 1
   SecuringDatabase "$DB_EOR_DATAOUT_PREFERENCES"
   sleep 1
   
   echo "18. Creating... DBStatsSettingsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBStatsSettingsCreation/DBStatsSettingsCreation &
   sleep 1
   SecuringDatabase "$DB_STATS_SETTINGS"
   sleep 1
   
   if [ "$1" = "factoryreset" ] #check if the factory reset argument is passed
   then
      echo "skipping DBSystemInfo"
   else     
   	echo "19. Creating... DBSystemInfoCreation"
   	/root/ESSE/DB_Creation/DBCreation/DBSystemInfoCreation/DBSystemInfoCreation &
   	sleep 1
   	SecuringDatabase "$DB_SYSTEM_INFO"
  	sleep 1
   fi
    
   if [ "$1" = "factoryreset" ] #check if the factory reset argument is passed
   then
      echo "skipping DBTimeZoneCreation"
   else     
   	echo "20. Creating... DBTimezonesCreation"
   	/root/ESSE/DB_Creation/DBCreation/DBTimezonesCreation/DBTimezonesCreation &
   	sleep 1
   	SecuringDatabase "$DB_TIMEZONES"
   	sleep 1
   fi
    
   echo "21. Creating... DBDIOBehaviorCreation"
   /root/ESSE/DB_Creation/DBCreation/DBDIOBehaviorCreation/DBDIOBehaviorCreation &
   sleep 1
   SecuringDatabase "$DB_DEVICE_IO_BEHAVIOUR"
   sleep 1
   
   echo "22. Creating... DBStatsAlarmCreation"
   /root/ESSE/DB_Creation/DBCreation/DBStatsAlarmCreation/DBStatsAlarmCreation &
   sleep 1
   SecuringDatabase "$DB_STAT_ALARM"
   sleep 1
   
   echo "23. Creating... DBDIOAssignmentCreation"
   /root/ESSE/DB_Creation/DBCreation/DBDIOAssignmentCreation/DBDIOAssignmentCreation &
   sleep 1
   SecuringDatabase "$DB_DIO_ASSIGNMENT"
   sleep 1
   
   echo "24. Creating... DBPrevailingTorqueStepsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBPrevailingTorqueStepsCreation/DBPrevailingTorqueStepsCreation &
   sleep 1
   SecuringDatabase "$DB_PREVAILINGTORQUE_STEP"
   sleep 1
   
   echo "25. Creating... DBFieldbusSettingsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBFieldbusSettingsCreation/DBFieldbusSettingsCreation &
   sleep 1
   SecuringDatabase "$DB_FIELDBUS_SETTINGS"
   sleep 1
   
   echo "26. Creating... DBAccessPermissionCreation"
   /root/ESSE/DB_Creation/DBCreation/DBAccessPermissionCreation/DBAccessPermissionCreation &
   sleep 1
   SecuringDatabase "$DB_ACCESS_PERMISSION"
   sleep 1
   
   echo "27. Creating... DBDefaultCycleLogPermissionCreation"
   /root/ESSE/DB_Creation/DBCreation/DBDefaultCycleLogPermissionCreation/DBDefaultCycleLogPermissionCreation &
   sleep 1
   SecuringDatabase "$DB_DEFAULT_CYCLE_LOG_PERMISSION"
   sleep 1
   
   echo "28. Creating... DBUsersGlobalSettingsCreation"
   /root/ESSE/DB_Creation/DBCreation/DBUsersGlobalSettingsCreation/DBUsersGlobalSettingsCreation &
   sleep 1
   SecuringDatabase "$DB_USERS_GLOBAL_SETTING"
   sleep 1

   echo "Fresh ESSE DataBase Creation Complete"
   ;;

*) echo "Invalid option"
   ;;
esac
