import { Injectable } from '@angular/core';
import { UserListResponse } from '../models/response/user-list-response.interface';
import { environment } from '../../environments/environment.development';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  getUsers():Observable<UserListResponse>{
    return this.http.get<UserListResponse>(`${environment.apiBaseUrl}user/`);
  }
}

