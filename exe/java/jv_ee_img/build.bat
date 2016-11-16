javac @options mlab\log.java
javac @options mlab\SetupDiag.java
javac @options mlab\XYZCFG_V1.java
javac @options mlab\start.java

jar cfe start.jar mlab.start mlab\*.class java\lang\*.class 

pause