package salesianos.triana.dam.ChokeCheck.gym.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;

import java.util.List;
import java.util.UUID;

public interface GymRepository extends JpaRepository<Gym, UUID> {

    @Query(
            """
                    Select g from Gym g
                    left join fetch g.tournaments
                    where g.id in :ids
                    order by g.id
            """
    )
    List<Gym> findAllPaged(List<UUID> ids);
}
