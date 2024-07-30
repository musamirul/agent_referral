class AgentUserModel {
  final String? agentId;
  final String? agentNumber;
  final String? agentOption;
  final bool? approved;
  final String? email;
  final String? fullName;
  final String? icNumber;
  final String? image;
  final String? insuranceOption;
  final String? phoneNumber;

  AgentUserModel(
      {required this.agentId,
      required this.agentNumber,
      required this.agentOption,
      required this.approved,
      required this.email,
      required this.fullName,
      required this.icNumber,
      required this.image,
      required this.insuranceOption,
      required this.phoneNumber});

  AgentUserModel.fromJson(Map<String, Object?> json)
      : this(
          agentId: json['agentId']! as String,
          agentNumber: json['agentNumber']! as String,
          agentOption: json['agentOption']! as String,
          approved: json['approved']! as bool,
          email: json['email']! as String,
          fullName: json['fullName']! as String,
          icNumber: json['icNumber']! as String,
          image: json['image']! as String,
          insuranceOption: json['insuranceOption']! as String,
          phoneNumber: json['phoneNumber']! as String,
        );

  Map<String,Object?> toJson(){
    return{
      'agentId':agentId,
      'agentNumber':agentNumber,
      'agentOption':agentOption,
      'approved':approved,
      'email':email,
      'fullName':fullName,
      'icNumber':icNumber,
      'image':image,
      'insuranceOption':insuranceOption,
      'phoneNumber':phoneNumber,
    };
  }
}
