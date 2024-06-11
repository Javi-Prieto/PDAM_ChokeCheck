package salesianos.triana.dam.ChokeCheck.assets;

import org.springframework.web.multipart.MultipartFile;


import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;


public class ImageOptimizer {
    final static private int height = 64, width = 64;


    public static BufferedImage resizeImage(BufferedImage originalImage) {
        Image resultingImage = originalImage.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage toReturn = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = toReturn.createGraphics();
        g2d.drawImage(resultingImage, 0, 0, null);
        g2d.dispose();
        return toReturn;
    }

    public static File convertToFile(MultipartFile multipartFile) throws IOException {
        File file = File.createTempFile("temp", multipartFile.getOriginalFilename());
        multipartFile.transferTo(file);
        file.deleteOnExit();
        return file;
    }

    public static byte[] optimizeAndResizeImage(MultipartFile inputImageFile) throws IOException {
        File tempFile = convertToFile(inputImageFile);
        try{

            BufferedImage originalImage = ImageIO.read(tempFile);

            BufferedImage resizedImage = resizeImage(originalImage);

            ByteArrayOutputStream toReturn = new ByteArrayOutputStream();
            ImageIO.write(resizedImage, "png", toReturn);
            return toReturn.toByteArray();
        } finally {
            if(tempFile.exists()){
                tempFile.delete();
            }
        }
    }

}
