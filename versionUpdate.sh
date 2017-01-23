#!/bin/bash
####################################################################
# ------------------------------------------------------------------
#          [Author: RanjithGeorge] 
#	   
#          Title : versionUpdate.sh
# 
#          Description:
#          This script updates the version number to the Database.
#	    	
#          Dependency:.version file
#     
# ------------------------------------------------------------------
####################################################################



#*****************************************************************#
# --- OS Version update --------------------------------------------
#*****************************************************************#
OS_VERSION=`cat /.version`
DOC_REV=`curl -X GET http://admin:Ingersoll@10.200.106.82:5984/system_info/controllerInfoVersionInfo |  awk -F',' '{print $2}'`
T="\"sysOSVersion\":\"$OS_VERSION\""
echo $T
JSON_STR=`curl -X GET http://admin:Ingersoll@10.200.106.82:5984/system_info/controllerInfoVersionInfo`
JSON_FMTD=`echo $JSON_STR | sed 's/[^,]*/'$T'/'7`

echo $JSON_FMTD
#curl -X DELETE http://admin:Ingersoll@10.200.106.82:5984/system_info/controllerInfoVersionInfo

#*****************************************************************#
# --- Firmware Version update --------------------------------------------
#*****************************************************************#

#echo | awk '{ print index("'"${str}"'", "skid") }'                                          


