import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/server/laravel_config.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  _BodyBlog createState() => _BodyBlog();
}

class _BodyBlog extends State<BlogScreen> {
  late List<Post> _posts = <Post>[];
  @override
  initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _posts = (await postsServices.getPosts());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBarMenu(
        height: currentSize.height * 0.14,
        title: 'Blog',
        menudisplay: false,
      ),
      body: _posts.isEmpty
          ? Center(child: LoadingProgress())
          : ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: CustomColors.buttonEnabled,
                useInkWell: true,
                expandIcon: Icons.visibility,
                collapseIcon: Icons.visibility_off,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: ListCardBlog(_posts),
              ),
            ),
    );
  }

  List<Widget> ListCardBlog(List<Post> lstPost) {
    final currentSize = MediaQuery.of(context).size;
    final List<Widget> lstWidwet = [];
    lstWidwet.add(Container(
      height: currentSize.height * 0.17,
      width: double.infinity,
      color: CustomColors.ButtonEnabledAction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lo más nuevo',
              style: TextStyle(
                fontFamily: 'Montserrat,SemiBold',
                color: CustomColors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.050,
                // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.lineWhite),
          ),
        ],
      ),
    ));
    for (var element in lstPost) {
      lstWidwet.add(Transform.translate(
          offset: const Offset(0, -90), child: CardBlog(post: element)));
    }
    return lstWidwet;
  }
}

class CardBlog extends StatelessWidget {
  final Post post;
  const CardBlog({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
        clipBehavior: Clip.antiAlias,
        color: CustomColors.ButtonEnabledAction,
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  shape: BoxShape.rectangle,
                ),
                child: Image.network(
                    'https://${LaravelConfig.baseUrl}/storage/${post.banner}'),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Leer contenido",
                      style: TextStyle(
                        fontFamily: 'Montserrat,SemiBold',
                        color: CustomColors.buttonEnabled,
                        fontWeight: FontWeight.normal,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                      ),
                    )),
                collapsed: Text(CustomFuntions.removeHtmlTags(post.text),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat,SemiBold',
                      color: CustomColors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    )),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(5))
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(CustomFuntions.removeHtmlTags(post.text),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: 'Montserrat,SemiBold',
                                color: CustomColors.white,
                                fontWeight: FontWeight.normal,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045,
                              ))),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
