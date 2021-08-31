import 'package:flutter/material.dart';
import 'package:message/Event/ListViewBuilderEvent.dart';
import 'package:message/Static/Constants.dart';

class ListViewBuilder extends StatefulWidget {
  ListViewBuilder({
    Key? key,
    this.initListData,
    this.scrollController,
  });

  late final List<Map<String, dynamic>>? initListData;
  final ScrollController? scrollController;

  @override
  _ListViewBuilderState createState() => new _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  late ListViewBuilderEvent listViewBuilderEvent;

  @override
  void initState() {
    listViewBuilderEvent = new ListViewBuilderEvent(this);
    if (widget.initListData == null) {
    } else {
      listViewBuilderEvent.listData = widget.initListData!;
    }

    /**Add scrollController for toggle visibility if floating action button exist**/
    if (widget.scrollController != null) {
      listViewBuilderEvent.scrollController = widget.scrollController!;
    }

    listViewBuilderEvent.preLoad();
    super.initState();
  }

  @override
  void dispose() {
    listViewBuilderEvent.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: RefreshIndicator(
            key: listViewBuilderEvent.refreshIndicatorKey,
            color: Theme.of(context).accentColor,
            child: _buildListDataItem(),
            onRefresh: () => listViewBuilderEvent.loadList(1),
          ),
        ),
        Visibility(
          visible: listViewBuilderEvent.isLoading,
          child: new Center(
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListDataItem() {
    return listViewBuilderEvent.listData.isEmpty
        ? ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.all(Constants.padding),
                  child: Text(
                    "Không có dữ liệu!",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.subtitle2!.fontSize,
                    ),
                  ),
                ),
              )
            ],
          )
        : ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: listViewBuilderEvent.listData.length,
            controller: listViewBuilderEvent.scrollController,
            itemBuilder: (context, i) {
              Widget _buildItem = Container();
              if (i < listViewBuilderEvent.listData.length) {
                _buildItem = _buildRow(listViewBuilderEvent.listData[i]);
              }
              return _buildItem;
            },
          );
  }

  Widget _buildRow(Map<String, dynamic> listData) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(Constants.paddingSmall),
            child: Text(listData.keys.first.toString()),
          ),
          Container(
            padding: EdgeInsets.all(Constants.paddingSmall),
            child: listData.values.first,
          ),
        ],
      ),
    );
  }
}
