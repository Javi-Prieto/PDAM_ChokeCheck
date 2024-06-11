package salesianos.triana.dam.ChokeCheck.image.service;

import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import salesianos.triana.dam.ChokeCheck.assets.ImageOptimizer;
import salesianos.triana.dam.ChokeCheck.error.exception.StorageException;
import salesianos.triana.dam.ChokeCheck.image.model.Image;
import salesianos.triana.dam.ChokeCheck.image.repository.ImageRepository;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.time.chrono.ChronoLocalDateTime;
import java.util.Optional;
import java.util.stream.Stream;


@Service
@RequiredArgsConstructor
public class ImageServiceImpl implements StorageService{
    private final ImageRepository repository;

    @Override
    public Image store(MultipartFile file) {
        Optional<Image> toStoreOp = repository.findById(file.getName());
        Image toStore = new Image();
        if(toStoreOp.isEmpty()){
            try{
                toStore = Image.builder()
                        .fileType(file.getContentType())
                        .size(file.getSize())
                        .data(ImageOptimizer.optimizeAndResizeImage(file))
                        .fileName(file.getOriginalFilename())
                        .build();
                try{
                    repository.save(toStore);
                }catch(Exception ex){
                    throw new StorageException("Failed the upload of the file");
                }
            }catch (Exception ex){
                ex.printStackTrace();
            }
        }else{
            toStore = toStoreOp.get();
        }
        return toStore;
    }

    @Override
    public String store(byte[] file, String filename, String contentType) throws Exception {
        return null;
    }

    @Override
    public Stream<Path> loadAll() {
        return null;
    }

    @Override
    public Image load(String filename) {

        return repository.findById(filename).orElseThrow();
    }

    @Override
    public Resource loadAsResource(String filename) {
        return null;
    }

    @Override
    public void deleteFile(String filename) {
        repository.deleteById(filename);
    }

    @Override
    public void deleteAll() {

    }


}
