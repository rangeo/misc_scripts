#!/bin/bash
####################################################################
# ------------------------------------------------------------------
#          [Author: RanjithGeorge] 
#	   
#          Title : cloudUpdate.sh
# 
#          Description:
#          This script updates the DB to cloud Database.
#	    	
#         
#     
# ------------------------------------------------------------------
####################################################################
LIMIT=1
#*****************************************************************#
# --- Check limit --------------------------------------------
#*****************************************************************#
COUNT=`curl -X GET http://admin:Ingersoll@10.200.105.41:5984/eor_logs | awk -F',' '{print $2}' | awk -F':' '{print $2}'`
LIMIT=$[LIMIT+9]

#*****************************************************************#
# --- Cloud update --------------------------------------------
#*****************************************************************#
if [ $COUNT -gt $LIMIT ]
then

CNTRLR_SERIAL=`curl -X GET http://admin:Ingersoll@10.200.105.41:5984/system_info/controllerInfoVersionInfo | awk -F',' '{print $4}' | awk -F':' '{print $2}'`
echo $CNTRLR_SERIAL
CNTRLR_SERIAL="db_$CNTRLR_SERIAL"
echo $CNTRLR_SERIAL
CLONE="'{\"source\": \"http://admin:Ingersoll@10.200.105.41:5984/eor_logs\", \"target\": \"https://admin:d51da63a1250@couchdb-fd83cf.smileupps.com/$CNTRLR_SERIAL\"}'"
echo $CLONE
curl -X PUT https://admin:d51da63a1250@couchdb-fd83cf.smileupps.com/$CNTRLR_SERIAL

curl -H 'Content-Type: application/json' -X POST http://admin:Ingersoll@10.200.105.41:5984/_replicate -d ' {"source": "http://admin:Ingersoll@10.200.105.41:5984/eor_logs", "target": "https://admin:d51da63a1250@couchdb-fd83cf.smileupps.com/db_123123123"}'

else
 echo "Limit not Crossed "
fi











