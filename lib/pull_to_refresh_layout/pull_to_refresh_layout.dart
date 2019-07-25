// import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import '../../exports.dart';


// class PullToRefreshLayout extends StatefulWidget {
//   Future<Result<dynamic>> Function(int page) onLoadData;
//   int initialCount = 0;
//   final Widget child;

//   PullToRefreshLayout({
//     Key key,
//     this.onLoadData,
//     this.initialCount,
//     this.child,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _PullToRefreshLayoutState();
// }

// class _PullToRefreshLayoutState extends State<PullToRefreshLayout> {
//   int _currentPage = 1;
//   bool _firstLoading = true;

//   double _listLoadIndicatorOpacity = 0;
//   double _linearProgressIndicatorOpacity = 0;

//   RefreshController _refreshController;

//   @override
//   void initState() {
//     super.initState();

//     _refreshController = RefreshController(initialRefresh: false);

//     _listLoadIndicatorOpacity = widget.initialCount == 0 ? 1 : 0;
//     _linearProgressIndicatorOpacity = widget.initialCount > 0 ? 1 : 0;

//     if (widget.onLoadData != null) {
//       Future.delayed(Duration(milliseconds: 200)).then((_) {
//         this._handleLoadData(0);
//       });
//     }
//   }

//   void dispose(){
//     _refreshController.dispose();
//     super.dispose();
//   }

//   void _handleLoadData(int currentPage) {
//     if (widget.onLoadData != null) {
//       Future<Result<dynamic>> future = widget.onLoadData(currentPage);
//       future
//         .then((result) {
//           if (currentPage == 1) {
//             Future.delayed(Duration(milliseconds: 300)).then((_) {
//               _refreshController.resetNoData();
//               _refreshController.refreshCompleted();
//             });
//           } else {
//             Future.delayed(Duration(milliseconds: 300)).then((_) {
//               _refreshController.loadComplete();
//             });
//           }

//           Pagination pagination = result.pagination;

//           if ((pagination.currentPage) >= pagination.lastPage) {
//             Future.delayed(Duration(milliseconds: 300)).then((_) {
//               _refreshController.loadNoData();
//             });
//           }
//           setState(() {
//             _currentPage = pagination.currentPage;
//             _firstLoading = false;
//             _listLoadIndicatorOpacity = 0;
//             _linearProgressIndicatorOpacity = 0;
//           });
//         })
//         .catchError((error) {
//           if (currentPage == 1) {
//             _refreshController.refreshFailed();
//           } else {
//             _refreshController.loadFailed();
//           }
//           setState(() {
//             _firstLoading = false;
//             _listLoadIndicatorOpacity = 0;
//             _linearProgressIndicatorOpacity = 0;
//           });
//         });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData = Theme.of(context);
//     bool isDisplayLinearProgressIndicator = widget.initialCount > 0;

//     return Stack(
//       children: <Widget>[
//         SmartRefresher(
//           enablePullDown: widget.onLoadData != null,
//           enablePullUp: widget.onLoadData != null,
//           header: ClassicHeader(
//             releaseText: '松开立即刷新',
//             refreshingText: '正在刷新数据中...',
//             completeText: '刷新完成',
//             failedText: '刷新失败',
//             idleText: '下拉可以刷新',
//           ),
//           footer: ClassicFooter(
//             textStyle: TextStyle(
//               fontSize: 12,
//             ),
//             noDataText: '-没有更多数据了-',
//           ),
//           controller: _refreshController,
//           onRefresh: () {
//             this._handleLoadData(1);
//           },
//           onLoading: () {
//             this._handleLoadData(_currentPage + 1);
//           },
//           child: widget.child,
//         ),
//         AnimatedOpacity(
//           duration: Duration(milliseconds: 600),
//           opacity: _listLoadIndicatorOpacity,
//           child: ListLoadIndicator(),
//         ),
//         Positioned(
//           right: 16,
//           top: 12,
//           child: !isDisplayLinearProgressIndicator ? Container() : AnimatedOpacity(
//             duration: Duration(milliseconds: 600),
//             opacity: _linearProgressIndicatorOpacity,
//             child: SizedBox(
//               width: 18,
//               height: 18,
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
