import 'package:flutter/material.dart';
import 'package:tester/cache/shared_cache.dart';
import 'package:tester/home_screen.dart';
import 'package:tester/model/machine_loan_model.dart';
import 'package:tester/service/machine_service.dart';

class MachineLoan extends StatefulWidget {
  @override
  _MachineLoanState createState() => _MachineLoanState();
}

class _MachineLoanState extends State<MachineLoan> {
  int _selectedMachineCount = 1;
  bool _dryerRequired = false;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Seçilen Tarih: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(Icons.calendar_today, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Makine Adeti:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedMachineCount = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedMachineCount == 1
                              ? Colors.blue
                              : Colors.grey[700],
                        ),
                        child: Text("1"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedMachineCount = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedMachineCount == 2
                              ? Colors.blue
                              : Colors.grey[700],
                        ),
                        child: Text("2"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kurutma Gerekli mi?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _dryerRequired,
                    onChanged: (value) {
                      setState(() {
                        _dryerRequired = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: LoanButton(
                      selectedDate: selectedDate,
                      selectedMachineCount: _selectedMachineCount,
                      dryerRequired: _dryerRequired),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Hayır", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoanButton extends StatefulWidget {
  const LoanButton({
    super.key,
    required this.selectedDate,
    required int selectedMachineCount,
    required bool dryerRequired,
  })  : _selectedMachineCount = selectedMachineCount,
        _dryerRequired = dryerRequired;

  final DateTime selectedDate;
  final int _selectedMachineCount;
  final bool _dryerRequired;

  @override
  State<LoanButton> createState() => _LoanButtonState();
}

class _LoanButtonState extends State<LoanButton> {
  late final SharedManager _manager;
  List<String>? _cachedPassword;
  String? _bearerToken; // Bearer Token için değişken

  @override
  void initState() {
    super.initState();
    _manager = SharedManager();
    _loadCachedData();
  }

  Future<void> _loadCachedData() async {
    await _manager.init(); // SharedPreferences başlat
    List<String>? cachedData = await _manager.getStringList(SharedKeys.counter);

    setState(() {
      _cachedPassword = cachedData;
      _bearerToken = cachedData?[0]; // Bearer Token'i cachedPassword[0]'dan al
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_bearerToken == null) {
          // Bearer Token kontrolü
          print("Bearer Token bulunamadı.");
          return;
        }

        LoanService loanService =
            LoanService(_bearerToken!); // Bearer Token ile LoanService oluştur

        LoanModel loanData = LoanModel(
          userToken: _bearerToken!,
          machineType: widget._dryerRequired
              ? "DRYER"
              : "NORMAL", // DRYER veya NORMAL olarak işaretle
          machineCount: widget._selectedMachineCount.toString(), // Makine adeti
        );

        LoanModel? response = await loanService.loanPost(loanData);

        if (response != null) {
          print("Loan başarıyla gönderildi: ${response.toJson()}");
        } else {
          print("Loan gönderme başarısız.");
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text("Onay", style: TextStyle(color: Colors.white)),
            content: Text(
              "Seçimleriniz kaydedildi:\n"
              "Tarih: ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}\n"
              "Makine Adeti: ${widget._selectedMachineCount}\n"
              "Kurutma: ${widget._dryerRequired ? "DRYER" : "NORMAL"}",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Tamam", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text("Evet", style: TextStyle(fontSize: 18)),
    );
  }
}
