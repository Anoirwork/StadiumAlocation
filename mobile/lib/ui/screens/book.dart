import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddAppoint extends StatefulWidget {
  final bool isEditing;

  AddAppoint({
    Key key,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddAppointState();
  }
}

class AddAppointState extends State<AddAppoint>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final _appointFormKey = GlobalKey<FormState>();

  String _title;
  String _description;

  bool get isEditing => widget.isEditing;

  bool hideKeyboardEnabled = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _titleController.addListener(onTitleChange);
    _descriptionController.addListener(onDescriptionChange);
    WidgetsBinding.instance.addObserver(this);
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _titleFocus = FocusNode();

  void scrollInProgress() {
    hideKeyboardEnabled = false;
  }

  void scrollDone() {
    hideKeyboardEnabled = true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  void onTitleChange() {
    setState(() {
      _title = _titleController.text;
    });
  }

  void onDescriptionChange() {
    setState(() {
      _description = _descriptionController.text;
    });
  }

  bool _isValid() {
    return _title != null && _title.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: NotificationListener(
            // ignore: missing_return
            onNotification: (t) {
              if (t is UserScrollNotification) {
                if (hideKeyboardEnabled) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              }
            },
            child: CupertinoScrollbar(
              child: Form(
                key: _appointFormKey,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text("nächsten freien Termin finden"),
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            Future.delayed(Duration(seconds: 2));
                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                        _buildInformationCard(),
                      ],
                    ),
                    if (_isLoading) CupertinoActivityIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavBar() {
    return Container();
  }

  GestureDetector _buildPeriodTile() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                child: Text(
                  "dqsdqsd",
                  style: TextStyle(fontSize: 17),
                ),
                alignment: Alignment.centerLeft,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "dfsdfsdfsdf",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSelectPeriodButton() {
    return Container(
      height: 50,
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Zeitraum"),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey[350],
            ),
          ],
        ),
        onPressed: null,
      ),
    );
  }

  Container _buildSelectCompanyButton(Function companyTap) {
    return Container(
      height: 50,
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Unternehmen"),
            Icon(Icons.arrow_forward_ios,
                size: 18, color: Theme.of(context).accentColor),
          ],
        ),
        onPressed: companyTap,
      ),
    );
  }

  Row _buildTitleTextField(Function companyTap) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.only(left: 15),
            child: Align(
              child: TextFormField(
                controller: _titleController,
                autofocus: isEditing ? false : true,
                style: TextStyle(color: Colors.black),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  _titleFocus.unfocus();
                  companyTap();
                },
                decoration: InputDecoration(
                    hintText: "Titel",
                    suffixIcon: _titleController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              CupertinoIcons.clear_circled_solid,
                              size: 16,
                              color: Colors.grey[350],
                            ),
                            onPressed: () => _titleController.text = "",
                          )
                        : null,
                    border: InputBorder.none),
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }

  Container _buildDivider() {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Divider(
        height: 1,
      ),
    );
  }

  Widget _buildInformationCard() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: EnsureVisibleWhenFocused(
            scrollDone: () => scrollDone,
            scrollInProgress: () => scrollInProgress,
            focusNode: _descriptionFocus,
            child: TextFormField(
              focusNode: _descriptionFocus,
              controller: _descriptionController,
              minLines: 1,
              maxLines: 6,
              maxLength: 256,
              decoration: InputDecoration(
                  hintText: "Informationen",
                  suffixIcon: _descriptionController.text.isNotEmpty
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            CupertinoIcons.clear,
                            size: 32,
                            color: Colors.grey,
                          ),
                          onPressed: () => _descriptionController.text = "",
                        )
                      : null,
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}

class EnsureVisibleWhenFocused extends StatefulWidget {
  const EnsureVisibleWhenFocused({
    Key key,
    @required this.child,
    @required this.focusNode,
    this.curve: Curves.ease,
    this.scrollDone,
    this.scrollInProgress,
    this.duration: const Duration(milliseconds: 100),
  }) : super(key: key);

  /// The node we will monitor to determine if the child is focused
  final FocusNode focusNode;

  /// The child widget that we are wrapping
  final Widget child;

  /// The curve we will use to scroll ourselves into view.
  ///
  /// Defaults to Curves.ease.
  final Curve curve;

  /// The duration we will use to scroll ourselves into view
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  final Function scrollInProgress;
  final Function scrollDone;

  @override
  _EnsureVisibleWhenFocusedState createState() =>
      new _EnsureVisibleWhenFocusedState();
}

class _EnsureVisibleWhenFocusedState extends State<EnsureVisibleWhenFocused>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_ensureVisible);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.focusNode.removeListener(_ensureVisible);
    super.dispose();
  }

  ///
  /// This routine is invoked when the window metrics have changed.
  /// This happens when the keyboard is open or dismissed, among others.
  /// It is the opportunity to check if the field has the focus
  /// and to ensure it is fully visible in the viewport when
  /// the keyboard is displayed
  ///
  @override
  void didChangeMetrics() {
    if (widget.focusNode.hasFocus) {
      _ensureVisible();
    }
  }

  ///
  /// This routine waits for the keyboard to come into view.
  /// In order to prevent some issues if the Widget is dismissed in the
  /// middle of the loop, we need to check the "mounted" property
  ///
  /// This method was suggested by Peter Yuen (see discussion).
  ///
  Future<Null> _keyboardToggled() async {
    if (mounted) {
      EdgeInsets edgeInsets = MediaQuery.of(context).viewInsets;
      while (mounted && MediaQuery.of(context).viewInsets == edgeInsets) {
        await new Future.delayed(const Duration(milliseconds: 10));
      }
    }

    return;
  }

  Future<Null> _ensureVisible() async {
    // Wait for the keyboard to come into view
    await Future.any([
      new Future.delayed(const Duration(milliseconds: 300)),
      _keyboardToggled()
    ]);

    // No need to go any further if the node has not the focus
    if (!widget.focusNode.hasFocus) {
      return;
    }

    // Find the object which has the focus
    final RenderObject object = context.findRenderObject();
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);

    // If we are not working in a Scrollable, skip this routine
    if (viewport == null) {
      return;
    }

    // Get the Scrollable state (in order to retrieve its offset)
    ScrollableState scrollableState = Scrollable.of(context);
    assert(scrollableState != null);

    // Get its offset
    ScrollPosition position = scrollableState.position;
    double alignment;

    if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
      // Move down to the top of the viewport
      alignment = 0.0;
    } else if (position.pixels <
        viewport.getOffsetToReveal(object, 1.0).offset) {
      // Move up to the bottom of the viewport
      alignment = 1.0;
    } else {
      // No scrolling is necessary to reveal the child
      return;
    }
    widget.scrollInProgress();
    position
        .ensureVisible(
          object,
          alignment: alignment,
          duration: widget.duration,
          curve: widget.curve,
        )
        .then((_) => widget.scrollDone);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
