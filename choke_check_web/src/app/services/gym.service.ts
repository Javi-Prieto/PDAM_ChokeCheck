import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Gym, GymListResponse } from '../models/response/gym-list-response.interface';
import { environment } from '../../environments/environment.development';
import { CreateGymRequest } from '../models/request/create-gym-request.interface';

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
  )
  }
}
