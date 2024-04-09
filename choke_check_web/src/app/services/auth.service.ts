import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';

const httpOptions = {
  headers: new HttpHeaders({ 'Content-Type' : 'application/json'})
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) { }

  login(username: any, password: any): Observable<any> {
    localStorage.removeItem('TOKEN');
    return this.http.post(`${environment.apiBaseUrl}login`,
      {
        "username": username,
        "password": password
      }, httpOptions);
  }
}
