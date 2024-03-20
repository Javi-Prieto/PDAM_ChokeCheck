import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { TournamentListResponse } from '../models/response/tournament-list-response.interface';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TournamentService {

  constructor(private http:HttpClient) { }

  getTournaments():Observable<TournamentListResponse>{
    return this.http.get<TournamentListResponse>(`${environment.apiBaseUrl}tournament/table`);
  }
}
