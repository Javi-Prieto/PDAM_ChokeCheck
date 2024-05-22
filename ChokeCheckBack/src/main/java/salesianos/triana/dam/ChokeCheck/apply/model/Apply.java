package salesianos.triana.dam.ChokeCheck.apply.model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.time.LocalDate;


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

    @CreatedDate
    @Builder.Default
    private LocalDate createdAt = LocalDate.now();

    public ApplyPk getId() {
        return new ApplyPk(author, tournament);
    }
    public void setId(ApplyPk applyPk){
        this.author = applyPk.getAuthor();
        this.tournament = applyPk.getTournament();
    }
}
