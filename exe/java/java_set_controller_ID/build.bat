javac @options mlab\log.java
javac @options mlab\Simple.java
javac @options mlab\SetupDiag.java
javac @options mlab\XYZCFG_V1.java
javac @options mlab\setcontrollerid.java

jar cfe ..\..\javabin\setcontrollerid.jar mlab.setcontrollerid mlab\*.class java\lang\*.class 

pause