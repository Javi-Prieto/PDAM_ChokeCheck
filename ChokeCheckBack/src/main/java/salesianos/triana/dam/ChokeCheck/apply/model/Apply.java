package salesianos.triana.dam.ChokeCheck.apply.model;

import jakarta.persistence.*;
import lombok.*;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.user.model.User;


@Entity
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@IdClass(ApplyPk.class)
public class Apply {

    @ManyToOne(cascade = CascadeType.MERGE)
    @Id
    private User author;

    @ManyToOne(cascade = CascadeType.MERGE)
    @Id
    private Tournament tournament;

    public ApplyPk getId() {
        return new ApplyPk(author, tournament);
    }
    public void setId(ApplyPk applyPk){
        this.author = applyPk.getAuthor();
        this.tournament = applyPk.getTournament();
    }
}
