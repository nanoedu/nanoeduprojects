package mlab;

public class Stopwatch {
  private long startTime = -1;
  private long stopTime = -1;
  private boolean running = false;

  public Stopwatch start() {
    startTime = System.currentTimeMillis();
    running = true;
    return this;
  }

  public Stopwatch stop() {
    stopTime = System.currentTimeMillis();
    running = false;
    return this;
  }

  public long getElapsedTime() {
    if (startTime == -1) {
      return 0;
    }
    if (running) {
      return System.currentTimeMillis() - startTime;
    }
    else {
      return stopTime - startTime;
    }
  }

  public Stopwatch reset() {
    startTime = -1;
    stopTime = -1;
    running = false;
    return this;
  }
/*
  public static void main(String[] args)
  {
    Stopwatch s = new Stopwatch();
    s.start();
    // your code runs here
    s.stop();
    System.err.println("elapsed time: " + s.getElapsedTime());
  }
*/
}