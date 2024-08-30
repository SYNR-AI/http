// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cupertino_http/cupertino_http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_image_provider/http_image_provider.dart';
import 'package:provider/provider.dart';

import 'book.dart';

void main() {
  Client httpClient;

  runApp(Provider<Client>(
      create: (_) {
        // CupertinoCronet.setHttp2Enabled(false);
        // CupertinoCronet.setQuicEnabled(false);
        // CupertinoCronet.setMetricsEnabled(true);
        // CupertinoCronet.setHttpCacheType(
        //     CupertinoCronetCacheType.CupertinoCronetHttpCacheTypeDisabled);
        // CupertinoCronet.setUserAgent_partial('Cronet', true);
        // CupertinoCronet.start();
        // CupertinoCronet.startNetLogToFile('cronet_dart.log', false);
        // CupertinoCronet.registerHttpProtocolHandler();
        // CupertinoCronet.setRequestFilterHostWhiteList(['museland.ai']);
        final config = URLSessionConfiguration.defaultSessionConfiguration();
        CupertinoCronet.installIntoSessionConfiguration(config);
        httpClient = CupertinoClient.fromSessionConfiguration(config);
        return httpClient;
      },
      child: const BookSearchApp(),
      dispose: (_, client) => client.close()));
}

class BookSearchApp extends StatelessWidget {
  const BookSearchApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        // Remove the debug banner.
        debugShowCheckedModeBanner: false,
        title: 'Book Search',
        home: HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book>? _books;
  String? _lastQuery;
  late Client _client;

  @override
  void initState() {
    super.initState();
    _client = context.read<Client>();
  }

  // Get the list of books matching `query`.
  // The `get` call will automatically use the `client` configured in `main`.
  Future<List<Book>?> _findMatchingBooks(String query) async {
    https: //s1-resource-dev.museland.ai/muser/webp/post_507602102041413.webp
    final response = await _client.get(
      Uri.https('s1-resource-dev.museland.ai',
          'muser/webp/avatar_504893042629573.webp'),
    );
    print('request end ${response.metrics}');
    Timer(Duration(seconds: 10), () {
      CupertinoCronet.stopNetLog();
    });
    return null;
    // final response = await _client.get(
    //   Uri.https(
    //     'www.googleapis.com',
    //     '/books/v1/volumes',
    //     {'q': query, 'maxResults': '20', 'printType': 'books'},
    //   ),
    // );
    // print('response metric = ${response.metrics}');
    // final json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // return Book.listFromJson(json);
  }

  Future<List<Book>?> _findMatchingBooks1(String query) async {
    https: //s1-resource-dev.museland.ai/muser/webp/post_507602102041413.webp
    final response = await _client.get(
      Uri.https('s1-resource-dev.museland.ai',
          'muser/webp/post_507602102041413.webp'),
    );
    print('request1 end ${response.metrics}');
    return null;
  }

  Future<List<Book>?> _findMatchingBooks2(String query) async {
    https: //s1-resource-dev.museland.ai/muser/webp/post_507602102041413.webp
    final response = await _client.get(
      Uri.https('s1-resource-dev.museland.ai',
          'muser/webp/post_507269124975429.webp'),
    );
    print('request2 end ${response.metrics}');
    return null;
  }

  void _runSearch(String query) {
    _lastQuery = query;
    if (query.isEmpty) {
      setState(() {
        _books = null;
      });
      return;
    }

    _findMatchingBooks(query);
    // _findMatchingBooks1(query);
    // _findMatchingBooks2(query);

    // Avoid the situation where a slow-running query finishes late and
    // replaces newer search results.
  }

  @override
  Widget build(BuildContext context) {
    final searchResult = _books == null
        ? const Text('Please enter a query', style: TextStyle(fontSize: 24))
        : _books!.isNotEmpty
            ? BookList(_books!)
            : const Text('No results found', style: TextStyle(fontSize: 24));

    return Scaffold(
      appBar: AppBar(title: const Text('Book Search')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: _runSearch,
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: searchResult),
          ],
        ),
      ),
    );
  }
}

class BookList extends StatefulWidget {
  final List<Book> books;
  const BookList(this.books, {super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget.books.length,
        itemBuilder: (context, index) => Card(
          key: ValueKey(widget.books[index].title),
          child: ListTile(
            leading: Image(
                image: HttpImageProvider(
                    widget.books[index].imageUrl.replace(scheme: 'https'),
                    client: context.read<Client>())),
            title: Text(widget.books[index].title),
            subtitle: Text(widget.books[index].description),
          ),
        ),
      );
}
