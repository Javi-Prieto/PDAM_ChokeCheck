package salesianos.triana.dam.ChokeCheck.image.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import salesianos.triana.dam.ChokeCheck.image.model.Image;

public interface ImageRepository extends JpaRepository<Image, String> {
}
