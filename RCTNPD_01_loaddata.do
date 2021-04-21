/*==============================================================================
purpose:      load in the data from csv files
date created: 19/12/2018
author:       maximiliane verfuerden
*==============================================================================*/
clear
cd          "$projectdir"
capture     log close
log          using "${logdir}\01-cl_loaddata $S_DATE.log", replace 
*** "all data" ***
import      delimited "${datadir}\GtOrmondStOutputs2\GtOrmondStAllData.csv, clear
by          pupilreference, sort: gen unique = _n==1
save 		    "${datadir}\alldata.dta", replace
clear
*** "all data subj" ***
import 		  delimited "${datadir}\GtOrmondStOutputs2\GtOrmondStAllDataSubj.csv, clear
by          pupilreference, sort: gen unique = _n==1
save 		    "${datadir}\1-data\alldatasubj.dta", replace
clear
*** "link table" ***
import 		  delimited "${datadir}\GtOrmondStOutputs2\GtOrmondStLinkTable.csv, clear 
by          pupilreference, sort: gen unique_pref = _n==1
by        	studyid1, sort: gen unique_studyid1 = _n==1
save 		    "${datadir}\linktable.dta", replace
clear
*** "score lookup" ***
import 		  "${datadir}\GtOrmondStOutputs2\GtOrmondStScoreLookup.csv, clear
//			    this seems to be just a reference table - better opened in excel as the fields contain long descriptions
save 		    "${datadir}\1-data\scorelookup.dta", replace
clear
*** "specification" ***
import      delimited "${datadir}\GtOrmondStOutputs2\GtOrmondStSpecification.csv, varnames(1) clear 
//		  	  this seems to be just a reference table - also better opened in excel as the fields contain long descriptions
*==============================================================================*/
save 	  	"${datadir}\1-data\specification.dta", replace
clear
cap log 	 close
