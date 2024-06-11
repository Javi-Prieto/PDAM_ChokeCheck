package salesianos.triana.dam.ChokeCheck.image.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
public class Image {
    @Id
    private String fileName;

    private String fileType;

    private long size;

    @Lob
    private byte[] data;
}
