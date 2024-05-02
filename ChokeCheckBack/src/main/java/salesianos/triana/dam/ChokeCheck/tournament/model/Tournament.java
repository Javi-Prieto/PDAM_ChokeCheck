package salesianos.triana.dam.ChokeCheck.tournament.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.UuidGenerator;
import org.springframework.data.annotation.CreatedBy;
import salesianos.triana.dam.ChokeCheck.apply.model.Apply;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
public class Tournament {
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

    private String title;
    private LocalDateTime beginDate;
    private BeltColor higherBelt;
    private String description;
    private int participants;
    private double prize;
    private double cost;
    private int minWeight;
    private int maxWeight;
    private byte sex;

    @OneToMany(fetch = FetchType.LAZY, orphanRemoval = true, cascade = CascadeType.MERGE)
    @ElementCollection(fetch = FetchType.LAZY)
    @Builder.Default
    private Set<Apply> applies = new LinkedHashSet<>();

    @CreatedBy
    @ManyToOne
    private Gym author;

    public void addApply(Apply apply){
        this.applies.add(apply);
    }
    public void deleteApply(Apply apply){
        this.applies.removeIf(a -> a.getId().getTournament().getId().equals(apply.getTournament().getId()) &&
                a.getId().getAuthor().getId().equals(apply.getAuthor().getId()));
    }

    public void addAuthor(Gym author){
        this.author = author;
        author.getTournaments().add(this);
    }
}
