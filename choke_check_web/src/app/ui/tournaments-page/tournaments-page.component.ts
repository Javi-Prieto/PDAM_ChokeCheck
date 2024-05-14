import { Component, TemplateRef } from '@angular/core';
import { TournamentService } from '../../services/tournament.service';
import { Tournament, TournamentListResponse } from '../../models/response/tournament-list-response.interface';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { GymService } from '../../services/gym.service';
import { Gym } from '../../models/response/gym-list-response.interface';
import { CreateTournamentRequest } from '../../models/request/create-tournament-request.interface';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-tournaments-page',
  templateUrl: './tournaments-page.component.html',
  styleUrl: './tournaments-page.component.css'
})
export class TournamentsPageComponent {

  tournamentsInfo !: TournamentListResponse;
  tournaments !: Tournament[];
  gyms !: Gym[];
  tournamentTitle: String = '';
  tournamentTitleErr: String = '';
  tournDesc: String = '';
  tournDescErr: String = '';
  tournDate: String = '';
  tournDateErr: String = '';
  cost: Number = 0;
  participants: Number = 0;
  participantsErr: String = '';
  costErr: String = '';
  prize: Number = 0;;
  prizeErr: String = '';
  minWeight: Number = 0;;
  minWeightErr: String = '';
  maxWeight: Number = 0;;
  maxWeightErr: String = '';
  tournHigherBelt: String = '';
  tournSex: Number = 0;
  creatorGymId: String = '';
  tournamentId: String = '';
  isEdit:boolean= false;

  constructor(private tournamentService: TournamentService, private gymService: GymService, private modalService: NgbModal){}

  ngOnInit(): void {
    this.tournamentService.getTournaments().subscribe({
      next: resp => {
        this.tournamentsInfo = resp;
        this.tournaments = resp.content;
      },error: err =>{
        console.log(err.toString());
      }
    });
    this.gymService.getGyms().subscribe({
      next: resp => {
        if(resp != null){
          this.gyms = resp.content;
        }
        
      },error: err =>{
        console.log(err.toString());
      }
    });
  }
  refreshTournaments() {
    throw new Error('Method not implemented.');
  }

  open(content: TemplateRef<any>) {
    this.tournamentTitle = "";
    this.tournDesc = "";
    this.tournDate = "";
    this.cost = 0;
    this.participants = 0;
    this.prize = 0;
    this.minWeight = 0;
    this.maxWeight = 0;
    this.tournHigherBelt = "";
    this.isEdit = false;
		this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
			(result) => {
				console.log( `Closed with: ${result}`);
			},
			(reason) => {
				console.log(`${reason}`);
			},
		);
	}

  toSave() {
    let toSave = new CreateTournamentRequest(this.tournamentTitle, this.tournDate, this.tournHigherBelt, this.tournDesc, this.participants, this.prize, this.cost, this.minWeight, this.maxWeight, this.tournSex, this.creatorGymId);
    console.log(this.tournDate);
    console.log(toSave);
    if(this.isEdit){
      this.tournamentService.editTournament(this.tournamentId, toSave).subscribe({
        next: data=> {
          window.location.href = `${environment.localHost}tournament`
        }, error: err => {
          console.log(err);
          if(err.status == 400){
            let badReq = err.error;
            console.log(badReq);
            let errors = badReq.body.fields_errors;
            errors.forEach((error: { field: string; message: string; }) => {
              if(error.field == "title"){
                this.tournamentTitleErr = error.message;
              }else if(error.field == "description"){
                this.tournDescErr = error.message;
              }else if(error.field == "prize"){
                this.prizeErr = error.message;
              }else if(error.field == "cost"){
                this.costErr = error.message;
              }else if(error.field == "minWeight"){
                this.minWeightErr = error.message;
              }else if(error.field == "maxWeight"){
                this.maxWeightErr = error.message;
              }else if(error.field == "participants"){
                this.participantsErr = error.message;
              }else if(error.field == "higherBelt"){
                console.log(error.message);
              }else if(error.field == "beginDate"){
                this.tournDateErr = error.message;
              }else{
                console.log(error.message);
                alert("NOOOOO MI PAGE");
              }
            });
          }
        }
      });
    }else{
      this.tournamentService.createTournament(toSave).subscribe({
        next: data=> {
          window.location.href = `${environment.localHost}tournament`
        }, error: err => {
          if(err.status == 400){
            let badReq = err.error;
            console.log(badReq);
            let errors = badReq.body.fields_errors;
            errors.forEach((error: { field: string; message: string; }) => {
              if(error.field == "title"){
                this.tournamentTitleErr = error.message;
              }else if(error.field == "description"){
                this.tournDescErr = error.message;
              }else if(error.field == "prize"){
                this.prizeErr = error.message;
              }else if(error.field == "cost"){
                this.costErr = error.message;
              }else if(error.field == "minWeight"){
                this.minWeightErr = error.message;
              }else if(error.field == "maxWeight"){
                this.maxWeightErr = error.message;
              }else if(error.field == "participants"){
                this.participantsErr = error.message;
              }else if(error.field == "higherBelt"){
                console.log(error.message);
              }else{
                alert("NOOOOO MI PAGE");
              }
            });
          }
        }
      });
    }
    
  }
  
  deleteTournament(tournamentId: String){
    this.tournamentService.deleteTournament(tournamentId).subscribe({
      next: data=> {
        window.location.href = `${environment.localHost}tournament`
      }, error: err => {
        console.log(err.error.message);
        
      }
    });
  }

  openEditModal(tournament: Tournament,content: TemplateRef<any>){
    this.tournamentTitle = tournament.title;
    this.tournDate = tournament.date.toString();
    this.cost = tournament.cost;
    this.participants = tournament.participants;
    this.prize = tournament.prize;
    this.minWeight = tournament.minWeight;
    this.maxWeight = tournament.maxWeight;
    this.tournHigherBelt = tournament.higherBelt;
    this.tournamentId = tournament.id;
    this.isEdit = true;
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
			(result) => {
				console.log( `Closed with: ${result}`);
			},
			(reason) => {
				console.log(`${reason}`);
			},
		);
  }
}
