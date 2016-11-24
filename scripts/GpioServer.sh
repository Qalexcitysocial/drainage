#!/usr/bin/env bash

mysqlusername="root"
mysqlpassword="Peluo2010"

#Set  Refresh
echo "How long do you want the wait time to be?"
read waitTime

#Invoke GPIO
echo "17" > /sys/class/gpio/export
echo "7" > /sys/class/gpio/export

#Start Loop
while :
do
#Read MySQL Data
#Direction
direction17=$(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword gpio -e "SELECT status FROM irrigation WHERE pinNumber='17'";)
direction7=$(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword gpio -e "SELECT status FROM irrigation WHERE pinNumber='7'";)
#Status
status17=$(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword gpio -e "SELECT status FROM irrigation WHERE pinNumber='17'";)
status7=$(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword gpio -e "SELECT status FROM irrigation WHERE pinNumber='7'";)

#Run Commands
if [ "$direction17" == "out" ]; then
    echo "out" > /sys/class/gpio/gpio17/direction
    if [ "$status17" == "1" ]; then
        echo "1" > /sys/class/gpio/gpio17/value
        $(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword sensor -e "INSERT INTO `irrigation` (`ttime`, `status`, `onoff`, `pinNumber`) VALUES (NOW(), '1', 'ON', '17')";)
        echo "GPIO 17 Turned On"
    else
        echo "0" > /sys/class/gpio/gpio17/value
        $(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword sensor -e "INSERT INTO `irrigation` (`ttime`, `status`, `onoff`, `pinNumber`) VALUES (NOW(), '0', 'OFF', '17')";)
        echo "GPIO 17 Turned Off"
    fi
else
    echo "in" > /sys/class/gpio/gpio17/direction
fi
if [ "$direction7" == "out" ]; then
        echo "out" > /sys/class/gpio/gpio7/direction
    if [ "$status7" == "1" ]; then
                echo "1" > /sys/class/gpio/gpio7/value
                $(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword sensor -e "INSERT INTO `irrigation` (`ttime`, `status`, `onoff`, `pinNumber`) VALUES (NOW(), '1', 'ON', '7')";)
                echo "GPIO 7 Turned On"
        else
                echo "0" > /sys/class/gpio/gpio7/value
                $(mysql -B --disable-column-names --user=$mysqlusername --password=$mysqlpassword sensor -e "INSERT INTO `irrigation` (`ttime`, `status`, `onoff`, `pinNumber`) VALUES (NOW(), '0', 'OFF', '7')";)
                echo "GPIO 7 Turned Off"
        fi
else
        echo "in" > /sys/class/gpio/gpio7/direction
fi

#Complete Loop
sleep $waitTime
done