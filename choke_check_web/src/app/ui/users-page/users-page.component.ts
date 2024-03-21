import { Component } from '@angular/core';
import { UserService } from '../../services/user.service';
import { User, UserListResponse } from '../../models/response/user-list-response.interface';

@Component({
  selector: 'app-users-page',
  templateUrl: './users-page.component.html',
  styleUrl: './users-page.component.css'
})
export class UsersPageComponent {
  usersInfo !: UserListResponse;
  users !: User[];

  constructor(private userService: UserService){}

  ngOnInit(): void {
    this.userService.getUsers().subscribe({
      next: resp => {
        this.usersInfo = resp;
        this.users = resp.content;
      },error: err =>{
        console.log(err.toString());
      }
    });
  }
  getSex(sex:number){
    return sex ==0 ? 'Male' : 'Female';
  }
  refreshUsers() {
    throw new Error('Method not implemented.');
  }
}
