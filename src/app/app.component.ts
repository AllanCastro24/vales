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
        // Para agregar hacer un push al servicio
        this.exampleDatabase.dataChange.value.push(this.dataService.getDialogData());
        this.refreshTable();
        this.getVales();
      }
    });
  }

  editVale(i: number, id_vale: number, tipo_vale: string, nombre_distribuidor: string,apellido_distribuidor: string, clave_distribuidor: number, monto_vale: number, fecha_limite: Date, cantidad: number) {
    this.id = id_vale;
    // Indice utilizado para debugear
    this.index = i;
    const dialogRef = this.dialog.open(EditDialogComponent, {
      data: {id_vale: id_vale, tipo_vale: tipo_vale, nombre_distribuidor: nombre_distribuidor, apellido_distribuidor:apellido_distribuidor,clave_distribuidor: clave_distribuidor, monto_vale: monto_vale, fecha_limite: fecha_limite, cantidad: cantidad}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === 1) {
        // Despues de cerrar, recagar
        const foundIndex = this.exampleDatabase.dataChange.value.findIndex(x => x.id_vale === this.id);
        this.exampleDatabase.dataChange.value[foundIndex] = this.dataService.getDialogData();
        this.refreshTable();
        this.getVales();
      }
    });
  }

  deleteVale(i: number, id_vale: number, tipo_vale: string, nombre_distribuidor: string,apellido_distribuidor: string, clave_distribuidor: number, monto_vale: number, fecha_limite: Date, cantidad: number) {
    this.index = i;
    this.id = id_vale;
    const dialogRef = this.dialog.open(DeleteDialogComponent, {
      data: {id_vale: id_vale, tipo_vale: tipo_vale, nombre_distribuidor: nombre_distribuidor,apellido_distribuidor: apellido_distribuidor,clave_distribuidor: clave_distribuidor, monto_vale: monto_vale, fecha_limite: fecha_limite, cantidad: cantidad}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === 1) {
        // Despues de cerrar, recagar
        const foundIndex = this.exampleDatabase.dataChange.value.findIndex(x => x.id_vale === this.id);
        this.exampleDatabase.dataChange.value.splice(foundIndex, 1);
        this.refresh();
      }
    });
  }

  printVale(i: number, id_vale: number, tipo_vale: string, nombre_distribuidor: string,apellido_distribuidor: string, clave_distribuidor: number, monto_vale: number, fecha_limite: Date, cantidad: number) {
    this.index = i;
    this.id = id_vale;
    const dialogRef = this.dialog.open(ValesComponent, {
      data: {id_vale: id_vale, tipo_vale: tipo_vale, nombre_distribuidor: nombre_distribuidor,apellido_distribuidor: apellido_distribuidor,clave_distribuidor:clave_distribuidor, monto_vale: monto_vale, fecha_limite: fecha_limite, cantidad: cantidad}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === 1) {
        // Despues de cerrar, recagar
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

  filteredData: any[] = [];
  renderedData: any[] = [];

  constructor(public _exampleDatabase: DataService,
              public _paginator: MatPaginator,
              public _sort: MatSort) {
    super();
    this.filterChange.subscribe(() => this._paginator.pageIndex = 0);
  }

  connect(): Observable<vale[]> {
    const displayDataChanges = [
      this._exampleDatabase.dataChange,
      this._sort.sortChange,
      this.filterChange,
      this._paginator.page
    ];

    this._exampleDatabase.getAllVales();


    return merge(...displayDataChanges).pipe(map( () => {
        // Datos filtrados
        this.filteredData = this._exampleDatabase.vales.slice().filter((vales: any) => {
          const searchStr = (vales[6] + " " + vales[7]).toLowerCase();
          return searchStr.indexOf(this.filter.toLowerCase()) !== -1;
        });

        // Ordenar datos filtrados
        const sortedData = this.sortData(this.filteredData.slice());

        const startIndex = this._paginator.pageIndex * this._paginator.pageSize;
        this.renderedData = sortedData.splice(startIndex, this._paginator.pageSize);
        return this.renderedData;
      }
    ));
  }

  disconnect() {}


  /** Retornar una copia ordenada del modelo */
  sortData(data: any[]): any[] {
    if (!this._sort.active || this._sort.direction === '') {
      return data;
    }

    return data.sort((a, b) => {
      let propertyA: number | string = '';
      let propertyB: number | string = '';

      switch (this._sort.active) {
        case 'id': [propertyA, propertyB] = [a[0], b[0]]; break;
        case 'tipo': [propertyA, propertyB] = [a[1], b[1]]; break;
        case 'nombre': [propertyA, propertyB] = [a[6] + " " + a[7], b[6] + " " + b[7]]; break;
        case 'monto': [propertyA, propertyB] = [a[3], a[3]]; break;
        case 'fecha_limite': [propertyA, propertyB] = [a[4].toLocaleString(), b[4].toLocaleString()]; break;
        case 'cantidad': [propertyA, propertyB] = [a[5], b[5]]; break;
      }

      const valueA = isNaN(+propertyA) ? propertyA : +propertyA;
      const valueB = isNaN(+propertyB) ? propertyB : +propertyB;

      return (valueA < valueB ? -1 : 1) * (this._sort.direction === 'asc' ? 1 : -1);
    });
  }
}