import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class TokenStorageService {

  constructor() { }

  public saveToken(token: string): void {
    if (typeof localStorage !== 'undefined'){
      localStorage.removeItem('TOKEN');
      localStorage.setItem('TOKEN', token);
    }
  }

  public getToken(): string | null {
    if (typeof localStorage !== 'undefined') {
      return localStorage.getItem('TOKEN');
    }
    return null;
  }
}
