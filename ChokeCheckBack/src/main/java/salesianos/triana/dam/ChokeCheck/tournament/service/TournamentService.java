package salesianos.triana.dam.ChokeCheck.tournament.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import salesianos.triana.dam.ChokeCheck.apply.model.Apply;
import salesianos.triana.dam.ChokeCheck.apply.model.ApplyPk;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.error.exception.NotBeltLevelException;
import salesianos.triana.dam.ChokeCheck.error.exception.NotFoundException;
import salesianos.triana.dam.ChokeCheck.rate.dto.RateDto;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.tournament.dto.TournamentDto;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.tournament.repository.TournamentRepository;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TournamentService {
    private final TournamentRepository repo;


    public MyPage<TournamentDto> getAll(User user, Pageable pageable){
        Page<Tournament> all = repo.getTournamentByWeightInAndSex(user.getWeight(), user.getSex(), pageable);
        List<Tournament> result = repo.getAllIds(all.getContent().stream().map(Tournament::getId).toList());
        Page<TournamentDto> toReturn = all.map(TournamentDto::ofWithoutApplies);
        return MyPage.of(toReturn, result.stream().map(t -> (TournamentDto.of(t, user))).toList());
    }

    public TournamentDto getById(UUID id, User user){
        Optional<Tournament> selected = repo.findByIdWithApplies(id);
        if (selected.isEmpty()) throw new NotFoundException("Tournament");
        return TournamentDto.of(selected.get(), user);
    }

    public TournamentDto addApply(UUID uuid, User user) throws NotBeltLevelException {
        Optional< Tournament> selected = repo.findByIdWithApplies(uuid);
        if(selected.isEmpty()) throw new NotFoundException("Tournament");
        if(getNumberFromBelt(user.getBelt_color())> getNumberFromBelt(selected.get().getHigherBelt())) throw new NotBeltLevelException();
        Tournament selectedTournament = selected.get();
        Apply toAdd = Apply.builder().author(user).tournament(selectedTournament).build();

        toAdd.setId(new ApplyPk(user, selectedTournament));

        selectedTournament.addApply(toAdd);

        repo.saveAndFlush(selectedTournament);
        return TournamentDto.of(selectedTournament, user);
    }
    public void deleteApply(UUID uuid, User user){
        Optional< Tournament> selected = repo.findByIdWithApplies(uuid);
        if(selected.isEmpty()) throw new NotFoundException("Tournament");
        List<Apply> allApplies = repo.findAllApplies(uuid);
        Optional<Apply> selectedApply = allApplies.stream().filter(a -> a.getAuthor().getId().equals(user.getId())).findFirst();
        if(selectedApply.isEmpty()) throw new NotFoundException("Apply");
        Tournament tournament = selected.get();
        Apply apply = selectedApply.get();
        tournament.deleteApply(apply);
        repo.save(tournament);
        repo.deleteApply(apply);
    }

    public static int getNumberFromBelt(BeltColor belt) {
        return switch (belt) {
            case WHITE -> 0;
            case BLUE -> 1;
            case PURPLE -> 2;
            case BROWN -> 3;
            case BLACK -> 4;
            case RED_BLACK -> 5;
            case RED_WHITE -> 6;
            case RED -> 7;
        };
    }
}
