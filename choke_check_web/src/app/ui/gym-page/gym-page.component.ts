import { Component, OnInit } from '@angular/core';
import { GymService } from '../../services/gym.service';
import { Gym, GymListResponse } from '../../models/response/gym-list-response.interface';

@Component({
  selector: 'app-gym-page',
  templateUrl: './gym-page.component.html',
  styleUrl: './gym-page.component.css'
})
export class GymPageComponent implements OnInit {

  gymsInfo !: GymListResponse;
  gyms !: Gym[];

  constructor(private gymService: GymService){}

  ngOnInit(): void {
    this.gymService.getGyms().subscribe({
      next: resp => {
        this.gymsInfo = resp;
        this.gyms = resp.content;
      },error: err =>{
        console.log(err.toString());
      }
    });
  }
  refreshGyms() {
    throw new Error('Method not implemented.');
  }

}
