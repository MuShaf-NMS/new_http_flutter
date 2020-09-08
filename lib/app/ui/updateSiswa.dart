import 'package:flutter/material.dart';
import 'package:http_flutter/app/apiservice/apiservice.dart';
import 'package:http_flutter/app/models/siswa.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class UpdateSiswa extends StatefulWidget {
  int id;
  UpdateSiswa({this.id});
  @override
  _UpdateSiswaState createState() => _UpdateSiswaState();
}

class _UpdateSiswaState extends State<UpdateSiswa> {
  TextEditingController controllerNama;
  TextEditingController controllerAlamat;
  TextEditingController controllerT_lahir;
  TextEditingController controllerJl;
  void setSiswa(String nama, alamat, t_lahir, jl) {
    controllerNama = TextEditingController(text: nama);
    controllerAlamat = TextEditingController(text: alamat);
    controllerT_lahir = TextEditingController(text: t_lahir);
    controllerJl = TextEditingController(text: jl);
  }

  ApiServices apiServices;
  @override
  void initState() {
    apiServices = ApiServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text('Edit'),
        ),
        body: Card(
            child: Container(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: FutureBuilder(
                      future: apiServices.getSiswa(widget.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<Siswa> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          setSiswa(snapshot.data.nama, snapshot.data.alamat,
                              snapshot.data.t_lahir, snapshot.data.jl);
                          return ListView(children: <Widget>[
                            FormSiswa(
                              controller: controllerNama,
                              label: 'Nama',
                            ),
                            FormSiswa(
                              controller: controllerAlamat,
                              label: 'Alamat',
                            ),
                            FormSiswa(
                              controller: controllerT_lahir,
                              label: 'Tanggal lahir',
                            ),
                            FormSiswa(
                              controller: controllerJl,
                              label: 'Jenis kelamin',
                            ),
                            IconButton(
                                icon: Icon(Icons.file_upload),
                                onPressed: () {
                                  Siswa siswa = Siswa(
                                      nama: controllerNama.text,
                                      alamat: controllerAlamat.text,
                                      t_lahir: controllerT_lahir.text,
                                      jl: controllerJl.text);
                                  apiServices
                                      .putData(siswa, widget.id)
                                      .then((value) {
                                    if (value) {
                                      Navigator.pop(
                                          _scaffoldState.currentState.context,
                                          value);
                                    }
                                  });
                                }),
                          ]);
                        }
                        return CircularProgressIndicator();
                      }),
                ))));
  }
}

class FormSiswa extends StatelessWidget {
  TextEditingController controller;
  String label;
  FormSiswa({this.controller, this.label});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}
