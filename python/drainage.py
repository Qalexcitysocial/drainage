#!/usr/bin/env python

##############################################################################
#
# Written by Alex Gomez for the Raspberry Pi - 2016
#
# Website:
# Contact: alejandrogomezpublic@gmail.com
#
# Feel free to use and modify this code for you own use in any way.
#
# This program is designed to turn ON / OFF GPIO ports and relays on and off
# at set times stored in a MySql database.
#
##############################################################################


import RPi.GPIO as GPIO #import library to read port GPIO
import time             # that allow to sleep timers

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(17, GPIO.IN) #Read output from crontroller detector
GPIO.setup(7, GPIO.OUT) #Water pump or selenoid Off

buoy = 0
elec_valve = 0

while  True:
    if GPIO.input(17)  == 1:                        #check the status of the signal wa$
        print ("Botella Patron vacia o dispnible")  #if the sensor is ON Down will act$
        GPIO.output(7, 0)                           #Water pump or selenoid Off
        time.sleep(5)
        buoy += 1

    elif GPIO.input(17)  == 0:                      #when output from sensor water lev$
        print ("Riego detectado, bomba activada")
        GPIO.output(7, 1)                           #Water pump or selenoid On
        time.sleep(5)
        elec_valve +=1

    total_irrigation = buoy - elec_valve

print buoy
print elec_valve
print total_irrigation

GPIO.clean()

#Open database connection
db = MySQLdb.connect("localhost", "datalogger","datalogger","datalogger")

curs = db.cursor()
try:
   #sqlline = "insert into distance values (NOW(), {0:0.1f});".format(buoy)
   #sqlline = "insert into distance values (NOW(), {0:0.1f});".format(elec_valve)
   sqlline = "insert into irrigation values (NOW(), {0:0.1f});".format(total_irrigation)
   curs.execute(sqlline)
   curs.execute ("DELETE FROM irrigation WHERE ttime < NOW() -INTERVAL 1 DAY;")
   db.commit()
   print "Data committed"

except MySQLdb.Error as e:
   print ("Error: the database is being rolled back" + str(e))
   db.rollback()
   print ("Failed to get reading. Try again!")
   db.close()