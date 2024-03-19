import { NgModule } from '@angular/core';
import { BrowserModule, provideClientHydration } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomePageComponent } from './ui/home-page/home-page.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { GymPageComponent } from './ui/gym-page/gym-page.component';
import { UsersPageComponent } from './ui/users-page/users-page.component';
import { TournamentsPageComponent } from './ui/tournaments-page/tournaments-page.component';
import { SettingsPageComponent } from './ui/settings-page/settings-page.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { FormsModule } from '@angular/forms';
import { LoggedSectionComponent } from './sections/logged-section/logged-section.component';
import { NotFoundPageComponent } from './ui/not-found-page/not-found-page.component';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent,
    HomePageComponent,
    NavBarComponent,
    GymPageComponent,
    UsersPageComponent,
    TournamentsPageComponent,
    SettingsPageComponent,
    LoginPageComponent,
    LoggedSectionComponent,
    NotFoundPageComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgbModule
  ],
  providers: [
    provideClientHydration()
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
