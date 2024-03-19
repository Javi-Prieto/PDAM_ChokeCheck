import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageComponent } from './ui/home-page/home-page.component';
import { GymPageComponent } from './ui/gym-page/gym-page.component';
import { UsersPageComponent } from './ui/users-page/users-page.component';
import { TournamentsPageComponent } from './ui/tournaments-page/tournaments-page.component';
import { SettingsPageComponent } from './ui/settings-page/settings-page.component';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { LoggedSectionComponent } from './sections/logged-section/logged-section.component';
import { NotFoundPageComponent } from './ui/not-found-page/not-found-page.component';

const routes: Routes = [
  {path: 'login', component: LoginPageComponent},
  {
    path: '', component: LoggedSectionComponent, children:[
      {path: 'home', component: HomePageComponent},
      {path: 'gym', component: GymPageComponent},
      {path: 'users', component: UsersPageComponent},
      {path: 'tournament', component: TournamentsPageComponent},
      {path: 'settings', component: SettingsPageComponent},
      { path: '', redirectTo: '/login', pathMatch: 'full' },
    ]
  },
  { path: '**', component: NotFoundPageComponent },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
