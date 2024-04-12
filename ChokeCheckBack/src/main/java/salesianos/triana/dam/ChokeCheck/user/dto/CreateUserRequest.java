package salesianos.triana.dam.ChokeCheck.user.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;
import salesianos.triana.dam.ChokeCheck.user.model.User;
import salesianos.triana.dam.ChokeCheck.validation.annotation.PasswordLength;
import salesianos.triana.dam.ChokeCheck.validation.annotation.UniqueEmail;
import salesianos.triana.dam.ChokeCheck.validation.annotation.UniqueUsername;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateUserRequest {
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
    @Email(message = "{CreateUserRequest.email.notanemail}")
    @UniqueEmail
    private String email;

    @NotNull(message = "La contraseña no puede ser nula")
    @NotEmpty(message = "{CreateUserRequest.password.notempty}")
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

    public static CreateUserRequest fromUser(User user) {

        return CreateUserRequest.builder()
                .username(user.getUsername())
                .email(user.getEmail())
                .password(user.getPassword())
                .build();
    }
    public static User fromCreateUserRequest(CreateUserRequest CreateUserRequest){
        return User.builder()
                .name(CreateUserRequest.getName())
                .surname(CreateUserRequest.getSurname())
                .password(CreateUserRequest.getPassword())
                .age(CreateUserRequest.getAge())
                .belt_color(getBeltColor(CreateUserRequest.getBeltColor()))
                .weight(CreateUserRequest.getWeight())
                .height(CreateUserRequest.getHeight())
                .email(CreateUserRequest.getEmail())
                .username(CreateUserRequest.getUsername())
                .sex(CreateUserRequest.getSex())
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
