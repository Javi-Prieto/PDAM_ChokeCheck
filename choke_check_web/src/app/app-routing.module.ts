import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageComponent } from './ui/home-page/home-page.component';
import { GymPageComponent } from './ui/gym-page/gym-page.component';
import { UsersPageComponent } from './ui/users-page/users-page.component';
import { TournamentsPageComponent } from './ui/tournaments-page/tournaments-page.component';
import { SettingsPageComponent } from './ui/settings-page/settings-page.component';

const routes: Routes = [
  {path: '', component: HomePageComponent},
  {path: 'home', component: HomePageComponent},
  {path: 'gym', component: GymPageComponent},
  {path: 'users', component: UsersPageComponent},
  {path: 'tournament', component: TournamentsPageComponent},
  {path: 'settings', component: SettingsPageComponent},

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
