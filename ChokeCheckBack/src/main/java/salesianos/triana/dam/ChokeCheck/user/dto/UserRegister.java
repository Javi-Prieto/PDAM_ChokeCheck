package salesianos.triana.dam.ChokeCheck.user.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;
import salesianos.triana.dam.ChokeCheck.user.model.User;
import salesianos.triana.dam.ChokeCheck.validation.annotation.FieldsValueMatch;
import salesianos.triana.dam.ChokeCheck.validation.annotation.PasswordLength;
import salesianos.triana.dam.ChokeCheck.validation.annotation.UniqueEmail;
import salesianos.triana.dam.ChokeCheck.validation.annotation.UniqueUsername;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@FieldsValueMatch(
        field = "password", fieldMatch = "repeatPassword",
        message = "{UserRegister.password.nomatch}"
)
public class UserRegister {

    @NotNull(message = "El nombre de usuario no puede ser nulo")
    @NotEmpty(message = "El nombre de usuario no puede estar vacío")
    @UniqueUsername
    protected String username;

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
    @UniqueEmail
    private String email;

    @NotNull(message = "La contraseña no puede ser nula")
    @NotEmpty(message = "{UserRegister.password.notempty}")
    @PasswordLength
    private String password;

    @NotEmpty(message = "La contraseña no puede ser nula")
    private String repeatPassword;

    @NotNull
    @Min(16)
    private int age;

    @NotNull
    private String beltColor;

    @NotNull
    private byte sex;
    public static UserRegister fromUser(User user) {

        return UserRegister.builder()
                .username(user.getUsername())
                .email(user.getEmail())
                .password(user.getPassword())
                .repeatPassword(user.getPassword())
                .build();
    }
    public static User fromUserRegister(UserRegister userRegister){
        return User.builder()
                .name(userRegister.getName())
                .surname(userRegister.getSurname())
                .password(userRegister.getPassword())
                .age(userRegister.getAge())
                .belt_color(getBeltColor(userRegister.getBeltColor()))
                .weight(userRegister.getWeight())
                .height(userRegister.getHeight())
                .email(userRegister.getEmail())
                .username(userRegister.getUsername())
                .sex(userRegister.getSex())
                .build();
    }
    public static BeltColor getBeltColor(String beltColor){
        if (beltColor.equals("RED")) return BeltColor.RED;
        if (beltColor.equals("BLUE")) return BeltColor.BLUE;
        if (beltColor.equals("BLACK")) return BeltColor.BLACK;
        if (beltColor.equals("RED_WHITE")) return BeltColor.RED_WHITE;
        if (beltColor.equals("RED_BLACK")) return BeltColor.RED_BLACK;
        if (beltColor.equals("WHITE")) return BeltColor.WHITE;
        if (beltColor.equals("PURPLE")) return BeltColor.PURPLE;
        if (beltColor.equals("BROWN")) return BeltColor.BROWN;
        return BeltColor.WHITE;
    }
}
