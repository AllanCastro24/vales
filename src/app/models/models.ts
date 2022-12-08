export class Issue {
  id: number;
  title: string;
  state: string;
  url: string;
  created_at: string;
  updated_at: string;
}

export class vale{
  id_vale: number;
  tipo_vale: string;
  id_ditribuidor: number;
  nombre_distribuidor: string;
  monto_vale: number;
  fecha_limite: Date;
  cantidad: number;
}