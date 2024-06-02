import numpy as np
import uvicorn
from keras.api.saving import load_model
from fastapi import FastAPI, UploadFile, File
from PIL import Image

app = FastAPI()

model = load_model('./belt_color_model.h5')

classes = ['white', 'blue', 'purple', 'brown', 'red and white', 'red and black', 'red', 'black']


def preprocess_image(image: Image.Image) -> np.array:
    image = image.resize((64, 64))
    image = np.array(image)
    image = np.expand_dims(image, axis=0)
    return image


@app.post('/validate_belt_color')
def validate_belt_color(file: UploadFile = File()):
    image = Image.open(file.file).convert('RGB')
    processed_image = preprocess_image(image)
    result = model.predict(processed_image)
    print(result)
    result_belt_color = classes[np.argmax(result)]
    return {"belt_color": result_belt_color}


if __name__ == '__main__':
    uvicorn.run(app='main:app', reload=True, port=9000)
