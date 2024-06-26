package salesianos.triana.dam.ChokeCheck.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
@SuperBuilder
public class UserResponse {

    protected String id;
    protected String username;
    protected String userBeltColor;
    protected String rol;

    public static UserResponse fromUser(User user) {

        return UserResponse.builder()
                .id(user.getId().toString())
                .username(user.getUsername())
                .userBeltColor(user.getBelt_color().name())
                .rol((user.getRoles().stream().findFirst().isPresent()) ? user.getRoles().stream().findFirst().get().toString() : "USER" )
                .build();
    }
}
