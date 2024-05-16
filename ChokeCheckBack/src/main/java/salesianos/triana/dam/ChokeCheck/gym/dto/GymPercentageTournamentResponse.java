package salesianos.triana.dam.ChokeCheck.gym.dto;

import lombok.Builder;

@Builder
public record GymPercentageTournamentResponse
        (
                String gymName,
                int percentage
        ) {

    public static GymPercentageTournamentResponse of(String gymName, int percentage){
        return GymPercentageTournamentResponse.builder()
                .gymName(gymName)
                .percentage(percentage)
                .build();
    }

}
