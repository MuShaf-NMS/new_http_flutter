import 'package:flutter/material.dart';
import 'package:http_flutter/app/apiservice/apiservice.dart';
import 'package:http_flutter/app/models/siswa.dart';
import 'package:http_flutter/app/ui/addSiswa.dart';
import 'package:http_flutter/app/ui/updateSiswa.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  String token;
  Home({this.token});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext context;
  ApiServices apiServices;
  @override
  void initState() {
    super.initState();
    apiServices = ApiServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.red,
              ),
              onPressed: () async {
                var result = await Navigator.push(
                    _scaffoldState.currentContext,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddSiswa(
                              token: widget.token,
                            )));
                if (result != null) {
                  setState(() {});
                }
              })
        ],
        title: Text('halo'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: apiServices.getData(widget.token),
            builder:
                (BuildContext context, AsyncSnapshot<List<Siswa>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Card(
                      margin: EdgeInsets.all(15),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Tampil(
                                snapshot.data[i].id,
                                snapshot.data[i].nama,
                                snapshot.data[i].alamat,
                                snapshot.data[i].t_lahir,
                                snapshot.data[i].jl),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                    child: Text('Edit'),
                                    onPressed: () async {
                                      var result = await Navigator.push(
                                          _scaffoldState.currentContext,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  UpdateSiswa(
                                                    id: snapshot.data[i].id,
                                                    token: widget.token,
                                                  )));
                                      if (result != null) {
                                        setState(() {});
                                      }
                                    }),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                RaisedButton(
                                    child: Text('Hapus'),
                                    onPressed: () {
                                      apiServices
                                          .delete(
                                              snapshot.data[i].id, widget.token)
                                          .then((value) {
                                        if (value) {
                                          setState(() {});
                                        }
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class Tampil extends StatefulWidget {
  String nama, alamat, t_lahir, jl;
  int id;

  Tampil(this.id, this.nama, this.alamat, this.t_lahir, this.jl);

  @override
  _TampilState createState() => _TampilState();
}

class _TampilState extends State<Tampil> {
  double size = 15;
  ApiServices apiServices;
  @override
  void initState() {
    apiServices = ApiServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Id : ',
              style: TextStyle(fontSize: size),
            ),
            Text(
              widget.id.toString(),
              style: TextStyle(fontSize: size),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Nama : ',
              style: TextStyle(fontSize: size),
            ),
            Text(
              widget.nama,
              style: TextStyle(fontSize: size),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Alamat : ',
              style: TextStyle(fontSize: size),
            ),
            Text(
              widget.alamat,
              style: TextStyle(fontSize: size),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Tanggal lahir : ',
              style: TextStyle(fontSize: size),
            ),
            Text(
              widget.t_lahir,
              style: TextStyle(fontSize: size),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Jenis kelamin : ',
              style: TextStyle(fontSize: size),
            ),
            Text(
              widget.jl,
              style: TextStyle(fontSize: size),
            )
          ],
        ),
      ],
    );
  }
}
