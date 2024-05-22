package salesianos.triana.dam.ChokeCheck.gym.dto;

import lombok.Builder;

@Builder
public record GymPercentageTournamentResponse
        (
                String gymName,
                int numberOfTournaments
        ) {

    public static GymPercentageTournamentResponse of(String gymName, int numberOfTournaments){
        return GymPercentageTournamentResponse.builder()
                .gymName(gymName)
                .numberOfTournaments(numberOfTournaments)
                .build();
    }

}
