class F1Team {
  final String nombre;
  final String imagen;

  const F1Team({required this.nombre, required this.imagen});
}

const List<F1Team> f1Teams = [
  F1Team(nombre: 'Scuderia Ferrari', imagen: 'ferrari.jpeg'),
  F1Team(nombre: 'Mercedes AMG Petronas', imagen: 'mercedes.jpeg'),
  F1Team(nombre: 'McLaren F1 Team', imagen: 'mclaren.jpeg'),
  F1Team(nombre: 'Audi Revolut F1 Team', imagen: 'audi.jpeg'),
  F1Team(nombre: 'Red Bull Racing', imagen: 'redbull.jpeg'),
];
