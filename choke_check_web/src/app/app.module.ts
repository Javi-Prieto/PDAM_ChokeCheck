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
import { HTTP_INTERCEPTORS, HttpClientModule, provideHttpClient, withFetch } from '@angular/common/http';
import { LoggerInterceptor } from './logger.interceptor';
import { RemoveWrapperInterceptor } from './remove-wrapper-interceptor';
import { BestAppliersChartComponent } from './components/best-appliers-chart/best-appliers-chart.component';
import { BaseChartDirective, provideCharts, withDefaultRegisterables } from 'ng2-charts';
import { GymPosterRadialChartComponent } from './components/gym-poster-radial-chart/gym-poster-radial-chart.component';
import { UserPosterListComponent } from './components/user-poster-list/user-poster-list.component';

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
    NotFoundPageComponent,
    BestAppliersChartComponent,
    GymPosterRadialChartComponent,
    UserPosterListComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    BaseChartDirective,
    NgbModule,
  ],
  providers: [
    provideClientHydration(),
    { provide: HTTP_INTERCEPTORS, useClass: LoggerInterceptor, multi: true }, provideHttpClient(withFetch()), {
      provide: HTTP_INTERCEPTORS,
      useClass: RemoveWrapperInterceptor,
      multi: true
    },
    provideCharts(withDefaultRegisterables())
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
