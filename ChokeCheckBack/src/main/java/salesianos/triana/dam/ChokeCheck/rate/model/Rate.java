package salesianos.triana.dam.ChokeCheck.rate.model;

import jakarta.persistence.*;
import lombok.*;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.user.model.User;


@Entity
@Getter
@Builder
@Setter
@NoArgsConstructor
@AllArgsConstructor
@IdClass(RatePk.class)
public class Rate {

    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "author_id")
    @Id
    private User author;

    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "post_id")
    @Id
    private Post post;

    private double rate;

    public RatePk getId() {
        return new RatePk(author, post);
    }
    public void setId(RatePk RatePk){
        this.author = RatePk.getAuthor();
        this.post = RatePk.getPost();
    }
}
