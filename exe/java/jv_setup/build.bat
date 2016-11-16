rem javac @options mlab\SetupDiag.java
javac @options mlab\start.java

jar cfe start.jar mlab.start mlab\*.class java\lang\*.class 

pause