import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Tournament, TournamentListResponse } from '../models/response/tournament-list-response.interface';
import { Observable } from 'rxjs';
import { CreateTournamentRequest } from '../models/request/create-tournament-request.interface';

@Injectable({
  providedIn: 'root'
})
export class TournamentService {

  constructor(private http:HttpClient) { }

  getTournaments():Observable<TournamentListResponse>{
    return this.http.get<TournamentListResponse>(`${environment.apiBaseUrl}tournament/table`);
  }

  createTournament(newTournament: CreateTournamentRequest):Observable<Tournament>{
    return this.http.post<Tournament>(`${environment.apiBaseUrl}tournament`,
    {
      "title": newTournament.title,
      "beginDate": newTournament.beginDate,
      "higherBelt": newTournament.higherBelt,
      "description": newTournament.description,
      "participants": newTournament.participants,
      "prize": newTournament.prize,
      "cost": newTournament.cost,
      "minWeight": newTournament.minWeight,
      "maxWeight": newTournament.maxWeight,
      "sex": newTournament.sex,
      "authorGymId": newTournament.authorGymId
  }
    )
  }
}
