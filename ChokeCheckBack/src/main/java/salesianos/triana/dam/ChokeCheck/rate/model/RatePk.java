package salesianos.triana.dam.ChokeCheck.rate.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.user.model.User;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RatePk {
    private User author;
    private Post post;
}
