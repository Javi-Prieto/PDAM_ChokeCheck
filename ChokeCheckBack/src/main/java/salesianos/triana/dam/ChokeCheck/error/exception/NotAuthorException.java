package salesianos.triana.dam.ChokeCheck.error.exception;

public class NotAuthorException extends Exception{
    public NotAuthorException(){
        super("You can not do this beacause you are not the author");
    }
}
