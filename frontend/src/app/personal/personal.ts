import { Component, HostListener } from '@angular/core';

@Component({
  selector: 'app-personal',
  standalone: true,
  imports: [],
  templateUrl: './personal.html',
  styleUrls: ['./personal.css'],
})
export class Personal {
  showCreateModal = false;
  passwordVisible = false;

  openModal() {
    this.showCreateModal = true;
  }

  closeModal() {
    this.showCreateModal = false;
  }

  togglePassword() {
    this.passwordVisible = !this.passwordVisible;
  }

  @HostListener('document:keydown', ['$event'])
  onKeydown(event: KeyboardEvent) {
    if (event.key === 'Escape' && this.showCreateModal) {
      this.closeModal();
    }
  }
}
