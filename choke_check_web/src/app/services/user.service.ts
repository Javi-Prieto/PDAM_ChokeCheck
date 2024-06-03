import { Injectable } from '@angular/core';
import { User, UserListResponse } from '../models/response/user-list-response.interface';
import { environment } from '../../environments/environment.development';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CreateUserRequest } from '../models/request/create-user-request.interface';
import { EditUserRequest } from '../models/request/edit-user-request.interface';
import { UserBestAppliers } from '../models/response/user-best-appliers.interface';
import { UserBestPoster } from '../models/response/user-best-poster.interface';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  getUsers(page: number):Observable<UserListResponse>{
    return this.http.get<UserListResponse>(`${environment.apiBaseUrl}user/?page=${page}`);
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

  editUser(id:String, edit:EditUserRequest):Observable<any>{
    return this.http.put<any>(`${environment.apiBaseUrl}user/edit/${id}`, {
      "password" : edit.password,
      "name" : edit.name,
      "surname" : edit.surname,
      "height" : edit.height,
      "weight" : edit.weight,
      "email" : edit.email,
      "age" : edit.age,
      "beltColor" : edit.beltColor,
      "rol": edit.rol
    });
  }

  deleteUser(id: String):Observable<any>{
    return this.http.delete<any>(`${environment.apiBaseUrl}user/${id}`);
  }

  get5bestAppliers():Observable<UserBestAppliers>{
    return this.http.get<UserBestAppliers>(`${environment.apiBaseUrl}user/best_appliers`);
  }

  getBestPoster():Observable<UserBestPoster[]>{
    return this.http.get<UserBestPoster[]>(`${environment.apiBaseUrl}user/best_publisher`);
  }
}

