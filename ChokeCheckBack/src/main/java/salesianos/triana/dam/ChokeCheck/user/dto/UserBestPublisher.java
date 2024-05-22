package salesianos.triana.dam.ChokeCheck.user.dto;

import lombok.Builder;
import lombok.NoArgsConstructor;
import salesianos.triana.dam.ChokeCheck.user.model.User;

@Builder
public record UserBestPublisher(String name, String surname, String username, String belt, int postPublished) {

    public static UserBestPublisher of(User u, int numberOfPost){
        return UserBestPublisher.builder()
                .name(u.getName())
                .surname(u.getSurname())
                .username(u.getUsername())
                .belt(getGoodBelt(u.getBelt_color().toString()))
                .postPublished(numberOfPost)
                .build();
    }

    public static String getGoodBelt(String belt){
        String [] toReturn = belt.toLowerCase().split("_");
        return toReturn.length != 1? toReturn[0].concat(" ").concat(belt.toLowerCase().split("_")[1]) : belt.toLowerCase();
    }
}
