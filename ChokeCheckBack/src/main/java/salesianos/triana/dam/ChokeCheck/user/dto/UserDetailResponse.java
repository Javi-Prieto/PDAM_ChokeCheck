package salesianos.triana.dam.ChokeCheck.user.dto;

import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.post.dto.PostDto;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.util.List;

@Builder
public record UserDetailResponse(String name, String surname, String username, String belt, int age, int weight,int height, byte sex,String email, List<PostDto> posts) {
    public static UserDetailResponse of(User u, List<PostDto> posts){
        return UserDetailResponse.builder()
                .name(u.getName())
                .posts(posts)
                .surname(u.getSurname())
                .username(u.getUsername())
                .belt(getGoodBelt(u.getBelt_color().toString()))
                .age(u.getAge())
                .weight(u.getWeight())
                .sex(u.getSex())
                .height(u.getHeight())
                .email(u.getEmail())
                .build();
    }
    public static String getGoodBelt(String belt){
        String [] toReturn = belt.toLowerCase().split("_");
        return toReturn.length != 1? toReturn[0].concat(" ").concat(belt.toLowerCase().split("_")[1]) : belt.toLowerCase();
    }

}
