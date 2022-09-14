String rupiah(value, {String separator='.', String trailing=''}) {
  return "Rp " + value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator') + trailing;
}
String number_rupiah(value, {String separator='.', String trailing=''}) {
  return value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator') + trailing;
}