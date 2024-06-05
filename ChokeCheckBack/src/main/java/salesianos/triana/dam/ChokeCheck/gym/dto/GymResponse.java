package salesianos.triana.dam.ChokeCheck.gym.dto;

import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;

@Builder
public record GymResponse(String id, String name, String city, String avgBelt, double latitude, double altitude, int numberTournaments) {

    public static GymResponse of(Gym gym){
        return GymResponse.builder()
                .id(gym.getId().toString())
                .name(gym.getName())
                .avgBelt(gym.getAvgLevel().toString())
                .altitude(gym.getLocation().getLat())
                .latitude(gym.getLocation().getLon())
                .city(gym.getLocation().getCity())
                .numberTournaments(gym.getTournaments().size())
                .build();
    }
    public static GymResponse ofWithNoTournaments(Gym gym){
        return GymResponse.builder()
                .id(gym.getId().toString())
                .name(gym.getName())
                .avgBelt(gym.getAvgLevel().toString())
                .altitude(gym.getLocation().getLat())
                .latitude(gym.getLocation().getLon())
                .city(gym.getLocation().getCity())
                .build();
    }
}
