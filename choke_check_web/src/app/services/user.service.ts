import { Injectable } from '@angular/core';
import { User, UserListResponse } from '../models/response/user-list-response.interface';
import { environment } from '../../environments/environment.development';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CreateUserRequest } from '../models/request/create-user-request.interface';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  getUsers():Observable<UserListResponse>{
    return this.http.get<UserListResponse>(`${environment.apiBaseUrl}user/`);
  }

  createUser(created: CreateUserRequest):Observable<User>{
    return this.http.post<User>(`${environment.apiBaseUrl}register/admin`, {
      "username" : created.username,
      "password" : created.password,
      "name" : created.name,
      "surname" : created.surname,
      "height" : created.height,
      "weight" : created.weight,
      "email" : created.email,
      "age" : created.age,
      "beltColor" : created.beltColor,
      "sex": created.sex,
      "rol": created.rol
  });
  }

  deleteUser(id: String):Observable<any>{
    return this.http.delete<any>(`${environment.apiBaseUrl}user/${id}`);
  }
}

