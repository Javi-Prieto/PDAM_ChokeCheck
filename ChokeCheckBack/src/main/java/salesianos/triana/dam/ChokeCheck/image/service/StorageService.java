package salesianos.triana.dam.ChokeCheck.image.service;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;
import salesianos.triana.dam.ChokeCheck.image.model.Image;

import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {

    Image store(MultipartFile file);

    String store(byte[] file, String filename, String contentType) throws Exception;

    Stream<Path> loadAll();

    Image load(String filename);

    Resource loadAsResource(String filename);

    void deleteFile(String filename);

    void deleteAll();


}
