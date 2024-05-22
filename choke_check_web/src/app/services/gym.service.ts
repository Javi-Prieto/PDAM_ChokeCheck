import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Gym, GymListResponse } from '../models/response/gym-list-response.interface';
import { environment } from '../../environments/environment.development';
import { CreateGymRequest } from '../models/request/create-gym-request.interface';
import { GymPercentageTournamentResponse } from '../models/response/gym-percentage-tournaments-response.interface';

@Injectable({
  providedIn: 'root'
})
export class GymService {

  constructor(private http: HttpClient) { }

  getGyms():Observable<GymListResponse>{
    return this.http.get<GymListResponse>(`${environment.apiBaseUrl}gym`);
  }
  createGym(newGym: CreateGymRequest):Observable<Gym>{
    return this.http.post<Gym>(`${environment.apiBaseUrl}gym`, 
    {
      "name": newGym.name,
      "city": newGym.city,
      "lat" : newGym.lat,
      "lon": newGym.lon,
      "beltColor" : newGym.beltColor
  }
  );
  }

  deleteGym(gymId:String):Observable<any>{
    return this.http.delete(`${environment.apiBaseUrl}gym/${gymId}`);
  }

  editGym(gymId:String, newGym: CreateGymRequest):Observable<any>{
    return this.http.put(`${environment.apiBaseUrl}gym/${gymId}`, 
      {
        "name": newGym.name,
        "city": newGym.city,
        "lat" : newGym.lat,
        "lon": newGym.lon,
        "beltColor" : newGym.beltColor
    }
  );
  }

  getGymsPercentageTournament():Observable<GymPercentageTournamentResponse>{
    return this.http.get<GymPercentageTournamentResponse>(`${environment.apiBaseUrl}gym/percentage`);
  }
}
