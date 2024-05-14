package salesianos.triana.dam.ChokeCheck.tournament.dto;

import jakarta.validation.constraints.*;
import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.user.dto.CreateUserRequest;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;

import java.time.LocalDateTime;
import java.util.UUID;
@Builder
public record CreateTournament(
        @NotEmpty(message = "The title could not be empty")
         String title,
        @NotNull(message = "The date could not be empty")
        @FutureOrPresent(message = "The date must be bigger than today")
        LocalDateTime beginDate,
         @NotEmpty(message = "The higher belt could not be empty")
         String higherBelt,
        @NotEmpty(message = "The description could not be empty")
         String description,
        @NotNull()
                @Min(value = 2, message = "The tournament must have more than 2 participants")
         int participants,

        @Min(value = 0, message = "The prize could not be 0")
        @NotNull()
         double prize,

        @Min(value = 0, message = "The cost could not be less than 0")
        @NotNull()
         double cost,

        @Min(value = 0, message = "The min weight must be over 0")
        @NotNull()
         int minWeight,

        @Min(value = 0, message = "The max weight must be over 0")
        @NotNull()
         int maxWeight,
         @NotNull(message = "The sex could not be null")
         byte sex,
         @NotNull(message = "The author could not be null")
         UUID authorGymId
) {
    public static Tournament of(CreateTournament tournament){
        return Tournament.builder()
                .title(tournament.title)
                .beginDate(tournament.beginDate)
                .higherBelt(CreateUserRequest.getBeltColor(tournament.higherBelt()))
                .description(tournament.description())
                .participants(tournament.participants())
                .prize(tournament.prize())
                .cost(tournament.cost())
                .minWeight(tournament.minWeight())
                .maxWeight(tournament.maxWeight())
                .sex(tournament.sex())
                .build();
    }
}
