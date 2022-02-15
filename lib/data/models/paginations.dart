class PaginationDelegate<T> {

  int get initialPage => _initialPage;

  void setInitialPageAndReloadData(int value) async {
    _initialPage = value;
    await reloadData();
  }

  bool paginationBeforeFirstPage;
  late final int loadingOffset;
  final Future<T> Function(int page) getData;
  final int Function(T newData) getTotalPages;
  final int Function(T newData) getTotalResultOnPage;
  final void Function(T newData, bool needAddToEnd) updateData;

  late final int? savePageLimit;
  late final int Function(Map<int, int> currentCountOfPage)? onDisposeFirstPages;  
  late final int Function(Map<int, int> currentCountOfPage)? onDisposeLastPages;  

  Future<void> autoUploadingMoviesByIndex(int index, int listLength) async {
    
    if (_paginationIsUnnecessary(index, listLength)) return;
  
    _loadingIsStarted = true;

    final isEndPagination = _needPaginationOfEnd(index, listLength);
    final nextRequestPage = isEndPagination ? _nextPage! : _loadedPages.first - 1;

    final data = await getData(nextRequestPage);
    _totalPage = getTotalPages(data);
    _conditionalDisposeUnusedData(isEndPagination);
    _addPageToPageList(isEndPagination, getTotalResultOnPage(data));
    
    _totalPage = getTotalPages(data);
    updateData(data, isEndPagination);
    _loadingIsStarted = false;
  }
  
  Future<void> reloadData() async {
    _totalPage = 1;
    _loadedPagesMap.clear();
    await setup();
  }

  Future<void> setup() async {
    _loadingIsStarted = true;
    final data = await getData(_initialPage);
    updateData(data, true);
    _totalPage = getTotalPages(data);
    _loadedPagesMap[_initialPage] = getTotalResultOnPage(data);
    _loadingIsStarted = false;
  }

  late int _initialPage;

  int? get _nextPage  => 
    _loadedPages.last < _totalPage ? _loadedPages.last + 1 : null;

  late int _totalPage;

  int get _totalLoadedPage => _loadedPages.length;

  int get _limitFirstPage => paginationBeforeFirstPage ? 1 : _initialPage;

  Map<int, int> _loadedPagesMap = {};
  Iterable<int> get _loadedPages => _loadedPagesMap.keys;

  bool get _lazy => savePageLimit != null;

  bool _loadingIsStarted = false; 

  bool _paginationIsUnnecessary(int index, int listLength) {
    return 
    (_loadingIsStarted || _indexOutOfPaginationRange(index, listLength))
    ||
    (_needPaginationOfStart(index, listLength) && _loadedPages.first <= _limitFirstPage)
    ||
    (_needPaginationOfEnd(index, listLength) && _nextPage == null);
  }

  void _addPageToPageList(bool isEndPagination, int totalPageResult) {
    if (isEndPagination) {
      _loadedPagesMap[_nextPage!] = totalPageResult;
      return;  
    } 
    _loadedPagesMap = <int,int> {
      _loadedPages.first - 1 : totalPageResult,
      ... _loadedPagesMap};    
  }
  
  bool _indexOutOfPaginationRange(int index, int listLength) =>
    index > loadingOffset && index < (listLength - 1) - loadingOffset;

  bool _needPaginationOfEnd(int index, int listLength) =>
    index >= (listLength - 1) - loadingOffset;  

  bool _needPaginationOfStart(int index, int listLength) => 
    index <= loadingOffset;
  
  void _conditionalDisposeUnusedData(bool isEndPagination) {
    if (!_lazy || _totalLoadedPage + 1 <= savePageLimit!) return;

    if (isEndPagination) {
      return _removeRangeOfMap(0, onDisposeFirstPages!(_loadedPagesMap));
    }
    var lenght =  _loadedPages.length;
    _removeRangeOfMap(lenght - onDisposeLastPages!(_loadedPagesMap), lenght);
  }

  void _removeRangeOfMap(int start, int lenght) {
    var keys = _loadedPagesMap.keys.toList().getRange(start, lenght);
    for (var i = start; i < lenght; i++) {
      _loadedPagesMap.remove(keys.elementAt(i));
    }
  }

  /// Осуществляет простое управление пагинацией страниц, активируя её при достижении
  /// определенного значения `index`, который передается из `ListView.builder`.
  /// 
  /// Производит контролируемую очистку данных  в случае превышения лимита `savePageLimit`, 
  /// вызывая замыкания `onDisposeFirstPages()` и `onDisposeLastPages()`, которые должны 
  /// возвращать количество удаленных страниц. 
  PaginationDelegate.lazy({
    required int initialPage,
    this.paginationBeforeFirstPage = true,
    required int loadingOffset,
    required this.getData,
    required this.getTotalPages,
    required this.getTotalResultOnPage,
    required this.updateData,
    required this.savePageLimit,
    required this.onDisposeFirstPages,
    required this.onDisposeLastPages,
  }) {
    this.loadingOffset = loadingOffset - 1 > 0 ? loadingOffset - 1 : 0;
    _initialPage = initialPage;
  }

  /// Осуществляет простое управление пагинацией страниц, активируя её при достижении
  /// определенного значения `index`:
  /// 
  /// `index >= listLength - loadingOffset` `||` `index <= loadingOffset - 1`, 
  /// 
  /// `index` передается из `ListView.builder`.
  PaginationDelegate.safety({
    required int initialPage,
    this.paginationBeforeFirstPage = true,
    required int loadingOffset,
    required this.getData,
    required this.getTotalPages,
    required this.getTotalResultOnPage,
    required this.updateData,
  }) {
    this.loadingOffset = loadingOffset - 1 > 0 ? loadingOffset - 1 : 0;
    _initialPage = initialPage;
    savePageLimit = null;
    onDisposeFirstPages = null;  
    onDisposeLastPages = null;  
  }
}
