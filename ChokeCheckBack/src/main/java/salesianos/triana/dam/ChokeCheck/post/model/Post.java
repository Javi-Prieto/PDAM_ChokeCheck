package salesianos.triana.dam.ChokeCheck.post.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.UuidGenerator;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import salesianos.triana.dam.ChokeCheck.like.model.Like;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Getter
@Setter
public class Post {
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

    private PostType type;

    @CreatedBy
    @ManyToOne
    private User author;

    @OneToMany(fetch = FetchType.LAZY, orphanRemoval = true, cascade = CascadeType.MERGE)
    @ElementCollection(fetch = FetchType.LAZY)
    @Builder.Default
    private Set<Like> likes = new LinkedHashSet<>();

    @OneToMany(fetch = FetchType.LAZY, orphanRemoval = true, cascade = CascadeType.MERGE)
    @ElementCollection(fetch = FetchType.LAZY)
    @Builder.Default
    private Set<Rate> rating = new LinkedHashSet<>();

    private String title;

    @CreatedDate
    @Builder.Default
    private LocalDate createdAt = LocalDate.now();

    private String content;

    public void addRate(Rate rate){
        this.rating.add(rate);
    }
    public void deleteRate(Rate rate){
        this.rating.removeIf(l -> l.getPost().getId().equals(rate.getPost().getId()) && l.getAuthor().getId().equals(rate.getAuthor().getId()));
    }
    public void addLike(Like like){
        this.likes.add(like);
    }
    public void deleteLike(Like like){
        this.likes.removeIf(l -> l.getPost().getId().equals(like.getPost().getId()) && l.getAuthor().getId().equals(like.getAuthor().getId()));
    }
}
