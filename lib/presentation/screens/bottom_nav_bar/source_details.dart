import 'package:flutter/material.dart';
import 'package:newsbloc/data/export_data.dart';
import 'package:newsbloc/presentation/widgets/export_widget.dart';
import 'package:newsbloc/shared/app_styles.dart';

class SourceDetails extends StatefulWidget {
  final newsSource;

  const SourceDetails({Key key, this.newsSource}) : super(key: key);
  @override
  _SourceDetailsState createState() => _SourceDetailsState();
}

class _SourceDetailsState extends State<SourceDetails> {
  bool isLoading = true;
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {
    NewsSource categoryNews = new NewsSource();
    await categoryNews.getNewsSource(widget.newsSource);
    articles = categoryNews.categorySourceList;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(widget.newsSource.toString().toUpperCase(),
              style: AppStyles().categoryTitle),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(), //progress bar
                ),
              )
            : updateUI(articles));
  }

  Widget updateUI(List<Article> newsList) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.95,
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return NewsBlogTile(
                    urlToImage: newsList[index].urlToImage,
                    title: newsList[index].title,
                    description: newsList[index].description,
                    url: newsList[index].url,
                    author: newsList[index].author);
              }),
        ),
        Divider(),
      ],
    ));
  }
}
