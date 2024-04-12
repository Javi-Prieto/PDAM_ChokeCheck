import { Component, TemplateRef } from '@angular/core';
import { UserService } from '../../services/user.service';
import { User, UserListResponse } from '../../models/response/user-list-response.interface';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { CreateUserRequest } from '../../models/request/create-user-request.interface';
import { environment } from '../../../environments/environment.development';

@Component({
  selector: 'app-users-page',
  templateUrl: './users-page.component.html',
  styleUrl: './users-page.component.css'
})
export class UsersPageComponent {
  usersInfo !: UserListResponse;
  users !: User[];
  userName: String = '';
  userNameErr: String = '';
  name: String = '';
  nameErr: String = '';
  surName: String = '';
  surNameErr: String = '';
  password: String = '';
  passwordErr: String = '';
  email: String = '';
  emailErr: String = '';
  height: Number = 0;
  heightErr: String = '';
  weight: Number = 0;
  weightErr: String = '';
  userBelt: String = '';
  userSex: Number = 0;
  age: Number = 0;
  ageErr: String = '';
  userRol: Number = 0;





  constructor(private userService: UserService, private modalService: NgbModal){}

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
  toSave(){
    let toSave = new CreateUserRequest(this.userName, this.password, this.name, this.surName, this.height, this.weight, this.email, this.age, this.userBelt, this.userRol, this.userSex);
    this.userService.createUser(toSave).subscribe({
      next: data => {
        window.location.href = `${environment.localHost}users`
      },error: err => {
        if(err.status == 400){
          let badReq = err.error;
          console.log(badReq);
          let errors = badReq.body.fields_errors;
          errors.forEach((error: { field: string; message: string; }) => {
            if(error.field == "name"){
              this.nameErr = error.message;
            }else if(error.field == "password"){
              this.passwordErr = error.message;
            }else if(error.field == "username"){
              this.userNameErr = error.message;
            }else if(error.field == "surname"){
              this.surNameErr = error.message;
            }else if(error.field == "beltColor"){
              console.log(error.message);
            }else if(error.field == "height"){
              this.heightErr = error.message;
            }else if(error.field == "weight"){
              this.weightErr = error.message;
            }else if(error.field == "email"){
              this.emailErr = error.message;
            }else if(error.field == "age"){
              this.ageErr = error.message;
            }else if(error.field == "rol"){
              console.log(error.message);
            }else if(error.field == "sex"){
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
