package salesianos.triana.dam.ChokeCheck.post.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.post.model.PostType;

import java.util.Set;


@Builder
public record CreatePostDto(@NotEmpty(message = "It has to have a type") String type, @NotEmpty(message = "The title may not be empty") String title,@NotEmpty(message = "The content may not be empty") String content) {
    public static Post from(CreatePostDto postDto){
        return Post.builder()
                .type(PostType.valueOf(postDto.type))
                .title(postDto.title)
                .content(postDto.content())
                .rating(Set.of())
                .build();
    }
}
