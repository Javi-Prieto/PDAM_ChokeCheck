package salesianos.triana.dam.ChokeCheck.rate.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.rate.model.RatePk;
import salesianos.triana.dam.ChokeCheck.user.model.User;

@Builder
public record RateDto(@Min(value = 0) @Max(value = 5) double rate) {
    public static Rate from(RateDto newRate, User user, Post post){
        Rate rate = Rate.builder()
                .author(user)
                .post(post)
                .rate(newRate.rate())
                .build();
        rate.setId(new RatePk(user, post));
        return rate;
    }
}
