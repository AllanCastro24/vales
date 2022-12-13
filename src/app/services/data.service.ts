import {Injectable} from '@angular/core';
import {BehaviorSubject} from 'rxjs';
import {vale} from '../models/models';
import {HttpClient, HttpErrorResponse} from '@angular/common/http';

@Injectable()
export class DataService {
  private readonly API_URL = 'http://localhost:5000/';

  dataChange: BehaviorSubject<any[]> = new BehaviorSubject<any[]>([]);
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

  getDistribuidores():any{
    this.httpClient.get<any[]>(this.API_URL + "api/getDistribuidores").subscribe(distribuidores => {
      if (distribuidores != null){
        //this.dataChange.next(distribuidores);
      }
    },
    (error: HttpErrorResponse) => {
      console.log (error.name + ' ' + error.message);
    });
  }

  addVale (vales: any): void {
    this.dialogData = vales;
  }

  updateVale (vales: any): void {
    this.dialogData = vales;
  }

  deleteVale (id_vale: any): void {
  }
}
