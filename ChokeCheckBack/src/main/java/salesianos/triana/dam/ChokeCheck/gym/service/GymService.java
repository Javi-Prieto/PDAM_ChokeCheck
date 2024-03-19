package salesianos.triana.dam.ChokeCheck.gym.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymResponse;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;
import salesianos.triana.dam.ChokeCheck.gym.repository.GymRepository;

import java.util.List;


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
}
