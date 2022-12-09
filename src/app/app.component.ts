import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {DataService} from './services/data.service';
import {HttpClient} from '@angular/common/http';
import {MatDialog} from '@angular/material/dialog';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {vale} from './models/models';
import {DataSource} from '@angular/cdk/collections';
import {AddDialogComponent} from './dialogs/add/add.dialog.component';
import {EditDialogComponent} from './dialogs/edit/edit.dialog.component';
import {DeleteDialogComponent} from './dialogs/delete/delete.dialog.component';
import {BehaviorSubject, fromEvent, merge, Observable} from 'rxjs';
import {map} from 'rxjs/operators';
import { ValesComponent } from './dialogs/vales/vales.component';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

export class AppComponent implements OnInit {
  displayedColumns = ['id', 'tipo', 'nombre', 'monto', 'fecha_limite', 'cantidad', 'acciones'];
  exampleDatabase: DataService | null;
  dataSource: ExampleDataSource | null;
  index: number;
  id: number;

  constructor(public httpClient: HttpClient,
              public dialog: MatDialog,
              public dataService: DataService) {}

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;
  @ViewChild('filter',  {static: true}) filter: ElementRef;

  ngOnInit() {
    this.getVales();
  }

  refresh() {
    this.getVales();
  }

  addVale() {
    const dialogRef = this.dialog.open(AddDialogComponent, {
      data: {vales: vale }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === 1) {
        // Despues de cerrar, recagar
        // For add we're just pushing a new row inside DataService
        this.exampleDatabase.dataChange.value.push(this.dataService.getDialogData());
        this.refreshTable();
      }
    });
  }

  editVale(i: number, id_vale: number, tipo_vale: string, nombre_distribuidor: string, monto_vale: number, fecha_limite: Date, cantidad: number) {
    this.id = id_vale;
    // index row is used just for debugging proposes and can be removed
    this.index = i;
    console.log(this.index);
    const dialogRef = this.dialog.open(EditDialogComponent, {
      data: {id_vale: id_vale, tipo_vale: tipo_vale, nombre_distribuidor: nombre_distribuidor, monto_vale: monto_vale, fecha_limite: fecha_limite, cantidad: cantidad}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === 1) {
        // When using an edit things are little different, firstly we find record inside DataService by id
        const foundIndex = this.exampleDatabase.dataChange.value.findIndex(x => x.id_vale === this.id);
        // Then you update that record using data from dialogData (values you enetered)
        this.exampleDatabase.dataChange.value[foundIndex] = this.dataService.getDialogData();
        // And lastly refresh table
        this.refreshTable();
      }
    });
  }

  deleteVale(i: number, id_vale: number, tipo_vale: string, nombre_distribuidor: string, monto_vale: number, fecha_limite: Date, cantidad: number) {
    this.index = i;
    this.id = id_vale;
    const dialogRef = this.dialog.open(DeleteDialogComponent, {
      data: {id_vale: id_vale, tipo_vale: tipo_vale, nombre_distribuidor: nombre_distribuidor, monto_vale: monto_vale, fecha_limite: fecha_limite, cantidad: cantidad}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === 1) {
        const foundIndex = this.exampleDatabase.dataChange.value.findIndex(x => x.id_vale === this.id);
        // for delete we use splice in order to remove single object from DataService
        this.exampleDatabase.dataChange.value.splice(foundIndex, 1);
        this.refreshTable();
      }
    });
  }

  printVale(i: number, id_vale: number, tipo_vale: string, nombre_distribuidor: string, monto_vale: number, fecha_limite: Date, cantidad: number) {
    this.index = i;
    this.id = id_vale;
    const dialogRef = this.dialog.open(ValesComponent, {
      data: {id_vale: id_vale, tipo_vale: tipo_vale, nombre_distribuidor: nombre_distribuidor, monto_vale: monto_vale, fecha_limite: fecha_limite, cantidad: cantidad}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === 1) {
        const foundIndex = this.exampleDatabase.dataChange.value.findIndex(x => x.id_vale === this.id);
        this.exampleDatabase.dataChange.value.splice(foundIndex, 1);
        this.refreshTable();
      }
    });
  }

  private refreshTable() {
    this.paginator._changePageSize(this.paginator.pageSize);
  }

  public getVales() {
    this.exampleDatabase = new DataService(this.httpClient);
    this.dataSource = new ExampleDataSource(this.exampleDatabase, this.paginator, this.sort);
    fromEvent(this.filter.nativeElement, 'keyup')
      .subscribe(() => {
        if (!this.dataSource) {
          return;
        }
        this.dataSource.filter = this.filter.nativeElement.value;
      });
  }
}

export class ExampleDataSource extends DataSource<vale> {
  filterChange = new BehaviorSubject('');

  get filter(): string {
    return this.filterChange.value;
  }

  set filter(filter: string) {
    this.filterChange.next(filter);
  }

  filteredData: vale[] = [];
  renderedData: vale[] = [];

  constructor(public _exampleDatabase: DataService,
              public _paginator: MatPaginator,
              public _sort: MatSort) {
    super();
    // Reset to the first page when the user changes the filter.
    this.filterChange.subscribe(() => this._paginator.pageIndex = 0);
  }

  /** Connect function called by the table to retrieve one stream containing the data to render. */
  connect(): Observable<vale[]> {
    // Listen for any changes in the base data, sorting, filtering, or pagination
    const displayDataChanges = [
      this._exampleDatabase.dataChange,
      this._sort.sortChange,
      this.filterChange,
      this._paginator.page
    ];

    this._exampleDatabase.getAllVales();


    return merge(...displayDataChanges).pipe(map( () => {
        // Filter data
        this.filteredData = this._exampleDatabase.vales.slice().filter((vales: vale) => {
          const searchStr = ("vales.nombre_distribuidor").toLowerCase();
          return searchStr.indexOf(this.filter.toLowerCase()) !== -1;
        });

        // Sort filtered data
        const sortedData = this.sortData(this.filteredData.slice());

        // Grab the page's slice of the filtered sorted data.
        const startIndex = this._paginator.pageIndex * this._paginator.pageSize;
        this.renderedData = sortedData.splice(startIndex, this._paginator.pageSize);
        return this.renderedData;
      }
    ));
  }

  disconnect() {}


  /** Returns a sorted copy of the database data. */
  sortData(data: vale[]): vale[] {
    if (!this._sort.active || this._sort.direction === '') {
      return data;
    }

    return data.sort((a, b) => {
      let propertyA: number | string = '';
      let propertyB: number | string = '';

      switch (this._sort.active) {
        case 'id': [propertyA, propertyB] = [a.id_vale, b.id_vale]; break;
        case 'tipo': [propertyA, propertyB] = [a.tipo_vale, b.tipo_vale]; break;
        case 'nombre': [propertyA, propertyB] = [a.nombre_distribuidor, b.nombre_distribuidor]; break;
        case 'monto': [propertyA, propertyB] = [a.monto_vale, b.monto_vale]; break;
        case 'fecha_limite': [propertyA, propertyB] = [a.fecha_limite.toLocaleString(), b.fecha_limite.toLocaleString()]; break;
        case 'cantidad': [propertyA, propertyB] = [a.cantidad, b.cantidad]; break;
      }

      const valueA = isNaN(+propertyA) ? propertyA : +propertyA;
      const valueB = isNaN(+propertyB) ? propertyB : +propertyB;

      return (valueA < valueB ? -1 : 1) * (this._sort.direction === 'asc' ? 1 : -1);
    });
  }
}