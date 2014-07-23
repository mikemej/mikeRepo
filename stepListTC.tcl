##SCRIPT+######################################################################
# Script:  Para generar lista de pasos de un testcase con respecto a las descripciones de los pasos
# Michael Mejias Sanchez
# Tool para crear lista de pasos de un testcase
# Softtek
##SCRIPT-######################################################################
# Source Suite specific variables
source {E:\libraryTCL\tools\commonVariables.tcl}
set fileBuffer ""
set fileBuffer1 [file normalize $fileBuffer]
set fileBuffer0 [open $fileBuffer1 r]
set buffer [read $fileBuffer0]
close $fileBuffer
set archivo {E:\\logs\\steps.txt}
set archive [file normalize $archivo]
set filetest [open $archive w]
if {[regexp "(START TEST CASE EXECUTION.*)" $buffer {} buffer]} {
}
set buff [split $buffer "\n"]
foreach ln $buff {
   if {[regexp {\#\s(.*\.)} $ln {} msg]} {
      puts $filetest "$mes \"$msg\""
      incr stepAux
   }
}
after 5000
puts $filetest "El total de pasos es de: $stepAux"
close $filetest
