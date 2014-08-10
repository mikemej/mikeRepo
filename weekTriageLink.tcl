#SCRIPT+######################################################################
# Script:  Para general el link del CIT y las corridas de los casos
# Se genera la variable link para formar el link de CIT y depues
# poner a correr los casos de los issues que se generan en CIT
# Michael Mejias Sanchez
# Tool para crear links 
# Softtek
#SCRIPT-######################################################################
#crear link del CIT
#
# link de CIT
set link {http://prodlabrpt.usa.hp.com/cgi-bin/testResults?restrict=programs.programName~not%20regexp~-%27Laredo%20PSR%7CCharleston%20Bedrock%27,results3.status~not%20regexp~%27Passed%27,results3.testCategory~%3D~%27CIT%27,programs.programName~regexp~%27gecko%7CKnoxville%7CNashville%20Aggregator%7CIrvine%20Bedrock%7Cspecials_quartz%7CPeridot%20Specials%7CCommon%20Criteria%20NDPP%7CLakes%20phase%202%7Cbolt%7Cmango%7Crel_jacksonville%7Claredo%20agregator%27&sort=results3.bugID&resultsPP=2000&cols=triage&dateRange=2w&showTADev=1&showBuilds=1}
package require http
set commandList ""
set noCommandList ""
set branchList ""
set htmlList ""
set bugList ""
set command ""
set aux 0
set noAux 0
set TESTWARE "\/pnb\/software\/at\/sand00\/mejiasmi\/testware"
set run 5
set slash "\\|"
regsub -all $slash $link {%7C} Link
#Extrae la informacion de CIT por medio del link
set http [http::geturl $Link]
set data [http::data $http]
#Se extrae solo la info de los casos para trabajar, eliminando los que ya possen, un BugID
puts "========================================/n $data /n==============================="
if {[regexp {(ResultStatus.*?LinkedToBug)} $data match citData]} {
	puts "1================================================================\n
	Esta es la nueva informacion del CIT :\n
	=======================================================================\n\n\n$citData"
} elseif {[regexp {(ResultStatus.*.)} $data match citData]} {
	puts  "2================================================================\n
	Esta es la nueva informacion del CIT :\n
	=======================================================================\n\n\n$citData"
} 
#Parseo para poder sacar la informacion necesaria para crear los commandos.
set att {</ul>}
regsub -all $att $citData {¢} text
set texto [split $text {¢}]
puts "----------------------------------------------------------------------\n
este es el slip de TEXTO :\n
----------------------------------------------------------------------------\n\n\n$texto"
foreach cont $texto {
   set valor [split $cont "\n"]
   foreach line $valor {
      if {[regexp {Result_ID\"\>\<.+\>([0-9]+)} $line match ResultID]} { ; #Se hace parseo del ResultID para hacer el linkeo si es necesario
      }
      if {[regexp {Family\"\>\<.+\>([a-zA-Z\-0-9]+)} $line match Family]} { ; #se obtiene la variable del Hardware
         switch $Family {
            "NULL" {
               set Newhttp "http://prodlabrpt.usa.hp.com/cgi-bin/db/dbUpdateDataBugs.pl?resultID=$ResultID&bugID=863&returnURL=%2Fcgi-bin%2FtestResults%3Frestrict%3Dresults3.testCategory~regexp~'CIT'%2Cresults3.status~not%2520regexp~'Passed'%26dateRange%3D1h"
                        lappend htmlList $Newhttp}

            "default"   {
               set runs $run
            }
         }
      }
      if {[regexp {Test_Case\"\>\<.+\>*build} $line]} {
      }
      if {[regexp {Test_Case\"\>\<.+\>([0-9A-Za-z\_\.\-]+)} $line match testCase]} { ; #Se hace parseo del Test Case a correr
         if {[regexp {build_} $testCase]} {
            set Newhttp "http://prodlabrpt.usa.hp.com/cgi-bin/db/dbUpdateDataBugs.pl?resultID=$ResultID&bugID=863&returnURL=%2Fcgi-bin%2FtestResults%3Frestrict%3Dresults3.testCategory~regexp~'CIT'%2Cresults3.status~not%2520regexp~'Passed'%26dateRange%3D1h"
                        lappend htmlList $Newhttp
         }
      }
      if {[regexp {Branch\"\>\<.+\>([0-9A-Za-z\_\.]+)} $line match branch]} {
         if {[regexp $branch $branchList] == 0} {
            lappend branchList $branch
         }
      }
      if {[regexp {Binary\"\>\<.+\>[a-z]+\/[A-Z0-9]+\/(.*.swi)} $line match build]} { ; #Se hace parseo del build a correr
         set command "autotest -t $testCase -h $Family -i $build -r $runs -dbTestProgram $branch -m $ResultID -y"
         if {[lsearch $commandList $command] == -1} {
            lappend commandList $command
            incr aux
         } else {
            lappend noCommandList $command 
            incr noAux
         }
      }
   }
}
#Este paso es para linkear todos los Family==NULL al bug ID 863
foreach bug863 $htmlList {
set html  [::http::geturl $bug863]
http::wait $html
}
after 5000 ; #tiempo de espera mientras realiza el linkeo
#Este paso pone a correr todos los commando en autotest
foreach br $branchList {
   foreach command $commandList {
      if {[regexp $br $command] == 1} {
         eval $command
      }
   }
}
