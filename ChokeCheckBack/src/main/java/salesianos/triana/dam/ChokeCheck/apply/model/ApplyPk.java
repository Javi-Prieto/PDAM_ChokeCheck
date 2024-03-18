package salesianos.triana.dam.ChokeCheck.apply.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.user.model.User;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ApplyPk {
    private User author;
    private Tournament tournament;

}
