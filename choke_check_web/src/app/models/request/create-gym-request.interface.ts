export class CreateGymRequest{
    name: String;
    city: String;
    lat: number;
    lon: number;
    beltColor: String;

    constructor(name: String, city: String, lat:number, lon:number, beltColor:String){
        this.name = name;
        this.city = city;
        this.lat = lat;
        this.lon = lon;
        this.beltColor = beltColor;
    }
}
