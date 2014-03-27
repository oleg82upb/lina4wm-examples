# Bashskript für automatisiertes Testen von Promeladateien mit ispin :-)
# Benötigter Aufbau der Testdatei: ausgabedatei.txt;zuTestendeDatei.pml;LTLFormel1;LTLFormel2;... 
# author: Annika Mütze muetze.annika@gmail.com
# date: May 2013

## Komplieren von bash-dateien: chmod +x pfad/zu/mein_Skript 
## ausführen: ./skriptname Datei_aus_der_gelesen_werden_soll

#!/bin/bash

cd workspace/examples/Burns\ Mutex;

#zeilenweises Lesen einer Datei
if [ $# -lt 1 ]
then
   echo "usage: $0 datei_zum_lesen"
   exit 1
fi
#das Trennungszeichen ist nun ein ";"
BACKIFS="$IFS"
IFS=\;
counter=1
# Argument $1 (Eingabe beim Aufruf des Skripts) soll zeilenweise eingelesen werden
while read dateiinhalt
do
	set $dateiinhalt
	for daten in "$@"
	do
		case "$counter" in
			1) echo "ausgabedatei: $daten"
				#Datei, in die Ausgabe gespeichert wird
   			ausgabedatei=$daten
   			counter=`expr $counter + 1`
			;;
			2) echo "datei: $daten"
				#Name der zu überprüfenden Datei
				dateiname=$daten
				counter=`expr $counter + 1`
			
				spin -a $dateiname;
				gcc -DMEMLIM=1024 -O2 -DXUSAFE -w -o pan pan.c;
	
				if  !( [ -f "./$ausgabedatei" ] ) #wenn Datei exsistiert liefert [ -f "./$ausgabedatei" ] Wert ungleich null ("true") -> wegen Negation geht Skript dann in else Teil. Wenn Datei nicht existiert wird sie angelegt mit touch.
				then
					touch $ausgabedatei
				else 
					echo "Datei existiert bereits. Ändern Sie bitte den Namen der Ausgabedatei."
					exit
				fi
				echo "Test: $dateiname" >>$ausgabedatei
				echo "--------------------------------------------------------------------------------------------------------------" >>$ausgabedatei
				;;
			
			3) echo "Test: $daten"
				testname=$daten
								
				echo "---------$testname----------------------------------------------------------------------------------------------" >>$ausgabedatei
				echo "--------------------------------------------------------------------------------------------------------------" >>$ausgabedatei
				
				./pan -m10000  -a -n -N $testname >> $ausgabedatei 
				echo "--------------------------------------------------------------------------------------------------------------" >>$ausgabedatei
			;;
		esac
	   
	done
	counter=1

done < $1
IFS=$BACKIFS

