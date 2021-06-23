@ECHO OFF

:------------------------------------------------------------------------+
:                BATCH SCRIPT TO CALL QtDEPLOYER  x86                    |
:------------------------------------------------------------------------+
: Author      : Rajeevkumar Rai                                          |
: Contact     : pro.rajeevrai@gmail.com                                  |
: Date        : 11th Nov, 2020                                           |
: Program     : MERS_X                                                   |
: Description : Multi emitter radar simulator genearte path data and     |
:		calculate DF data A.o.A, Azimuth, Elevation & Range      |
: Copyright   : GNU GPL V3 #DARE DRDO                                    |
:------------------------------------------------------------------------+
: This file will call QtDeployer to collect all dependencies & supported |
: files to run the binary as standalone application on any system        |
:------------------------------------------------------------------------+

ECHO -------------------------------------
ECHO [INFO] DEPLOYING APPLICATION IN DEBUG MODE
ECHO -------------------------------------

ECHO [INFO] Creating installer directory...
	    mkdir buildInstaller
	    cd buildInstaller
ECHO [INFO] Creating distribution kit...
   	    mkdir DistributionKit_x86
ECHO [INFO] Creating temporary directory...
	    mkdir tmp
	    cd ..
	SET distKit=buildInstaller\DistributionKit_x86

ECHO [INFO] Collecting depencies...

	SET baseDir=%cd%
	SET rootDir=%cd%
ECHO [INFO] Base directory : %baseDir%

	    cd ..\build\desktop\x86_32\debug
ECHO [INFO] Debug directory : %cd%

ECHO [INFO] Getting application file name...
	    for %%a in (*.exe) do (
     		SET fileName=%%~nxa
		)
ECHO [INFO] Application file name : %fileName%

:removing .exe extension
	SET appname=%fileName:~0,-4% 
ECHO [INFO] Application name : %appname%
	    for /F "usebackq tokens=1,2,3 delims=-" %%I IN ('%date%') do SET relDate=%%K-%%J-%%I
ECHO [INFO] Release date : %relDate%

ECHO [INFO] Copying application file...
	    copy /Y %fileName% %baseDir%\buildInstaller\tmp
	    cd %baseDir%
	    cd ..\resource
 
ECHO [INFO] Resource directory : %cd%
ECHO [INFO] Copying all qml files...
	    robocopy %cd%/qml %rootDir%\buildInstaller\tmp\qml /s /e

	SET appName=%baseDir%\buildInstaller\tmp\%fileName%
	SET qmakeExe=C:/Qt/Qt5.14.0/5.14.0/mingw73_32/bin/qmake.exe
	SET qmlPath=%baseDir%\buildInstaller\tmp\qml

ECHO [INFO] Application : %appName%
ECHO [INFO] Qmake : qmakeExe:%qmakeExe%
ECHO [INFO] Qml dir: %qmlPath%

	    cd %baseDir%
ECHO [INFO] Resource directory : %cd%

	    cd ..\deploy

	SET tarDir=%baseDir%\%distKit%
ECHO [INFO] Distribution kit path : %tarDir%
	    %cd%\tools\CQtDeploy\cqtdeployer -bin %appName% -qmlDir %qmlPath% -qmake %qmakeExe% -targetDir %tarDir%

	    cd ..\build\desktop\x86_32\debug