import {Injectable} from '@angular/core';
import {BehaviorSubject} from 'rxjs';
import {vale} from '../models/models';
import {HttpClient, HttpErrorResponse} from '@angular/common/http';

@Injectable()
export class DataService {
  private readonly API_URL = 'https://api.github.com/repos/angular/angular/issues';

  dataChange: BehaviorSubject<vale[]> = new BehaviorSubject<vale[]>([]);
  // Temporarily stores data from dialogs
  dialogData: any;

  constructor (private httpClient: HttpClient) {}

  get vales(): vale[] {
    return this.dataChange.value;
  }

  getDialogData() {
    return this.dialogData;
  }

  // Métodos
  getAllVales(): void {
    this.httpClient.get<vale[]>(this.API_URL).subscribe(vales => {
        this.dataChange.next(vales);
      },
      (error: HttpErrorResponse) => {
        console.log (error.name + ' ' + error.message);
      });
  }

  addVale (vales: vale): void {
    this.dialogData = vales;
  }

  updateVale (vales: vale): void {
    this.dialogData = vales;
  }

  deleteVale (id_vale: number): void {
    console.log(id_vale);
  }
}
