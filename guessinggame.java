import java.util.*;
public class guessinggame {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int s_Number = 55; 
        int guess;
        System.out.println("Welcome to the world of Number Guessing Game");
        System.out.println("ohk let's start the game Try to guess the special number between 1 and 100.");
        while (true) {
            System.out.print("Enter your guess: ");
            guess = sc.nextInt();
            if (guess == s_Number) {
                System.out.println("Correct You guessed the number.");
                break; 
            } else if (guess < 1 || guess > 100) {
                System.out.println(" Invalid Please enter between 1 and 100.");
                continue; 
            } else if (guess < s_Number) {
                System.out.println("Too low! Try again.");
            } else if (guess > s_Number) {
                System.out.println("Too high! Try again.");
            }
            else {
                System.out.println("ohh man you entered a wrong input");
            }
        }
        System.out.println("Game Over Thanks for playing");
        sc.close();
    }
}
