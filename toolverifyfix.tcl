##SCRIPT+######################################################################
# Script:  Scrip para verificar CRs
# Se generan los comandos para correr el test case a probar
# Michael Mejias Sanchez
# Tool para comprobar el fix en CR fixing
# Softtek
##SCRIPT-######################################################################
#En este espacio se pega el contenido del correo para parsear los commandos
source {E:\libraryTCL\tools\commonVariables.tcl}
set email $fixVer::email
set TESTWARE "\/pnb\/software\/at\/sand00\/mejiasmi\/testware -preMaintenance 1"
set Command ""
set CommandList ""
set sub {<Email Address>}
set test {<testcaseName>}
set run {<NoOfExecutions>}
set message {<TestRunTag>}
set auto {autotest}
set Div {AutotestCommand}
set tc $fixVer::tc
set rep $fixVer::rep
regsub -all $sub $email {} texto
regsub -all $test $texto $tc texto1
regsub -all $run $texto1 $rep texto2
regsub -all $message $texto2 "Testing_Fix" texto3
regsub -all $auto $texto3 "\/tools\/autotest " texto4
regsub -all $Div $texto4 {¢} texto5
puts $texto5
set Text [split $texto5 "¢"]
puts $Text
foreach linea $Text {
   if {[regexp {(/tools/autotest.*.?TESTWARE)} $linea match Command]} {
      lappend CommandList $Command
   } 
}
foreach Command $CommandList {
eval "plink -load HP $Command"
#puts $Command
}
puts "Fin de las corridas para verificar el fix"
