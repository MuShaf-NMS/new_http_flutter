import 'package:flutter/material.dart';
import 'package:http_flutter/app/apiservice/apiservice.dart';
import 'package:http_flutter/app/models/siswa.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddSiswa extends StatefulWidget {
  @override
  _AddSiswaState createState() => _AddSiswaState();
}

class _AddSiswaState extends State<AddSiswa> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerT_lahir = TextEditingController();
  String jl;
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
        title: Text('Tambah Siswa'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
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
              Padding(padding: EdgeInsets.all(5)),
              Text(
                'Jenis Kelamain',
                style: TextStyle(fontSize: 16),
              ),
              ListTile(
                title: Text('L'),
                leading: Radio(
                    value: 'L',
                    groupValue: jl,
                    onChanged: (value) {
                      jl = value;
                      setState(() {});
                    }),
              ),
              ListTile(
                title: Text('P'),
                leading: Radio(
                    value: 'P',
                    groupValue: jl,
                    onChanged: (value) {
                      jl = value;
                      setState(() {});
                    }),
              ),
              IconButton(
                  icon: Icon(Icons.file_upload),
                  onPressed: () {
                    setState(() {});
                    Siswa siswa = Siswa(
                        nama: controllerNama.text,
                        alamat: controllerAlamat.text,
                        t_lahir: controllerT_lahir.text,
                        jl: jl);
                    apiServices.postData(siswa).then((value) {
                      if (value) {
                        Navigator.pop(
                            _scaffoldState.currentState.context, value);
                      }
                    });
                  }),
            ],
          ),
        ),
      ),
    );
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
