package calendario.app.android;

import android.app.Activity;
import android.os.Bundle;

import android.widget.TextView;


import java.lang.Object;
import java.util.Calendar;

import java.util.Date;

public class calendario extends Activity
{

    TextView t1;
String[] mes = {"janeiro","fevereiro","março","abril","maio","junho","julho","agosto","setembro","outubro","novembro","dezembro"};
int[] lastd={31,28,31,30,31,30,31,31,30,31,30,31,0,0};
String[] ddia ={ " ","domingo","segunda feira" ,"terça feira", "quarta feira","quinta feira","sexta feira","sabado"," "};
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

String s="";
Calendar c = Calendar.getInstance(); 
int d1=0;
int d2=0;
c.set(Calendar.DATE,1);
int mm = c.get(Calendar.MONTH);
int ddd= c.get(Calendar.DAY_OF_WEEK);
int i=0;
d1=ddd-1;
  t1 = (TextView) findViewById(R.id.t1);

setTitle(mes[mm]);
s=s.concat("dom|seg|ter|qua|qui|sex|sab|\n");
d2=lastd[mm];
for(i=0;i<d1;i++) s=s.concat("   |");
for(i=1;i<32;i++) {
s=s.concat(" ");
if (i<10) s=s.concat(" ");
if (i<d2+1)s=s.concat( String.valueOf( i ) );

s=s.concat("|");
d1++;
if (d1>6) {
d1=0;
s=s.concat("\n");
}
}

t1.setText(  s );
    }
}
