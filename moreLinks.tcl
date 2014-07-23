##SCRIPT+######################################################################
# Script: Linkea bugs por medio de un link
# Michael Mejias Sanchez
# Tool para linkear varios bugs a un mismo bug ID por medio de un link de CIT
# Softtek
##SCRIPT-######################################################################
source {E:\libraryTCL\tools\commonVariables.tcl}
package require http
set link $moreLinks::link
set http [http::geturl $link]
set data [http::data $http]
set linkList ""
set bugID $moreLinks::bugID
#set bugID 10322
set httpList ""
set QTY 0
if {[regexp {(ResultStatus.*?LinkedToBug)} $data match citData]} {
   } elseif {[regexp {(ResultStatus.*.)} $data match citData]} {
   }
#En este paso se procede a particionar el domcumento para poder ser tratado por bloques, para\
poder sacar la informacion necesaria para crear los commandos.
   set att {</ul>}
	regsub -all $att $citData {¢} text		
	set texto [split $text {¢}]	
	foreach cont $texto {
		set valor [split $cont "\n"]
		foreach line $valor {
			if {[regexp {Result_ID\"\>\<.+\>([0-9]+)} $line match resID]} { ; #Se hace el pasrseo del ResultID
			   set httpList "http://prodlabrpt.usa.hp.com/cgi-bin/db/dbUpdateDataBugs.pl?resultID=$resID&bugID=$bugID&returnURL=%2Fcgi-bin%2FtestResults%3Frestrict%3Dresults3.testCategory~regexp~'CIT'%2Cresults3.status~not%2520regexp~'Passed'%26dateRange%3D1h"
				lappend linkList $httpList	
				incr QTY
			}
		}
	}
puts $linkList
#Completa el linkeo interactuando directamente con el CIT, despues de esto solo refrescar la pagina del CIT y listo.
foreach linked $linkList {
set html  [::http::geturl $linked]
http::wait $html	
} 
#El bug ha sido linkeado al BugID corresponiente y se muestra el siguiente mensaje para confirmar
if {$QTY != 1} {
   puts "Se han realizado $QTY linkeos exitosos al bugID $bugID"
} else {
	puts "Se han realizado un $QTY linkeo exitoso al bugID $bugID"
}
eval exit