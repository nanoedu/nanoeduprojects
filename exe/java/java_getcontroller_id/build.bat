javac @options mlab\log.java
javac @options mlab\SetupDiag.java
javac @options mlab\XYZCFG_V1.java
javac @options mlab\getheadcontrollerid.java

jar cfe ..\..\javabin\getheadcontrollerid.jar mlab.getheadcontrollerid mlab\*.class java\lang\*.class 

pause