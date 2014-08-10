##SCRIPT+######################################################################
# Script:  Scrip para linkear varios resultsID a un STP
# Se genera la variable del BugID contra los results 
# Michael Mejias Sanchez
# Tool para linkear
# Softtek
##SCRIPT-######################################################################
# Source Suite specific variables
#source {E:\libraryTCL\tools\commonVariables.tcl}
package require http
set aux 0
#Numero del Bug al que se va a linkear/BUGID 10322 for STP
set bugID 10322
set ResList {16076477 16042626 16076751}
set http ""
foreach ResultID $ResList {
set Newhttp "http://prodlabrpt.usa.hp.com/cgi-bin/db/dbUpdateDataBugs.pl?resultID=$ResultID&bugID=$bugID"
lappend ResultIdList $Newhttp
incr aux
}
#Completa el linkeo interactuando directamente con el CIT, despues de esto solo refrescar la pagina del CIT y listo.
foreach http $ResultIdList {
set html  [::http::geturl $http]
http::wait $html
}
#El bug ha sido linkeado al BugID corresponiente
puts "El linkeo ha sido exitoso y el numero de linkeos al bug generico de STP fueron de $aux"
eval exit
