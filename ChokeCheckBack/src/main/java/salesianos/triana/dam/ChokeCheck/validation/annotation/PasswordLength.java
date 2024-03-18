package salesianos.triana.dam.ChokeCheck.validation.annotation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import salesianos.triana.dam.ChokeCheck.validation.validator.PasswordLengthValidator;

import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = PasswordLengthValidator.class)
@Documented
public @interface PasswordLength {

    String message() default "La contraseña es demasiado corta";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
