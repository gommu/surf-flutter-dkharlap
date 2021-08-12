import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets_uri.dart';

class AddSightScreen extends StatefulWidget {
  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final nameFieldController = TextEditingController();
  final latitudeFieldController = TextEditingController();
  final longitudeFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  final nameFocusNode = FocusNode();
  final latitudeFocusNode = FocusNode();
  final longitudeFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  final List<Widget> _photoCardsList = [];

  @override
  void dispose() {
    nameFieldController.dispose();
    latitudeFieldController.dispose();
    longitudeFieldController.dispose();
    descriptionFieldController.dispose();

    nameFocusNode.dispose();
    latitudeFocusNode.dispose();
    longitudeFocusNode.dispose();
    descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        toolbarHeight: 56,
        leading: TextButton(
          child: Center(
            child: Text(
              'Отмена',
              style: Theme.of(context).appBarTheme.textTheme.headline5,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Новое место'),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: 16.0),
                      physics: BouncingScrollPhysics(),
                      children: [
                        buildEmptyImageCard(context),
                        ..._photoCardsList,
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'КАТЕГОРИЯ',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Не выбрано',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          iconRightArrow,
                          color: Colors.black,
                          height: 24.0,
                          width: 24.0,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildSectionText(context, 'НАЗВАНИЕ'),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    decoration: buildInputDecoration(
                      nameFieldController,
                      nameFocusNode,
                      false,
                    ),
                    controller: nameFieldController,
                    // autofocus: true,
                    focusNode: nameFocusNode,
                    onSubmitted: (value) {
                      latitudeFocusNode.requestFocus();
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionText(context, 'ШИРОТА'),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: TextField(
                                controller: latitudeFieldController,
                                focusNode: latitudeFocusNode,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                textInputAction: TextInputAction.next,
                                decoration: buildInputDecoration(
                                  latitudeFieldController,
                                  latitudeFocusNode,
                                  true,
                                ),
                                onSubmitted: (value) {
                                  longitudeFocusNode.requestFocus();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionText(context, 'ДОЛГОТА'),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: TextField(
                                controller: longitudeFieldController,
                                focusNode: longitudeFocusNode,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: buildInputDecoration(
                                  longitudeFieldController,
                                  longitudeFocusNode,
                                  true,
                                ),
                                onSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(descriptionFocusNode);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Указать на карте',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildSectionText(context, 'ОПИСАНИЕ'),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: descriptionFieldController,
                    focusNode: descriptionFocusNode,
                    decoration: buildInputDecoration(
                      descriptionFieldController,
                      descriptionFocusNode,
                      false,
                    ).copyWith(
                        hintText: 'введите текст',
                        hintStyle: Theme.of(context).textTheme.headline2),
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Sight newSight = Sight(
                          name: nameFieldController.text,
                          lat: double.parse(latitudeFieldController.text),
                          lon: double.parse(longitudeFieldController.text),
                          url: 'empty',
                          type: 'some type',
                          details: descriptionFieldController.text,
                        );
                        mocks.add(newSight);
                        print('${newSight.toString()} added');
                      },
                      // onPressed: null,
                      child: Text('СОЗДАТЬ'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text buildSectionText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 12,
          ),
    );
  }

  InputDecoration buildInputDecoration(
    TextEditingController controller,
    FocusNode focus,
    bool suffixEnabled,
  ) {
    InputDecoration decoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
      ),
    );

    if (suffixEnabled) {
      controller.addListener(() {
        setState(() {});
      });
      return decoration.copyWith(
        suffixIcon: controller.text.length > 0 && focus.hasFocus
            ? IconButton(
                iconSize: 24,
                icon: SvgPicture.asset(
                  iconClear,
                  color: Colors.black,
                ),
                onPressed: () {
                  controller.clear();
                },
              )
            : null,
      );
    }

    return decoration;
  }

  Widget buildEmptyImageCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          // Adding of Image Cards for Sight
          // setState(() {
          //   _photoCardsList.add(buildImageCard(UniqueKey()));
          // });

          _showSelectImageSourceDialog();
        },
        child: Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              top: BorderSide(
                width: 1.0,
                color: Theme.of(context).primaryColor,
              ),
              left: BorderSide(
                width: 1.0,
                color: Theme.of(context).primaryColor,
              ),
              right: BorderSide(
                width: 1.0,
                color: Theme.of(context).primaryColor,
              ),
              bottom: BorderSide(
                width: 1.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: 45,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showSelectImageSourceDialog() async {
    var result = await showDialog(
      context: context,
      builder: (_) {
        return SelectImageSourceDialog();
      },
    );
  }

  Widget buildImageCard(Key key) {
    return Dismissible(
      key: key,
      direction: DismissDirection.vertical,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Stack(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imgEiffel),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 28, maxHeight: 28),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _photoCardsList
                        .removeWhere((element) => element.key == key);
                  });
                },
                icon: SvgPicture.asset(
                  iconClear,
                  color: Colors.white,
                  height: 24.0,
                  width: 24.0,
                ),
                padding: const EdgeInsets.all(0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectImageSourceDialog extends StatelessWidget {
  const SelectImageSourceDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      elevation: 0.0,
      content: Container(
        width: MediaQuery.of(context).size.width - 32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _options("Камера", iconCamera, context),
                  Divider(),
                  _options("Фото", iconPhoto, context),
                  Divider(),
                  _options("Файл", iconFile, context),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, 'cancel');
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: Center(
                    child: Text(
                  "ОТМЕНА",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Theme.of(context).primaryColor),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _options(String name, String iconPath, BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        SvgPicture.asset(
          iconPath,
          color: color,
          height: 24.0,
          width: 24.0,
        ),
        const SizedBox(width: 13),
        Text(
          name,
          style: Theme.of(context).textTheme.headline3.copyWith(color: color),
        ),
      ]),
    );
  }
}
