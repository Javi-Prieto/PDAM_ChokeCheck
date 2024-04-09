package salesianos.triana.dam.ChokeCheck.gym.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;
import salesianos.triana.dam.ChokeCheck.location.model.Location;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;

@Builder
public record GymRequest(
        @NotEmpty()
        @NotBlank()
        @NotNull()
        String name,
        @NotEmpty()
        @NotBlank()
        @NotNull()
        String city,
        @NotEmpty()
        double lat,
        @NotEmpty()
        double lon,
        @NotEmpty()
        BeltColor beltColor
) {
    public static Gym from(GymRequest gymRequest){
        return Gym.builder()
                .avgLevel(gymRequest.beltColor)
                .name(gymRequest.name())
                .build();
    }
    public static Location locationFrom(GymRequest gymRequest){
        return Location.builder()
                .city(gymRequest.city())
                .lon(gymRequest.lon())
                .lat(gymRequest.lat())
                .build();
    }
}
