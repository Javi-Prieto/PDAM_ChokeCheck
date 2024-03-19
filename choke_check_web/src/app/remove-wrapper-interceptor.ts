import { Injectable } from '@angular/core';
import {
    HttpInterceptor,
    HttpRequest,
    HttpHandler,
    HttpEvent,
} from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class RemoveWrapperInterceptor implements HttpInterceptor {
    intercept(
        request: HttpRequest<any>,
        next: HttpHandler
    ): Observable<HttpEvent<any>> {
        if (request.body && request.body.issue) {
            request = request.clone({
                body: request.body.issue,
            });
        }

        return next.handle(request);
    }
}