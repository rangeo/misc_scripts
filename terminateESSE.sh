#!/bin/sh

# *****************************************************************************
# *                     Proprietary Information of
# *                       Ingersoll-Rand Company
# *
# *                   Copyright 2015 ? Ingersoll-Rand
# *                         All Rights Reserved
# *
# * This document is the property of Ingersoll-Rand Company and contains
# * contains proprietary and confidential information of Ingersoll-Rand
# * Company.  Neither this document nor said proprietary information
# * shall be published, reproduced, copied, disclosed, or communicated to
# * any third party, nor be used for any purpose other than that stated
# * in the particular enquiry or order for which it is issued. The
# * reservation of copyright in this document extends from each date
# * appearing thereon and in respect of the subject matter as it appeared
# * at the relevant date.
# *
# *****************************************************************************

#******************************************************************************
# MODULE       : firmware update
#
# SUBSYSTEM    : 
#
# DESCRIPTION  : terminate modules
#
#*****************************************************************************

#All processes other than MCE will be terminated
#echo "Terminating DIO..."
#kill -9 $(ps aux | grep [D]IO | awk '{ print $2 }')
echo "Terminating Watchdog service..."
service watchdog stop
echo "Terminating All ESSE Module Processes Other Than FWUP..."
#kill -2 $(ps aux | grep [B]IN | awk '{ print $2 }')
#killall -s SIGINT $(ps aux | grep [B]IN | grep -v [F]WUP | awk '{ print $2 }')
kill -2 $(ps aux | grep [B]IN | grep -v [F]WUP | awk '{ print $2 }')
killall -I LicenseManager
#sleep 3

#Terminate MCE
#echo "Terminating MCE..."
#kill -9 $(ps aux | grep [M]CE | awk '{ print $2 }')

echo "Terminating... lucene"
#killall -9 java
service couchdb-lucene stop

echo "ALL Module Processes Terminated"
