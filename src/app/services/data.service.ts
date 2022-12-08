import {Injectable} from '@angular/core';
import {BehaviorSubject} from 'rxjs';
import {Issue, vale} from '../models/models';
import {HttpClient, HttpErrorResponse} from '@angular/common/http';

@Injectable()
export class DataService {
  private readonly API_URL = 'https://api.github.com/repos/angular/angular/issues';

  dataChange: BehaviorSubject<Issue[]> = new BehaviorSubject<Issue[]>([]);
  _dataChange: BehaviorSubject<vale[]> = new BehaviorSubject<vale[]>([]);
  // Temporarily stores data from dialogs
  dialogData: any;

  constructor (private httpClient: HttpClient) {}

  get data(): Issue[] {
    return this.dataChange.value;
  }
  get vales(): vale[] {
    return this._dataChange.value;
  }

  getDialogData() {
    return this.dialogData;
  }

  // Métodos
  getAllVales(): void {
    this.httpClient.get<vale[]>(this.API_URL).subscribe(vales => {
        this._dataChange.next(vales);
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
  /** CRUD METHODS */
  getAllIssues(): void {
    this.httpClient.get<Issue[]>(this.API_URL).subscribe(data => {
        this.dataChange.next(data);
      },
      (error: HttpErrorResponse) => {
      console.log (error.name + ' ' + error.message);
      });
  }

  // DEMO ONLY, you can find working methods below
  addIssue (issue: Issue): void {
    this.dialogData = issue;
  }

  updateIssue (issue: Issue): void {
    this.dialogData = issue;
  }

  deleteIssue (id: number): void {
    console.log(id);
  }
}
