import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
class hello 
{ 
	public static void main(String[] args) 
	{ 
		System.out.println("\033c\033[43;30m\n\n"); 
                LocalDate date = LocalDate.now();
                LocalTime time = LocalTime.now();
                LocalDateTime dateTime = LocalDateTime.now();

                System.out.println("Current Date: " + date);
                System.out.println("Current Time: " + time);
                System.out.println("Current DateTime: " + dateTime);
	} 
} 