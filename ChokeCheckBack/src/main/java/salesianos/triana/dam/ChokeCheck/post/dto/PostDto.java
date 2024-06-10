package salesianos.triana.dam.ChokeCheck.post.dto;

import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.image.model.Image;
import salesianos.triana.dam.ChokeCheck.like.model.Like;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.util.Arrays;
import java.util.Set;

@Builder
public record PostDto(String id, String type, String authorName, String authorBelt, int likes,boolean isLikedByLoggedUser, Double avgRate, String title, String content, boolean isRatedByLoggedUser, byte[] image) {
    public static PostDto of(Post post, User user){
        byte [] empty= new byte[0];
        return PostDto.builder()
                .id(post.getId().toString())
                .type(post.getType().toString())
                .authorName(post.getAuthor().getUsername())
                .isRatedByLoggedUser(post.getRating().stream()
                        .map(Rate::getAuthor)
                        .map(User::getId).toList().contains(user.getId()))
                .isLikedByLoggedUser(
                        post.getLikes().stream()
                                .map(Like::getAuthor)
                                .map(User::getId).toList().contains(user.getId())
                )
                .likes(post.getLikes().size())
                .avgRate(getAvgRate(post.getRating()))
                .title(post.getTitle())
                .authorBelt(post.getAuthor().getBelt_color().toString())
                .image(empty)
                .content(post.getContent())
                .build();
    }

    public static PostDto ofWithImage(Post post, User user, Image image){
        return PostDto.builder()
                .id(post.getId().toString())
                .type(post.getType().toString())
                .authorName(post.getAuthor().getUsername())
                .isRatedByLoggedUser(post.getRating().stream()
                        .map(Rate::getAuthor)
                        .map(User::getId).toList().contains(user.getId()))
                .isLikedByLoggedUser(
                        post.getLikes().stream()
                                .map(Like::getAuthor)
                                .map(User::getId).toList().contains(user.getId())
                )
                .likes(post.getLikes().size())
                .avgRate(getAvgRate(post.getRating()))
                .title(post.getTitle())
                .authorBelt(post.getAuthor().getBelt_color().toString())
                .image(image.getData())
                .content(post.getContent())
                .build();
    }
    public static PostDto ofWithNoRating(Post post){
        return PostDto.builder()
                .id(post.getId().toString())
                .type(post.getType().toString())
                .authorName(post.getAuthor().getUsername())
                .title(post.getTitle())
                .authorBelt(post.getAuthor().getBelt_color().toString())
                .content(post.getContent())
                .build();
    }

    private static double getAvgRate(Set<Rate> rates){
        return String.valueOf(rates.stream().mapToDouble(Rate::getRate).sum() / rates.size()).equals("NaN") ? 0: rates.stream().mapToDouble(Rate::getRate).sum() / rates.size();
    }

}
