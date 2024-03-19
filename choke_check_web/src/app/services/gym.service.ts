import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GymListResponse } from '../models/response/gym-list-response.interface';
import { environment } from '../../environments/environment.development';

@Injectable({
  providedIn: 'root'
})
export class GymService {

  constructor(private http: HttpClient) { }

  getGyms():Observable<GymListResponse>{
    return this.http.get<GymListResponse>(`${environment.apiBaseUrl}gym`);
  }
}
