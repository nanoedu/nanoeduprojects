javac @options mlab\Dxchg.java
javac @options mlab\dx2scan.java

jar cfe dx2scan.jar mlab.dx2scan mlab\*.class java\lang\*.class 

pause