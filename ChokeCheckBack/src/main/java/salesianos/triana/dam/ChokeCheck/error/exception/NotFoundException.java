package salesianos.triana.dam.ChokeCheck.error.exception;

import jakarta.persistence.EntityNotFoundException;

public class NotFoundException extends EntityNotFoundException {
    public NotFoundException(String Entidad){
        super("The "+ Entidad +" or the list could not be found");
    }
}
