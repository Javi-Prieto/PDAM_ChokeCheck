package salesianos.triana.dam.ChokeCheck.validation.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import salesianos.triana.dam.ChokeCheck.user.service.UserService;
import salesianos.triana.dam.ChokeCheck.validation.annotation.PasswordLength;

public class PasswordLengthValidator implements ConstraintValidator<PasswordLength, String> {

    @Autowired
    private UserService userService;

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        return StringUtils.hasText(s) && (s.length()>8);
    }
}
