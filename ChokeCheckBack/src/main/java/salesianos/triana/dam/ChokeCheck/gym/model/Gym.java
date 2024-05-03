package salesianos.triana.dam.ChokeCheck.gym.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.UuidGenerator;
import salesianos.triana.dam.ChokeCheck.location.model.Location;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Gym {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_clas",
                            value = "org.hibernate.id.uuid.CurstomVersionOneStrategy"
                    )
            }
    )
    @UuidGenerator
    @Column(columnDefinition = "uuid")
    private UUID id;


    private String name;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    private Location location;
    private BeltColor avgLevel;

    @OneToMany(cascade = CascadeType.MERGE, fetch = FetchType.LAZY, orphanRemoval = true)
    @Builder.Default
    private List<Tournament> tournaments = new ArrayList<Tournament>();

    public void addLocation(Location location){
        this.location = location;
    }
    public void removeTournament(Tournament tournament){
        this.tournaments.removeIf(t -> t.getId().equals(tournament.getId()));
    }
}
