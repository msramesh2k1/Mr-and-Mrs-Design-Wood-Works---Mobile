// class AddressModel {
//   String name;
//   String phoneNumber;
//   String flatNumber;
//   String city;
//   String state;
//   String pincode;
//   String street1;
//   String street2;
//   String country;

//   AddressModel(
//       {this.name,
//       this.phoneNumber,
//       this.flatNumber,
//       this.city,
//       this.state,
//       this.pincode,
//       this.street1,
//       this.street2,
//       this.country});

//   AddressModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     phoneNumber = json['phoneNumber'];
//     flatNumber = json['flatNumber'];
//     city = json['city'];
//     state = json['state'];
//     pincode = json['pincode'];
//     street1 = json['street1'];
//     street2 = json["street2"];
//     country = json['country'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['phoneNumber'] = this.phoneNumber;
//     data['flatNumber'] = this.flatNumber;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['pincode'] = this.pincode;
//     data['street1'] = this.street1;
//     data['street2'] = this.street2;
//     data['country'] = this.country;
//     return data;
//   }
// }
