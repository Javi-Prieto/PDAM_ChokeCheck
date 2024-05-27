import numpy as np
from PIL import Image
import os


def load_belt_images(image_dir, target_size=(64, 64)):
    images = []
    labels = []
    classes = os.listdir(image_dir)
    for label, class_name in enumerate(classes):
        class_dir = os.path.join(image_dir, class_name)
        for file_name in os.listdir(class_dir):
            image_path = os.path.join(class_dir, file_name)
            try:
                image = Image.open(image_path).convert('RGB')
                image = image.resize(target_size)
                image = np.array(image) / 255
                images.append(image)
                labels.append(label)
            except Exception as e:
                print(f'Error loading image {image_path}: {e}')
    return np.array(images), np.array(labels), classes
