# BELT RECOGNITION AI
## How to execute
To generate the file of the ai you must run.
````
python ./model_training.py
````
Now you will see a new file called
> belt_color_model.h5

So now you can run the api using
````
python ./main.py
````
And you send the request to http://127.0.0.1:9000 the only available is:
````
http://127.0.0.1:9000/validate_belt_color
````

Which needs a file on the body and nothing as headers.

## Improve the AI
To improve the AI insert the photos that you want to implement in the directory belt-images on the folder that you want.

