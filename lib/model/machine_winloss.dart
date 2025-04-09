import 'package:vegas_point_portal/model/machine_playing.dart';

class MachineWinLossList{
	final List<DetailMachinePlaying> list;

  MachineWinLossList({
    required this.list,
  });

		factory MachineWinLossList.fromJson(List<dynamic> parsedJson) {

    List<DetailMachinePlaying> photos = [];
				photos = parsedJson.map(
						(i)=>DetailMachinePlaying.fromJson(i)
				).toList();

    return  MachineWinLossList(
       list: photos,
    );
  }
}




class MachineWinLoss {
    int number;
    DateTime gamingDate;
    DateTime entryDateTime;
    DateTime sessionStartDateTime;
    DateTime sessionEndDateTime;
    List<String> machineNumber;
    double winLoss;

    MachineWinLoss({
        required this.number,
        required this.gamingDate,
        required this.entryDateTime,
        required this.sessionStartDateTime,
        required this.sessionEndDateTime,
        required this.machineNumber,
        required this.winLoss,
    });

    factory MachineWinLoss.fromJson(Map<String, dynamic> json) => MachineWinLoss(
        number: json["Number"],
        gamingDate: DateTime.parse(json["GamingDate"]),
        entryDateTime: DateTime.parse(json["EntryDateTime"]),
        sessionStartDateTime: DateTime.parse(json["SessionStartDateTime"]),
        sessionEndDateTime: DateTime.parse(json["SessionEndDateTime"]),
         machineNumber: List<String>.from(json["MachineNumber"]), //
        winLoss: json["WinLoss"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Number": number,
        "GamingDate": gamingDate.toIso8601String(),
        "EntryDateTime": entryDateTime.toIso8601String(),
        "SessionStartDateTime": sessionStartDateTime.toIso8601String(),
        "SessionEndDateTime": sessionEndDateTime.toIso8601String(),
        "MachineNumber": machineNumber,
        "WinLoss": winLoss,
    };
}