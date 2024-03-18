package salesianos.triana.dam.ChokeCheck.validation.annotation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import salesianos.triana.dam.ChokeCheck.validation.validator.UniqueUsernameValidator;

import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueUsernameValidator.class)
@Documented
public @interface UniqueUsername {

    String message() default "Nombre de usuario en uso";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
