package salesianos.triana.dam.ChokeCheck.gym.dto;

import lombok.Builder;

import java.util.List;

@Builder
public record GymPercentageResponse (int totalTournaments, List<GymPercentageTournamentResponse> gyms) {

    public static GymPercentageResponse of(int totalTournaments, List<GymPercentageTournamentResponse> gyms){
        return GymPercentageResponse.builder()
                .totalTournaments(totalTournaments)
                .gyms(gyms)
                .build();
    }
}
