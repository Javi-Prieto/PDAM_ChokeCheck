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

  constructor(private gymService: GymService, private modalService: NgbModal){}

  ngOnInit(): void {
    this.gymService.getGyms().subscribe({
      next: resp => {
        if(resp != null){
          this.gymsInfo = resp;
          this.gyms = resp.content;
        }
        
      },error: err =>{
        console.log(err.toString());
      }
    });
  }

  open(content: TemplateRef<any>) {
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
    throw new Error('Method not implemented.');
  }

  toSave() {
    let toSave = new CreateGymRequest(this.gymName, this.gymCity, this.lat, this.lon, this.gymAvgBelt);
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
