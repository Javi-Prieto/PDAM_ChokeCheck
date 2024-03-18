package salesianos.triana.dam.ChokeCheck.gym.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;

import java.util.UUID;

public interface GymRepository extends JpaRepository<Gym, UUID> {
}
