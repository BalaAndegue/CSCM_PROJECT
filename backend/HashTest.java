import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class HashTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String raw = "Admin@123";
        String encoded = "$2a$12$LQv3c1yqBWVHxkd0LHAkCOyz7Tg4T7g4.Uu3nCZWnF3/1mE5v1Ea2";
        System.out.println("Matches? " + encoder.matches(raw, encoded));
        System.out.println("New Hash: " + encoder.encode(raw));
    }
}
