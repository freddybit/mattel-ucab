import { Injectable } from '@angular/core';

export interface UserInfo {
  name: string;
  email: string;
  role: string;
}

@Injectable({ providedIn: 'root' })
export class UserService {
  private user: UserInfo = {
    name: 'Andrea Rivas',
    email: 'andrea.rivas@mattelucab.com',
    role: 'Administrator',
  };

  getUser(): UserInfo {
    return this.user;
  }
}
