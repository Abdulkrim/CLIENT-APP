class WorkerListInfo {
  final List<WorkerItem> workers;
  final int currentPage;
  final int totalPage;

  WorkerListInfo(this.workers, this.currentPage, this.totalPage);
}

class WorkerItem {
  final String id;
  final String branchId;
  final String fullName;
  final num total;
  bool isActive;

  WorkerItem({required this.id, required this.total, required this.branchId, required this.fullName, required this.isActive});
}
