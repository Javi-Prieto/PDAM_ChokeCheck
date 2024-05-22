import { Component, OnInit } from '@angular/core';
import { UserBestPoster } from '../../models/response/user-best-poster.interface';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-user-poster-list',
  templateUrl: './user-poster-list.component.html',
  styleUrl: './user-poster-list.component.css'
})
export class UserPosterListComponent implements OnInit{
  users: UserBestPoster[] = [];

  constructor(private userService: UserService){}

  ngOnInit(): void {
    this.userService.getBestPoster().subscribe({
      next: resp => {
        if(resp != null){
          this.users = resp;
        }
      },error: err =>{
        console.log(err.toString());
      }
    });      
  }

  fromBeltToInt(beltColor:String){
    console.log(beltColor);
    if (beltColor == "red") return 100;
      if (beltColor == "blue") return 17;
      if (beltColor == "black") return 68;
      if (beltColor == "red_white") 85;
      if (beltColor == "red_black") 93;
      if (beltColor == "white") return 0;
      if (beltColor == "purple") return 34;
      if (beltColor == "brown") return 51;
      return 0;
  }
  frombBeltToColor(beltColor:String):string{
    if (beltColor == "red") return 'danger';
      if (beltColor == "blue") return 'primary';
      if (beltColor == "black") return 'dark';
      if (beltColor == "red_white") 'danger';
      if (beltColor == "red_black") 'danger';
      if (beltColor == "white") return 'light';
      if (beltColor == "purple") return 'primary';
      if (beltColor == "brown") return 'dark';
      return 'light';
  }
}
