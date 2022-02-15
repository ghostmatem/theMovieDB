extension Format on DateTime {
  toStringFormat() {
    return '$day ${_ruMonthList[month - 1]} $year г.';
  }
  static const _ruMonthList = <String> [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июля',
    'Июня',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря'
  ];
}