package salesianos.triana.dam.ChokeCheck.gym.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.error.exception.NotFoundException;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymRequest;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymResponse;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;
import salesianos.triana.dam.ChokeCheck.gym.repository.GymRepository;
import salesianos.triana.dam.ChokeCheck.location.model.Location;

import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Service
@RequiredArgsConstructor
public class GymService {
    private final GymRepository repo;

    public MyPage<GymResponse> getAll(Pageable pageable){
        Page<Gym> all = repo.findAll(pageable);
        List<Gym> result = repo.findAllPaged(all.getContent().stream().map(Gym::getId).toList());
        Page<GymResponse> toReturn = all.map(GymResponse::ofWithNoTournaments);
        return MyPage.of(toReturn, result.stream().map(GymResponse::of).toList());
    }
    public GymResponse createGym(GymRequest gymRequest){
        Gym selected = GymRequest.from(gymRequest);
        Location selectedLoc = GymRequest.locationFrom(gymRequest);
        selected.addLocation(selectedLoc);
        repo.save(selected);
        return GymResponse.of(selected);
    }

    public void deleteGym(UUID gymId){
        Optional<Gym> selected = repo.findById(gymId);
        if(selected.isEmpty())throw new NotFoundException("Gym");
        repo.delete(selected.get());
    }
}
