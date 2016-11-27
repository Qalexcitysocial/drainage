#!/usr/bin/env python
##############################################################################
#
# Written by Alex Gomez for the Raspberry Pi - 2016
#
# Website:
# Contact: by email
#
# Please feel free to use and modify this code for you own use.
#
# This program is designed to send an email with a subject line,
# an attachment, a sender, multiple receivers, Cc receivers and Bcc receivers.
# In addition it will also read a pre prepared file and use it's contents to
# create the body of the email
# I hope you are enjoy with this example and is usefull for you
#
##############################################################################

import RPi.GPIO as GPIO #importamos la libreria para leer los puertos
import time             # 
import MySQLdb
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(17, GPIO.IN) #Read output from moisture detector
GPIO.setup(7, GPIO.OUT) #Bomba de agua output pin

counter = 0
#Open database connection
db = MySQLdb.connect("localhost", "datalogger","datalogger","datalogger")
curs = db.cursor()

while  True:
       #GPIO.input(17)
    if GPIO.input(17)  == 1:
        print ("Botella vacia o dispnible")
        GPIO.output(7, 0) #Electrovalve off
        time.sleep(5)
        SQL = """INSERT INTO `irrigation` (`ttime`, `status`, `onoff`, `pinNumber`) VALUES (NOW(), '1', 'ON', '17');"""
        curs.execute(SQL)
        time.sleep(2)
        db.commit()
        print "Data committed"
    elif GPIO.input(17)  == 0:#when output from moisture is HIGH
        print ("Riego detectado, bomba activada")
        GPIO.output(7, 1)  #Electrovalve on
        time.sleep(5)
        SQL = """INSERT INTO `irrigation` (`ttime`, `status`, `onoff`, `pinNumber`) VALUES (NOW(), '0', 'OFF', '17');"""
        curs.execute(SQL)
     #   counter = counter+1
     #   print (counter)
        db.commit()
        print "Data committed"

GPIO.clean()
