package salesianos.triana.dam.ChokeCheck.tournament.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.Builder;
import salesianos.triana.dam.ChokeCheck.apply.model.Apply;
import salesianos.triana.dam.ChokeCheck.tournament.jsonView.TournamentViews;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.time.LocalDateTime;
import java.util.UUID;

@Builder
public record TournamentDto(
        @JsonView({TournamentViews.TournamentList.class})
        UUID id,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        String title,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})

        @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss") LocalDateTime date,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        double cost,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        int participants,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        int applied,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        String higherBelt,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        double prize,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        String author,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        int minWeight,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})

        boolean isAppliedByLoggedUser,
        @JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentDetail.class})
        int maxWeight,
        @JsonView({TournamentViews.TournamentDetail.class})

        String content,
        @JsonView({TournamentViews.TournamentDetail.class})
        double lat,
        @JsonView({TournamentViews.TournamentDetail.class})
        double lon,
        @JsonView({ TournamentViews.TournamentDetail.class})
        String city) {

    public static TournamentDto of(Tournament tournament, User user){
        return TournamentDto.builder()
                .id(tournament.getId())
                .title(tournament.getTitle())
                .city(tournament.getAuthor().getLocation().getCity())
                .lon(tournament.getAuthor().getLocation().getLon())
                .content(tournament.getDescription())
                .lat(tournament.getAuthor().getLocation().getLat())
                .cost(tournament.getCost())
                .date(tournament.getBeginDate())
                .participants(tournament.getParticipants())
                .isAppliedByLoggedUser(tournament.getApplies().stream().map(Apply::getAuthor).map(User::getId).toList().contains(user.getId()))
                .applied(tournament.getApplies().size())
                .higherBelt(tournament.getHigherBelt().toString())
                .prize(tournament.getPrize())
                .minWeight(tournament.getMinWeight())
                .maxWeight(tournament.getMaxWeight())
                .author(tournament.getAuthor().getName())
                .build();
    }
    public static TournamentDto ofWithoutApplies(Tournament tournament){
        return TournamentDto.builder()
                .title(tournament.getTitle())
                .cost(tournament.getCost())
                .date(tournament.getBeginDate())
                .participants(tournament.getParticipants())
                .higherBelt(tournament.getHigherBelt().toString())
                .prize(tournament.getPrize())
                .minWeight(tournament.getMinWeight())
                .maxWeight(tournament.getMaxWeight())
                .author(tournament.getAuthor().getName())
                .build();
    }
}
