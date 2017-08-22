package java.lang;

public class String
{
  private char [] text;
  static char [] copyText( char [] s )
  {
    char [] a;
    int i = s.length;
    a = new char[i];
    while ( i-- != 0 ) a[i] = s[i];
    return a;
  }
  public String( char [] s )
  {
    text = String.copyText( s );
  }
  public char [] toCharArray()
  {
    return String.copyText( text );
  }
}

