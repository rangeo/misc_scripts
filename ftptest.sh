#!/bin/bash
#############################################################################
#	     File	 : esse-build.sh		
#	     Description : script for building a tarball 
#			   environment and setting up PATH variables.
#	     Author	 : Ranjith George ranjith.dass@irco.com	      
#############################################################################
 
# Declare variable 

RELEASE_LABEL="ESSE_ER_3_4_4"
FTP_SERVER=""
RFS_PATH="/home/esse/"
RFS_NAME="Esse_ER_V_3_4_4_29_July_2016_DEV.tar.bz2"
ESSE_SCM_PATH=""
LOG_FILE="/var/log/esse-build.log"
EMU_PATH="/home/esse/esse-arm"

#FTP DEFINITIONS
HOST='ftp.irco.com'
USER='iGate'
PASSWD='xiu$piust5eC'
FILE='test.txt'



ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd build
put $RELEASE_LABEL.tar.bz2
quit
END_SCRIPT
exit 0








