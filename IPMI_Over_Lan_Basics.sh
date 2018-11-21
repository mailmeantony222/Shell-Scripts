#!/bin/bash
clear

# Set variables
read -p 'Enter BMC IP: ' IP
read -p 'Enter User Name: ' User
read -p 'Enter Password: ' Password
read -p 'Enter maximum limit(no of count to run script): ' Limit
count=1
rcount=0
DATE=`date`
SLEEP=0
SLEEP1=10
echo -e "\n Testing IPMI Commands Via LAN Interface..."

while [ $rcount -lt $Limit ] || [ $rcount -eq $Limit ]
do
        echo    " Script Started at: $DATE"
        echo -n " Current Time is : "
        date
        echo

        echo " $count) GET_DEV_ID"
        ipmitool -H $IP -U $User -P $Password -I lan raw 6 1
        count=$((count+1))
        echo
        sleep $SLEEP;



        echo " $count) GET_SELF_TEST"
        ipmitool -H $IP -U $User -P $Password -I lan raw 6 4
        count=$((count+1))
        echo
        sleep $SLEEP;
 
        echo " $count) GET_ACPI_POWER_STATE"
        ipmitool -H $IP -U $User -P $Password -I lan raw 6 7
        count=$((count+1))
        echo
        sleep $SLEEP;

        echo " $count) GET_DEV_GUID"
        ipmitool -H $IP -U $User -P $Password -I lan raw 6 8
        count=$((count+1))
        echo
        sleep $SLEEP;

        echo " $count) GET_LAN_IP"
        ipmitool -H $IP -U $User -P $Password -I lan raw 0x0c 0x02 0x01 0x04 0x00 0x00
        count=$((count+1))
        echo
        sleep $SLEEP;


        echo " $count) GET_FRU_INVENTORY"
        ipmitool -H $IP -U $User -P $Password -I lan raw 0x0A 0x10 0
        count=$((count+1))
        echo
        sleep $SLEEP;


	clear
	rcount=$((rcount+1))
	echo -e "\n Test Cycle complete($rcount)..."
done
