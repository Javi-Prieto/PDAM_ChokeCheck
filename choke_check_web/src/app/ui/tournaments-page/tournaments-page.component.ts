import { Component } from '@angular/core';
import { TournamentService } from '../../services/tournament.service';
import { Tournament, TournamentListResponse } from '../../models/response/tournament-list-response.interface';

@Component({
  selector: 'app-tournaments-page',
  templateUrl: './tournaments-page.component.html',
  styleUrl: './tournaments-page.component.css'
})
export class TournamentsPageComponent {
  tournamentsInfo !: TournamentListResponse;
  tournaments !: Tournament[];

  constructor(private tournamentService: TournamentService){}

  ngOnInit(): void {
    this.tournamentService.getTournaments().subscribe({
      next: resp => {
        this.tournamentsInfo = resp;
        this.tournaments = resp.content;
      },error: err =>{
        console.log(err.toString());
      }
    });
  }
  refreshTournaments() {
    throw new Error('Method not implemented.');
  }
}
