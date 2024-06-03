import { Component, TemplateRef } from '@angular/core';
import { UserService } from '../../services/user.service';
import { User, UserListResponse } from '../../models/response/user-list-response.interface';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { CreateUserRequest } from '../../models/request/create-user-request.interface';
import { environment } from '../../../environments/environment.development';
import { EditUserRequest } from '../../models/request/edit-user-request.interface';

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
  repeatPassword: String = '';
  repeatPasswordErr:String = '';
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
  userId: String = '';
  isEditting = false;
  pageNumber: number = 0;




  constructor(private userService: UserService, private modalService: NgbModal){}

  ngOnInit(): void {
    this.refreshUsers();
  }
  getSex(sex:number){
    return sex ==0 ? 'Male' : 'Female';
  }
  refreshUsers() {
    this.userService.getUsers(this.pageNumber -1).subscribe({
      next: resp => {
        this.usersInfo = resp;
        this.users = resp.content;
      },error: err =>{
        console.log(err.toString());
      }
    });
  }
  open(content: TemplateRef<any>) {
    this.userName = '';
    this.name = '';
    this.surName = '';
    this.email = '';
    this.height = 0;
    this.weight = 0;
    this.age = 0;
    this.userId = '';
    this.isEditting = false;
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
    if(this.userId == ''){
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
    }else{
      let toEdit = new EditUserRequest(this.password, this.name, this.surName, this.height, this.weight, this.email, this.age, this.userBelt, this.userRol, this.userSex);
      this.userService.editUser(this.userId, toEdit).subscribe({
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

  deleteUser(id:String){
    this.userService.deleteUser(id).subscribe({
      next: data=> {
        window.location.href = `${environment.localHost}users`
      }, error: err => {
        console.log(err.error.message);
      }
    });
  }

  openEditModal(user: User,content: TemplateRef<any>){
    this.userName = user.username;
    this.name = user.name;
    this.surName = user.surname;
    this.email = user.email;
    this.height = user.height;
    this.weight = user.weight;
    this.age = user.age;
    this.userId = user.id;
    this.isEditting = true;
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
