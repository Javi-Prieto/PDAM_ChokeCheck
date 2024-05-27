from keras.src.applications.vgg16 import VGG16
from keras.src.utils import to_categorical
from tensorflow.keras import Model
from tensorflow.keras.layers import Dense, Flatten
from tensorflow.keras.optimizers import Adam

from data_preprocessing import load_belt_images

image_dir = './belt-images'
belt_images, belt_labels, belt_classes = load_belt_images(image_dir)
belt_labels = to_categorical(belt_labels, len(belt_classes))

base_model = VGG16(weights='imagenet', include_top=False, input_shape=(64, 64, 3))

x = base_model.output
x = Flatten()(x)
x = Dense(128, activation='relu')(x)
predictions = Dense(len(belt_classes), activation='softmax')(x)

model = Model(inputs=base_model.input, outputs=predictions)

for layer in base_model.layers:
    layer.trainable = False

model.compile(optimizer=Adam(), loss='categorical_crossentropy', metrics=['accuracy'])

model.fit(belt_images, belt_labels, epochs=10, validation_split=0.2)

model.save('belt_color_model.h5')

