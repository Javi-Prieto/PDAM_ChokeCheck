import { Component, OnInit } from '@angular/core';
import { ChartConfiguration, ChartData } from 'chart.js';
import { Gym, GymPercentageTournamentResponse } from '../../models/response/gym-percentage-tournaments-response.interface';
import { GymService } from '../../services/gym.service';

@Component({
  selector: 'app-gym-poster-radial-chart',
  templateUrl: './gym-poster-radial-chart.component.html',
  styleUrl: './gym-poster-radial-chart.component.css'
})
export class GymPosterRadialChartComponent implements OnInit{
  public dounutChartType = 'doughnut' as const;
  donutChartData!: ChartData<'doughnut'>;
  gymPercentageTournamentResponse !: GymPercentageTournamentResponse;
  labels: String[] = [];
  data: number[] = [];

  constructor (private gymService: GymService){}

  ngOnInit(): void {
      this.gymService.getGymsPercentageTournament().subscribe({
        next: resp => {
          if(resp != null){
            this.gymPercentageTournamentResponse = resp;
            this.data = resp.gyms.map(g => g.numberOfTournaments);
            this.labels = resp.gyms.map(g => g.gymName);
            this.donutChartData = {
              labels: this.labels,
              datasets: [
                { data: this.data,},
              ],
            };
          }
        },error: err =>{
          console.log(err.toString());
        }
      });
  }
}
