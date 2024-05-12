package salesianos.triana.dam.ChokeCheck.user.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import salesianos.triana.dam.ChokeCheck.validation.annotation.PasswordLength;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class EditAllUser {

    @NotEmpty
    private String name;

    @NotEmpty
    private String surname;

    @NotNull
    @Min(0)
    private int height;

    @NotNull
    @Min(30)
    private int weight;


    @NotNull(message = "El email no puede ser nulo")
    @NotEmpty(message = "El email no puede estar vacío")
    @Email(message = "{UserRegister.email.notanemail}")
    private String email;

    @NotNull(message = "La contraseña no puede ser nula")
    @NotEmpty(message = "{UserRegister.password.notempty}")
    @PasswordLength
    private String password;

    @NotNull
    @Min(16)
    private int age;

    @NotNull
    private String beltColor;

    @NotNull
    private byte sex;

    @NotNull
    private byte rol;
}
