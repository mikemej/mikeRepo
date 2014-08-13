###################################################################
## Script to parse all the commands of the detail.log file.
## The Script takes the topology and all the commands that was
## sent by the dut and the workstation in the test case.
## it does search for a software exception and look which link contain
## the software exception
###################### parseDetail_log ############################
package require http
#set arg http://pnb-cit-05.rose.hp.com/at/log00/essw_cit/C4086204/G00126/MemoryTest_OSPFv2_16K_Routes_0xa13db80_0/detail.log
set var http://prodlabrpt.usa.hp.com/cgi-bin/testResults?restrict=testrunid.testRunIdName~=~%27U4084644%27
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
                    set tail {/}
                    set runID [concat $run$tail]
                    lappend runList $runID
                }
            }
        }      
    }
    return $runList
}

proc splitLogsFiles {link} {
    set logList ""
    set url [http::geturl $link]
    set data [http::data $url]
    set newData [split $data \n]
    foreach l $newData {
        if {[regexp {href\=\"(.*?\.log)} $l {} log] == 1} {
            if {$log != "summary.log"} {
                set logPath [concat $link$log]
                lappend logList $logPath
            }
        }
    }
    return $logList
}

proc parseDetail {link} {
    global filelog
    set stepResult 0
    set stepH ""
    set match 0
    set errorList 0
    set commandList ""
    set testCaseName ""
    set testBuild ""
    set testCasePath ""
    set targetDevice ""
    set url [http::geturl $link]
    set data [http::data $url]
    regexp {Test Case Information.*?debug} $data testInfo
    regexp {testCaseName\s+\:\s([0-9a-zA-Z\_\.\-]+)} $testInfo {} testCaseName
    regexp {targetBuild \s+\:\s.+?/U[0-9]+/(\w+.swi)} $testInfo {} testBuild
    regexp {testCase\s+\:\s(.+.tcl)} $testInfo {} testCasePath
    regexp {mappingTargetDevice\s+\:\s([\w-]+)} $testInfo {} targetDevice
    puts $filelog "\n\n################################# Test Case Information #################################\n"
    puts $filelog "Test Case Name:  $testCaseName\n"
    puts $filelog "Test Case Name path:  $testCasePath\n"
    puts $filelog "Test Build:  $testBuild\n"
    puts $filelog "Test Target Device:  $targetDevice\n"
    puts $filelog "#########################################################################################\n\n"
    regexp {TEST CASE START.*?debug} $data topoInfo
    puts $filelog "###########################    Topology for  the test case    ###########################"
    puts $filelog "\nTest case name Topology : $testCaseName\n\n"
    foreach line [split $topoInfo \n] {
        if {[regexp {\[\w+\](.*)} $line {} topo]} {
            puts $filelog $topo
        }
    }
	set devList ""
	set lnkList ""
	if {[regexp {(TopologyMapProcess.+?debug)} $data {} map]} {
		foreach line [split $map \n] {
			if {[regexp {\]\sMapping.*(::.*)} $line {} mapDep]} {
				if {[regexp {topo.lnk} $mapDep] == 0} {
					lappend devList $mapDep
				} else {
					lappend lnkList $mapDep
				}
			}
		}
	}

	puts $filelog "\n################    LOGICAL TO PHYSICAL MAPPING    ######################\n"
	puts $filelog "-------        Device mapping      ------\n"
	foreach n $devList {
		puts $filelog $n
	}
	puts $filelog "\n-----  Topo Link Device mapping  -----\n"
	foreach n $lnkList {
		puts $filelog $n
	}

    puts $filelog "###########################################################################\n\n"
    puts $filelog "\n -- STEPS START HERE AND INCLUDE THE SHOW COMMANDS USED --\n"
    regexp -nocase "STEP\+.*RESULT\+" $data steps
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
                if {[regexp {send the command\s\'(.+)\'\sto.+(exp[0-9]+)} $cmd {} command exp]} {
                    puts $filelog "command entered : $command      to -->    $exp" 
                    lappend commandList $command
                } elseif {[regexp {send the command\s\'{0,1}(.+?)\'{0,1}\sto:\s(exp[0-9]+)} $cmd {} command exp]} {
                    puts $filelog "command entered : $command      to -->    $exp" 
                    lappend commandList $command
                }
                set output 0
                if {[regexp {[\[\]\:\w]+\sexp\d+\s\{(.*?)\}.+?debug} $cmd {} output]} {
                    if {$output != 0} {
                        puts $filelog "Output : { $output }\n"
                    } 
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
    eval exit
}

proc parseDevice {link} {
    global filelog
    set url [http::geturl $link]
    set data [http::data $url]
    if {[regexp {(Software exception at.*)} $data {} excep]} {
        set line 0
        puts $filelog "\n#################### ++ Software exception ++ ####################\n"
        puts $filelog "Software exception link:\n $link \n"
        foreach l [split $excep \n] {
            if {$line <= 20} {            
                puts $filelog $l
                incr line
            }
        }
    }
    puts $filelog "\n#################### -- Software exception -- ####################\n\n"
}

proc mainProc {link} {
    global filelog
    foreach test [parseUrl $link] {
        puts $test
        regexp {([UC0-9]+).(G[0-9]+)} $test {} testID GID
        if {[file exist "C:\\HP\\logs\\$testID"] != 1} {
            set dir "C:\\HP\\logs\\$testID"
            set aa [file mkdir "C:\\HP\\logs\\$testID"]
        } else {
            set dir "C:\\HP\\logs\\$testID"
        }
        set File "$dir\\run$GID.txt"
        set file [file normalize $File]
        set filelog [open $file w]
        foreach log [splitLogsFiles $test] {
            if {[regexp "detail/.log" $log] == 1} {
                parseDetail $log
            } else {
                parseDevice $log
            }
        }
    }
    close $filelog
}

mainProc $var
