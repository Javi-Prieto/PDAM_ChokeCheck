package salesianos.triana.dam.ChokeCheck.gym.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import salesianos.triana.dam.ChokeCheck.gym.repository.GymRepository;

@Service
@RequiredArgsConstructor
public class GymService {
    private final GymRepository repo;
}
