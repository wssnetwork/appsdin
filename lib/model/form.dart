class FormUpdate {
  String nama;
  String masa;
  String berat;

  FormUpdate(this.nama, this.masa, this.berat);

  //String toParams() => "?nama=$_nama&masa=$_masa&berat=$_berat";

  factory FormUpdate.fromJson(Map<String, dynamic> json) {
    return FormUpdate("${json['nama']}", "${json['masa']}", "${json['berat']}");
  }

  // Method to make GET parameters.
  Map<String, dynamic> toJson() => {'nama': nama, 'masa': masa, 'berat': berat};
}
