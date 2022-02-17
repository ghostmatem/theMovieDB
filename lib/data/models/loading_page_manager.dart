class LoadingPageManager {

  int get currentPage => _currentPage;
  int totalPage = 1;
  
  bool loadingIsProgress = false;
  int? get nextPage => _currentPage + 1 <= totalPage ? _currentPage + 1 : null;

  void incrementCurrentPage() => _currentPage++;
  int _currentPage = 0;

}