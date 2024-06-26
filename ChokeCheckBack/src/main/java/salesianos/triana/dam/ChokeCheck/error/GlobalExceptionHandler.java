package salesianos.triana.dam.ChokeCheck.error;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.ErrorResponse;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import salesianos.triana.dam.ChokeCheck.error.exception.NotAuthorException;
import salesianos.triana.dam.ChokeCheck.error.exception.NotBeltLevelException;
import salesianos.triana.dam.ChokeCheck.error.exception.NotFoundException;
import salesianos.triana.dam.ChokeCheck.error.exception.StorageException;
import salesianos.triana.dam.ChokeCheck.error.impl.ApiValidationSubError;

import java.net.URI;
import java.time.Instant;
import java.util.List;

@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {
    @Override
    public ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException exception, HttpHeaders headers, HttpStatusCode status, WebRequest request){
        List<ApiValidationSubError> validationErrors = exception.getBindingResult().getAllErrors().stream()
                .map(ApiValidationSubError::fromObjectError)
                .toList();
        ErrorResponse er = ErrorResponse.builder(exception, HttpStatus.BAD_REQUEST, exception.getMessage())
                .title("Invalid data error")
                .type(URI.create("https://api.grades-team.com/errors/not-found"))
                .property("fields_errors", validationErrors)
                .build();
        return ResponseEntity.status(status)
                .body(er);
    }
    @ExceptionHandler({NotFoundException.class})
    public ErrorResponse handleNotFoundGeneral(EntityNotFoundException exception){
        return ErrorResponse.builder(exception, HttpStatus.NOT_FOUND, exception.getMessage())
                .title("Entity not found")
                .type(URI.create("https://api.choke-check.com/errors/not-found"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler({NotAuthorException.class})
    public ErrorResponse handleNotAuthorException(NotAuthorException exception){
        return ErrorResponse.builder(exception, HttpStatus.UNAUTHORIZED, exception.getMessage())
                .title("Not author")
                .type(URI.create("https://api.choke-check.com/errors/not-author"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler({NotBeltLevelException.class})
    public ErrorResponse handleNotBeltLevelException(NotBeltLevelException exception){
        return ErrorResponse.builder(exception, HttpStatus.UNAUTHORIZED, exception.getMessage())
                .title("Not belt level")
                .type(URI.create("https://api.choke-check.com/errors/not-author"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler({StorageException.class})
    public ErrorResponse handleStorageException(StorageException exception){
        return ErrorResponse.builder(exception, HttpStatus.BAD_REQUEST, exception.getMessage())
                .title("Error with the files")
                .type(URI.create("https://api.choke-check.com/errors/not-author"))
                .property("timestamp", Instant.now())
                .build();
    }

}
