class Pagination {
  const Pagination({this.page, this.pageSize});
  final int? page;
  final int? pageSize;
  Map<String, dynamic> getPagination() {
    return <String, dynamic>{
      'pagination': <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      }
    };
  }
}
