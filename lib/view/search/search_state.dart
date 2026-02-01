class Loadable<T> {
  final bool isLoading;
  final T data;
  final String? error;

  const Loadable({
    required this.isLoading,
    required this.data,
    this.error,
  });

  factory Loadable.initial(T empty) =>
      Loadable(isLoading: false, data: empty);
}
