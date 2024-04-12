package salesianos.triana.dam.ChokeCheck.validation.annotation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import salesianos.triana.dam.ChokeCheck.validation.validator.UniqueEmailValidator;

import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueEmailValidator.class)
@Documented
public @interface UniqueEmail {

    String message() default "Almost registered email";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
