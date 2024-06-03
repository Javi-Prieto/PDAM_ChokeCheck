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

  getTournaments(page: number):Observable<TournamentListResponse>{
    return this.http.get<TournamentListResponse>(`${environment.apiBaseUrl}tournament/table?page=${page}`);
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
  deleteTournament(tournamentId:String):Observable<any>{
    return this.http.delete(`${environment.apiBaseUrl}tournament/${tournamentId}`);
  }
  editTournament(tournamentId:String, editTournament: CreateTournamentRequest):Observable<any>{
    console.log(editTournament);
    if(!editTournament.beginDate.includes('T')){
      editTournament.beginDate = editTournament.beginDate.replace(' ', 'T')
    }
    console.log(editTournament);
    return this.http.put(`${environment.apiBaseUrl}tournament/${tournamentId}`, 
    {
      "title": editTournament.title,
      "beginDate": editTournament.beginDate,
      "higherBelt": editTournament.higherBelt,
      "description": editTournament.description,
      "participants": editTournament.participants,
      "prize": editTournament.prize,
      "cost": editTournament.cost,
      "minWeight": editTournament.minWeight,
      "maxWeight": editTournament.maxWeight,
      "sex": editTournament.sex,
      "authorGymId": editTournament.authorGymId
  }
  );
  }
}
