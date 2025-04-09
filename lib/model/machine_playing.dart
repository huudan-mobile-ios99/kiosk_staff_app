class MachinePlaingListModel{
	final List<MachinePlayingModel> list;

  MachinePlaingListModel({
    required this.list,
  });

		factory MachinePlaingListModel.fromJson(List<dynamic> parsedJson) {

    List<MachinePlayingModel> photos = [];
				photos = parsedJson.map(
						(i)=>MachinePlayingModel.fromJson(i)
				).toList();

    return  MachinePlaingListModel(
       list: photos,
    );
  }
}


class MachinePlayingModel {
    int customerId;
    int number;
    String preferredName;
    List<String> machineNumber;
    DateTime startGamingDate;
    dynamic endDateTime;
    int status;
    double winLoss;
    List<DetailMachinePlaying> detail;

    MachinePlayingModel({
        required this.customerId,
        required this.number,
        required this.preferredName,
        required this.machineNumber,
        required this.startGamingDate,
        required this.endDateTime,
        required this.status,
        required this.winLoss,
        required this.detail,
    });

    factory MachinePlayingModel.fromJson(Map<String, dynamic> json) => MachinePlayingModel(
        customerId: json["CustomerID"],
        number: json["Number"],
        preferredName: json["PreferredName"],
       machineNumber: List<String>.from(json["MachineNumber"]), //
        startGamingDate: DateTime.parse(json["StartGamingDate"]),
        endDateTime: json["EndDateTime"],
        status: json["Status"],
        winLoss: json["WinLoss"]?.toDouble(),
        detail: List<DetailMachinePlaying>.from(json["Detail"].map((x) => DetailMachinePlaying.fromJson(x))),
    );
   
}

class DetailMachinePlaying {
    DateTime sessionStartDateTime;
    DateTime sessionEndDateTime;
    String machineNumber;
    double winLoss;

    DetailMachinePlaying({
        required this.sessionStartDateTime,
        required this.sessionEndDateTime,
        required this.machineNumber,
        required this.winLoss,
    });

    factory DetailMachinePlaying.fromJson(Map<String, dynamic> json) => DetailMachinePlaying(
        sessionStartDateTime: DateTime.parse(json["SessionStartDateTime"]),
        sessionEndDateTime: DateTime.parse(json["SessionEndDateTime"]),
        machineNumber: json["MachineNumber"],
        winLoss: json["WinLoss"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "SessionStartDateTime": sessionStartDateTime.toIso8601String(),
        "SessionEndDateTime": sessionEndDateTime.toIso8601String(),
        "MachineNumber": machineNumber,
        "WinLoss": winLoss,
    };
}
