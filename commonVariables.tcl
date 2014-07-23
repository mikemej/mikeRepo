####+commonVariables+######################################################################
# Contiene las variables de los scripts a utilizar
# Michael Mejias Sanchez
# Softtek
###-commonVariables-######################################################################

namespace eval stepListTC {
   variable stepAux 0
   variable mes "tcAction::tcAction defineStep -stepDesc"
}

namespace eval clearLogs {
   variable link "http://pnb-cit-05.rose.hp.com/at/log05/mejiasmi/U3974462/G00001/Radius_F_05._Login_Screen_With_Copyright_0xbaf91a0_0/detail.log"
}

namespace eval StpLink {
   variable aux 0
   variable STPbugID 10322
   variable bugID ""
   variable ResList {15933154 15933155 15932974}
}
namespace eval moreLinks {
   variable link {http://prodlabrpt.usa.hp.com/cgi-bin/testResults?restrict=programs.programName~not%20regexp~-%27Laredo%20PSR%7CCharleston%20Bedrock%27,results3.status~not%20regexp~%27Passed%27,results3.testCategory~%3D~%27CIT%27,programs.programName~regexp~%27gecko%7CKnoxville%7CNashville%20Aggregator%7CIrvine%20Bedrock%7Cspecials_quartz%7CPeridot%20Specials%7CCommon%20Criteria%20NDPP%7CLakes%20phase%202%7Cbolt%7Cmango%7Crel_jacksonville%7Claredo%20agregator%27,results3.message~%3D~%27Step%3A9%20Configure%20DUT01%20as%20the%20master%20of%20the%20VR%20instance%27&sort=results3.bugID&resultsPP=2000&cols=triage&dateRange=2w&showTADev=1&showBuilds=1}
   variable bugID 11149
}

namespace eval fixVer {
   variable tc "CLI_Commands_DB"
   variable rep 5
   variable email { 

 ****AutotestCommand for MEMPHIS ****
autotest -t <testcaseName> -m <TestRunTag> -r <NoOfExecutions> -y  -i A_15_14_REL_MEMPHIS_100313.swi,KA_15_14_REL_MEMPHIS_082313.swi,K_15_14_REL_MEMPHIS_100313.swi,RA_15_14_REL_MEMPHIS_100313.swi,WB_15_14_REL_MEMPHIS_091913.swi,W_15_14_REL_MEMPHIS_082613.swi,YA_15_14_REL_MEMPHIS_100313.swi,YB_15_14_REL_MEMPHIS_100313.swi -h 2530ya,2530yb,2620,2910,2920,3500,3800,5400,6600,8200,lager,stack-AR,stack-TA -e <Email Address> -testware $TESTWARE


 ****AutotestCommand for NASHVILLE ****
autotest -t <testcaseName> -m <TestRunTag> -r <NoOfExecutions> -y  -i A_15_15_REL_NASHVILLE_031014.swi,KA_15_15_REL_NASHVILLE_031014.swi,K_15_15_NASHVILLE_100713.swi,RA_15_15_REL_NASHVILLE_031014.swi,WB_15_15_REL_NASHVILLE_031014.swi,YA_15_15_REL_NASHVILLE_031014.swi,YB_15_15_REL_NASHVILLE_031014.swi -h 2530ya,2530yb,2620,2920,3500,3800,5400,6600,8200,lager,stack-AR,stack-TA -e <Email Address> -testware $TESTWARE



   }
}
namespace eval linkTriage {
	variable link {http://prodlabrpt.usa.hp.com/cgi-bin/testResults?restrict=programs.programName~not%20regexp~-%27Laredo%20PSR%7CCharleston%20Bedrock%27,results3.status~not%20regexp~%27Passed%27,results3.testCategory~%3D~%27CIT%27,programs.programName~regexp~%27gecko%7CKnoxville%7CNashville%20Aggregator%7CIrvine%20Bedrock%7Cspecials_quartz%7CPeridot%20Specials%7CCommon%20Criteria%20NDPP%7CLakes%20phase%202%7Cbolt%7Cmango%7Crel_jacksonville%7Claredo%20agregator%27&sort=results3.bugID&resultsPP=2000&cols=triage&dateRange=2w&showTADev=1&showBuilds=1}
	variable run 5
}

namespace eval parseDetail {
    variable arg {http://prodlabrpt.usa.hp.com/cgi-bin/testResults?restrict=testrunid.testRunIdName~=~%27U4044107%27}
}