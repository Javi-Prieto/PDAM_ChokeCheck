package salesianos.triana.dam.ChokeCheck.like.model;

import jakarta.persistence.*;
import lombok.*;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.user.model.User;

@Entity
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "favourite")
@IdClass(LikePk.class)
public class Like {
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "author_id")
    @Id
    private User author;

    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "post_id")
    @Id
    private Post post;

    public LikePk getId() {
        return new LikePk(author, post);
    }
    public void setId(LikePk LikePk){
        this.author = LikePk.getAuthor();
        this.post = LikePk.getPost();
    }
}
