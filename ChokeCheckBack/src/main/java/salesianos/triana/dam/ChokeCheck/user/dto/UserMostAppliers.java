package salesianos.triana.dam.ChokeCheck.user.dto;

import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.util.List;
@Builder
public record UserMostAppliers(
        int totalApplies,
        List<UserBestPublisher> userBestPublisherList
) {

    public static UserMostAppliers of(List<UserBestPublisher> u, int totalApplies){
        return UserMostAppliers.builder()
                .totalApplies(totalApplies)
                .userBestPublisherList(u)
                .build();
    }
}
