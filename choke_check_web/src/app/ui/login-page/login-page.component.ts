import { Component } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { TokenStorageService } from '../../services/token-storage.service';
import { environment } from '../../../environments/environment.development';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrl: './login-page.component.css'
})
export class LoginPageComponent {
  username!: any;
  password!: any;
  errorMessage: string = ""

  constructor(private authService: AuthService, private tokenService: TokenStorageService) { }

  login() {
    this.authService.login(this.username, this.password).subscribe({
      next: data => {
        this.tokenService.saveToken(data.token);
        sessionStorage.setItem('rol', data.rol);
        window.location.href = `${environment.localHost}home`
      },
      error: err => {
        this.errorMessage = "Las credenciales son inválidas";
      }
    });
  }
}
