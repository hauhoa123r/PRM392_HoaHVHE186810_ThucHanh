enum MovieSort {
  az('A-Z'),
  za('Z-A'),
  year('Year'),
  rating('Rating');

  const MovieSort(this.label);

  final String label;
}
