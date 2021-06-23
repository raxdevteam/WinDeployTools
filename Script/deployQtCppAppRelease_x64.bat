@ECHO OFF

:------------------------------------------------------------------------+
:                BATCH SCRIPT TO CALL QtDEPLOYER  x64                    |
:------------------------------------------------------------------------+
: Author      : Rajeevkumar Rai                                          |
: Date        : 11th Nov, 2020                                           |
: Program     : MERS_X                                                   |
: Description : Convert any Text file to Excel with customization option |
: Copyright   : GNU GPL V3 #DARE DRDO                                    |
:------------------------------------------------------------------------+
: This file will call QtDeployer to collect all dependencies & supported |
: files to run the binary as standalone application on any system        |
:------------------------------------------------------------------------+

ECHO --------------------------------------------------
ECHO [INFO] *** DEPLOYING APPLICATION IN DEBUG MODE ***
ECHO --------------------------------------------------

ECHO [INFO] Creating installer directory...
	    mkdir buildInstaller
	    cd buildInstaller
	    mkdir windows
	    cd windows
ECHO [INFO] Creating distribution kit...
	    mkdir DistributionKit_x64
ECHO [INFO] Creating temporary directory...
	    mkdir tmp
	    cd ..
	SET distKit=buildInstaller\windows\DistributionKit_x64
	    cd ..
	SET baseDir=%cd%
	SET rootDir=%cd%
ECHO [INFO] Base directory : %baseDir%
	    
	    cd ..\build\windows\desktop\x64\release
ECHO [INFO] Debug directory : %cd%

ECHO [INFO] Getting application file ...
	    SET filename=%cd%\Txt2Excel.exe
ECHO [INFO] Application file : %fileName%

ECHO [INFO] Copying application file...
	    copy /Y %fileName% %baseDir%\buildInstaller\windows\tmp
	    cd %baseDir%

	    cd ..\deploy
	
	SET qmakeExe=C:\Qt\Qt5.14.0\5.14.0\mingw73_64\bin\qmake.exe
	SET tarDir=%baseDir%\%distKit%
ECHO [INFO] Distribution kit path : %tarDir%
	    %cd%\tools\Windows\CQtDeploy\cqtdeployer -bin %fileName% -qmake %qmakeExe% -targetDir %tarDir%

	    cd ..\build\windows\desktop\x64\release