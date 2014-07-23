###################################################################
##Script to parse all the commands of the detail.log file.
##The Script takes the topology and all the commands that was
##sent by the dut and the workstation in the test case.
###################### parseDetail_log ############################
package require http
source {E:\\libraryTCL\\tools\\commonVariables.tcl}
set arg $parseDetail::arg

proc parseUrl {url} {
    set runList ""
    set link [http::geturl $url]
    set buffer [http::data $link]
    set div {<tr}
    regsub -all $div $buffer {¢} newBuffer
    foreach test [split $newBuffer {¢}] {
        if {[regexp {Stripe.\sResultStatus(\w+)\"\>} $test {} status]} {
            set status [string tolower $status]
            if {$status == "failed"} {
                if {[regexp {class\=\"Logs\"\>\<.*?href\=\"(.*?\/(G[0-9]+)\/.*)\"\>Test} $test {} run ID]} {
                    set tail {/detail.log}
                    set runID [concat $run$tail]
                    lappend runList $runID
                }
            }

        }      
    }
    return $runList
}

proc parseDetail {link} {
    set stepResult 0
    set stepH ""
    set match 0
    set errorList 0
    set commandList ""
    regexp {(U[0-9]+).(G[0-9]+)} $link {} testID GID
    if {[file exist "E:\\logs\\$testID"] != 1} {
        set dir "E:\\logs\\$testID"
        set aa [file mkdir "E:\\logs\\$testID"]
    } else {
        set dir "E:\\logs\\$testID"
    }
    set File "$dir\\run$GID.txt"
    set file [file normalize $File]
    set filelog [open $file w]
    puts $filelog "\n \n ..... Parsing commands and outputs .....\n \n"
    set url [http::geturl $link]
    set data [http::data $url]
    regexp {Test Case Information.*?debug} $data testInfo
    regexp {testCaseName\s+\:\s([0-9a-zA-Z\_\.]+)} $testInfo {} testCaseName
    regexp {targetBuild \s+\:\s.+?/U[0-9]+/(\w+.swi)} $testInfo {} testBuild
    regexp {testCase\s+\:\s(.+.tcl)} $testInfo {} testCasePath
    regexp {mappingTargetDevice\s+\:\s([\w-]+)} $testInfo {} targetDevice
    puts $filelog "################################# Test Case Information #################################\n"
    puts $filelog "Test Case Name:  $testCaseName\n"
    puts $filelog "Test Case Name path:  $testCasePath\n"
    puts $filelog "Test Build:  $testBuild\n"
    puts $filelog "Test Target Device:  $targetDevice\n"
    puts $filelog "#########################################################################################\n\n"
    regexp {TEST CASE START.*?debug} $data topoInfo
    puts $filelog "###########################    Topology for  the test case    ###########################"
    puts $filelog "Test case name Topology : $testCaseName\n\n"
    foreach line [split $topoInfo \n] {
        if {[regexp {\[\w+\](.*)} $line {} topo]} {
            puts $filelog $topo
        }
    }
    puts $filelog "###########################################################################\n\n"
    puts $filelog "\n -- STEPS START HERE AND INCLUDE THE SHOW COMMANDS USED --\n"
    regexp {STEP\+.*RESULT\+} $data steps
    set sub {STEP\+}
    regsub -all $sub $steps {¢} Pasos
    foreach step [split $Pasos {¢}] {
        if {[regexp {(Step.+?)info} $step {} stepH]} {
            set stepResult 0
            regexp {Step\s+[0-9]+:.+:.+ed} $stepH stepResult
            if {$stepResult == 0} {
                puts $filelog "\n###########################################################################"
                puts $filelog "# $stepH###########################################################################\n"
            } 
        }
        if {[regexp {Att.+d\s+.*\s+took} $step match]} {
            set att "Attempting"
            regsub -all $att $match {^} Commandos
            foreach cmd [split $Commandos {^}] {
                if {[regexp {send the command\s+(.+)\s?to.+workstationFunc.+CLI} $cmd {} unixComm]} {
                    puts $filelog "Workstation command : $unixComm" 
                    lappend commandList $unixComm
                } elseif {[regexp {send the command\s+(.+)\s?to.+procurveFunc.+Device} $cmd {} command]} {
                    puts $filelog "Switch command : $command" 
                    lappend commandList $command
                } elseif {[regexp {send the command\s+(.+)\s?to.+switchFunc.+CLI} $cmd {} command0]} {
                    puts $filelog "Switch command : $command0"
                    lappend commandList $command0
                }
            }
            set output 0
            if {[regexp {[\[\]\:A-Za-z]+\sexp[0-9]+\s(\{[A-Za-z0-9\s\-\:\(\)\.\,\'\;\[\]\@\=\<\>\*\~\%\#\"\_\/\|\+]+\})} $cmd {} output]} {
                if {$output != 0} {
                    puts $filelog "Output : $output\n"
                } 
            }
        }
        if {$stepResult != 0} {
            puts $filelog "\n***** $stepResult *****\n"
        }
    }
    puts $filelog "\n###### Invalid Input Information ######\n"
    foreach li [split $data "\n"] {
        if {[regexp {(Invalid\sinput\:.*)} $li {} error]} {
            lappend errorList $error
        }
    }
    if {$errorList == 0} {
        puts $filelog "No invalid inputs found"
    } else { 
        foreach error $errorList {
            puts $filelog "An \"Invalid input\" was found : $error"
        }
    }
    after 5000
    puts $filelog "\n\n\n#################################################################"
    puts $filelog "# ALL COMMANDS USED IN Test Case $testCaseName"
    puts $filelog "#################################################################\n\n\n"
    foreach command $commandList {
        puts $filelog $command
    } 
    http::cleanup $link
    close $filelog
    eval exit
}

foreach test [parseUrl $arg] {
    parseDetail $test
}



