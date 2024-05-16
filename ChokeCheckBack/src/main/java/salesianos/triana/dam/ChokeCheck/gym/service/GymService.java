package salesianos.triana.dam.ChokeCheck.gym.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.error.exception.NotFoundException;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymPercentageTournamentResponse;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymRequest;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymResponse;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;
import salesianos.triana.dam.ChokeCheck.gym.repository.GymRepository;
import salesianos.triana.dam.ChokeCheck.location.model.Location;
import salesianos.triana.dam.ChokeCheck.tournament.repository.TournamentRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Service
@RequiredArgsConstructor
public class GymService {
    private final GymRepository repo;
    private final TournamentRepository tournamentRepository;
    public MyPage<GymResponse> getAll(Pageable pageable){
        Page<Gym> all = repo.findAll(pageable);
        List<Gym> result = repo.findAllPaged(all.getContent().stream().map(Gym::getId).toList());
        Page<GymResponse> toReturn = all.map(GymResponse::ofWithNoTournaments);
        return MyPage.of(toReturn, result.stream().map(GymResponse::of).toList());
    }

    public List<GymPercentageTournamentResponse> getPercentageGym(){
        List<GymPercentageTournamentResponse> result = new ArrayList<>();
        int allTournament = tournamentRepository.getAllByCreatedAtMonth(LocalDate.now().getMonthValue()).size();
        repo.findAll().forEach(gym -> {
            int numberOfTournaments = gym.getTournaments().stream().filter(t -> t.getCreatedAt().getMonthValue() == LocalDate.now().getMonthValue()).toList().size();

            int percentage = Math.round( ((float) numberOfTournaments / allTournament) * 100);
            System.out.println(percentage);
            result.add(GymPercentageTournamentResponse.of(gym.getName(), percentage));
        });
        return result;
    }
    public GymResponse createGym(GymRequest gymRequest){
        Gym selected = GymRequest.from(gymRequest);
        Location selectedLoc = GymRequest.locationFrom(gymRequest);
        selected.addLocation(selectedLoc);
        repo.save(selected);
        return GymResponse.of(selected);
    }

    public GymResponse editGym(GymRequest newGym, UUID id){
        Optional<Gym> selected = repo.findById(id);
        if(selected.isEmpty())throw new NotFoundException("Gym");
        Gym toEdit = selected.get();
        Location newLocation = GymRequest.locationFrom(newGym);
        toEdit.setName(newGym.name());
        toEdit.setLocation(newLocation);
        toEdit.setAvgLevel(newGym.beltColor());
        return GymResponse.of(repo.save(toEdit));
    }

    public void deleteGym(UUID gymId){
        Optional<Gym> selected = repo.findById(gymId);
        if(selected.isEmpty())throw new NotFoundException("Gym");
        repo.delete(selected.get());
    }
}
