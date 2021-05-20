import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/screen/sight_search_screen.dart';

class SearchBar extends StatefulWidget {
  final bool _searchWithFilter;
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchBar.withFilter(
    this.controller,
    this.focusNode,
  ) : _searchWithFilter = true;
  SearchBar.searchable(
    this.controller,
    this.focusNode,
  ) : _searchWithFilter = false;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Color _greyColor = Color(0xffF5F5F5);

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: _greyColor,
      ),
    );
  }

  Widget buildSuffixIcon(BuildContext context) {
    if (widget._searchWithFilter) {
      return IconButton(
        // iconSize: 24,
        icon: SvgPicture.asset(
          iconFilter,
        ),
        onPressed: () {
          // _controller.
          print('FiltersScreen');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FiltersScreen()),
          );
        },
      );
    } else {
      widget.controller.addListener(() {
        setState(() {});
      });
      return IconButton(
        iconSize: 24,
        icon: SvgPicture.asset(
          iconClear,
          color: Colors.black,
        ),
        onPressed: () {
          widget.controller.clear();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: widget._searchWithFilter ? true : false,
          autofocus: widget._searchWithFilter ? false : true,
          onTap: () {
            if (widget._searchWithFilter) {
              print('SightSearchScreen');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SightSearchScreen()),
              );
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: _greyColor,
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            border: buildBorder(),
            disabledBorder: buildBorder(),
            prefixIcon: Container(
              width: 24,
              height: 24,
              child: Center(
                child: SvgPicture.asset(
                  iconSearch,
                  color: Color(0xff7C7E92),
                ),
              ),
            ),
            // suffixIcon: buildSuffixIcon(context),
            hintText: 'Поиск',
            hintStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
        buildSuffixIcon(context),
      ],
    );
  }
}
