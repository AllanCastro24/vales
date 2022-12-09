import {Injectable} from '@angular/core';
import {BehaviorSubject} from 'rxjs';
import {vale} from '../models/models';
import {HttpClient, HttpErrorResponse} from '@angular/common/http';

@Injectable()
export class DataService {
  private readonly API_URL = 'http://localhost:5000/';

  dataChange: BehaviorSubject<any[]> = new BehaviorSubject<any[]>([]);
  // Temporarily stores data from dialogs
  dialogData: any;

  constructor (private httpClient: HttpClient) {}

  get vales(): any[] {
    return this.dataChange.value;
  }

  getDialogData() {
    return this.dialogData;
  }

  // Métodos
  getAllVales(): void {
    this.httpClient.get<any[]>(this.API_URL + "api/getVales").subscribe(vales => {
        if (vales != null){
          this.dataChange.next(vales);
        }
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
