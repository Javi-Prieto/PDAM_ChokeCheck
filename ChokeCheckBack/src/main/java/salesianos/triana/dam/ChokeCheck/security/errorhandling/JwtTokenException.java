package salesianos.triana.dam.ChokeCheck.security.errorhandling;

public class JwtTokenException extends RuntimeException{

    public JwtTokenException(String msg){
        super(msg);
    }
}
