import { Component, OnInit } from '@angular/core';
import { UserService } from '../../services/user.service';
import { ChartConfiguration, ChartData, ChartEvent } from 'chart.js';
import { BaseChartDirective } from 'ng2-charts';
import { UserBestAppliers } from '../../models/response/user-best-appliers.interface';

@Component({
  selector: 'app-best-appliers-chart',
  templateUrl: './best-appliers-chart.component.html',
  styleUrl: './best-appliers-chart.component.css'
})
export class BestAppliersChartComponent implements OnInit{
  info!:UserBestAppliers;
  allUserApplies: number[] = [];
  labels: string[] = [];
  public barChartType = 'bar' as const;
  public barChartOptions: ChartConfiguration<'bar'>['options'] = {
    scales: {
      x: {},
      y: {
        min: 0,
      },
    },
    plugins: {
      legend: {
        display: true,
      },
    },
  };
  public barChartData!: ChartData<'bar'>;

  constructor(private userService: UserService){}

  ngOnInit():void{
    this.userService.get5bestAppliers().subscribe({
      next: resp => {
        if(resp != null){
          this.info = resp;
          this.allUserApplies = resp.userBestPublisherList.map(u => u.postPublished);
          this.labels = resp.userBestPublisherList.map(u => u.username);
          this.barChartData = {
            labels: this.labels,
            datasets: [
              { data: this.allUserApplies,},
            ],
          };
          console.log(this.allUserApplies);
          console.log(this.info);
        }
      },error: err =>{
        console.log(err.toString());
      }
    });
    
  }
}
