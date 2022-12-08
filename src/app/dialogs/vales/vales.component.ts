import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {Component, Inject, OnInit} from '@angular/core';
import {DataService} from '../../services/data.service';
import jsPDF from 'jspdf';

@Component({
  selector: 'app-vales',
  templateUrl: './vales.component.html',
  styleUrls: ['./vales.component.css']
})
export class ValesComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<ValesComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any, public dataService: DataService) { }

  ngOnInit(): void {
  }

  onNoClick(): void {
    //Cerrar dialogo
    this.dialogRef.close();
  }

  confirmPrint(): void {
    //Método para imprimir
    const doc = new jsPDF();
    console.log(this.data);
    alert('Generando Reporte...')

    // Hacer un for de 1 a 6, si es numero impar se imprime a la izquierda, si es par, a la derecha
    //this.dataService.deleteIssue(this.data.id);
  }
}
