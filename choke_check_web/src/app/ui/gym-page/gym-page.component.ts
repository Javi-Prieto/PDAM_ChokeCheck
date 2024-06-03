import { Component, OnInit, TemplateRef } from '@angular/core';
import { GymService } from '../../services/gym.service';
import { Gym, GymListResponse } from '../../models/response/gym-list-response.interface';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { CreateGymRequest } from '../../models/request/create-gym-request.interface';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-gym-page',
  templateUrl: './gym-page.component.html',
  styleUrl: './gym-page.component.css'
})
export class GymPageComponent implements OnInit {


  gymsInfo !: GymListResponse;
  gyms !: Gym[];
  gymName: String = '';
  gymNameErr: String = '';
  gymCityErr: String = '';
  gymCity: String = '';
  lat: number = 0;
  latErr: String = '';
  lon: number = 0;
  lonErr: String = '';
  gymAvgBelt !: String;
  isEdit = false;
  gymId: String = ''; 
  pageNumber: number = 0; 

  constructor(private gymService: GymService, private modalService: NgbModal){}

  ngOnInit(): void {
    this.refreshGyms();
    
  }

  open(content: TemplateRef<any>) {
    this.gymName = '';
    this.lon = 0;
    this.lat = 0;
    this.isEdit =false;
    this.gymAvgBelt = '';
		this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then(
			(result) => {
				console.log( `Closed with: ${result}`);
			},
			(reason) => {
				console.log(`${reason}`);
			},
		);
	}

  refreshGyms() {
    this.gymService.getGyms(this.pageNumber -1).subscribe({
      next: resp => {
        if(resp != null){
          console.log(resp);
          this.gymsInfo = resp;
          this.gyms = resp.content;
        }
        
      },error: err =>{
        console.log(err.toString());
      }
    });
  }

  toSave() {
    let toSave = new CreateGymRequest(this.gymName, this.gymCity, this.lat, this.lon, this.gymAvgBelt);
    if(this.isEdit){
      this.gymService.editGym(this.gymId, toSave).subscribe({
        next: data=> {
          window.location.href = `${environment.localHost}gym`
        }, error: err => {
          if(err.status == 400){
            let badReq = err.error;
            console.log(badReq);
            let errors = badReq.body.fields_errors;
            errors.forEach((error: { field: string; message: string; }) => {
              if(error.field == "name"){
                this.gymNameErr = error.message;
              }else if(error.field == "city"){
                this.gymCityErr = error.message;
              }else if(error.field == "lat"){
                this.latErr = error.message;
              }else if(error.field == "lon"){
                this.lonErr = error.message;
              }else if(error.field == "beltColor"){
                console.log(error.message);
              }else{
                alert("NOOOOO MI PAGE");
              }
            });
          }
        }
      });
    }else{
      this.gymService.createGym(toSave).subscribe({
        next: data=> {
          window.location.href = `${environment.localHost}gym`
        }, error: err => {
          if(err.status == 400){
            let badReq = err.error;
            console.log(badReq);
            let errors = badReq.body.fields_errors;
            errors.forEach((error: { field: string; message: string; }) => {
              if(error.field == "name"){
                this.gymNameErr = error.message;
              }else if(error.field == "city"){
                this.gymCityErr = error.message;
              }else if(error.field == "lat"){
                this.latErr = error.message;
              }else if(error.field == "lon"){
                this.lonErr = error.message;
              }else if(error.field == "beltColor"){
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

  deleteGym(gymId:String){
    this.gymService.deleteGym(gymId).subscribe({
      next: data=> {
        window.location.href = `${environment.localHost}gym`
      }, error: err => {
        console.log(err.error.message);
      }
    });
  }

  openEditModal(gym: Gym,content: TemplateRef<any>){
    this.gymName = gym.name;
    this.lon = gym.altitude;
    this.lat = gym.latitude;
    this.gymAvgBelt = gym.avgBelt;
    this.isEdit = true;
    this.gymId = gym.id;
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
